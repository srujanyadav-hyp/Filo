// File Indexing Service - Main orchestrator for 8-step indexing pipeline
// Refs: phase4_plan.md Task 1, feature_specs_ultra.md FEATURE 1

import 'package:drift/drift.dart';
import '../../data/db/database.dart';
import 'file_reader.dart';
import 'metadata_extractor.dart';
import 'mime_detector.dart';
import 'ocr_processor.dart';
import 'image_labeler.dart';
import 'embedding_generator.dart';
import 'index_finalizer.dart';

/// Result of complete file indexing operation
class IndexingResult {
  final int? fileId;
  final bool success;
  final String? error;
  final Duration duration;

  IndexingResult.success(this.fileId, this.duration)
    : success = true,
      error = null;

  IndexingResult.failure(this.error, this.duration)
    : success = false,
      fileId = null;
}

/// Complete file indexing pipeline orchestrator
///
/// Implements 8-step pipeline per spec:
/// 1. SAF URI Read
/// 2. Metadata Normalization
/// 3. MIME Inference
/// 4. OCR Text Extraction
/// 5. ML Image Labeling
/// 6. Vector Embedding Generation
/// 7. FTS5 Insertion
/// 8. Index Integrity Check
class FileIndexingService {
  final FiloDatabase _database;
  final FileReader _fileReader;
  final MetadataExtractor _metadataExtractor;
  final MimeDetector _mimeDetector;
  final OcrProcessor _ocrProcessor;
  final ImageLabelerService _imageLabeler;
  final EmbeddingGenerator _embeddingGenerator;
  final IndexFinalizer _indexFinalizer;

  FileIndexingService({
    required FiloDatabase database,
    FileReader? fileReader,
    MetadataExtractor? metadataExtractor,
    MimeDetector? mimeDetector,
    OcrProcessor? ocrProcessor,
    ImageLabelerService? imageLabeler,
    EmbeddingGenerator? embeddingGenerator,
  }) : _database = database,
       _fileReader = fileReader ?? FileReader(),
       _metadataExtractor = metadataExtractor ?? MetadataExtractor(),
       _mimeDetector = mimeDetector ?? MimeDetector(),
       _ocrProcessor = ocrProcessor ?? OcrProcessor(),
       _imageLabeler = imageLabeler ?? ImageLabelerService(),
       _embeddingGenerator = embeddingGenerator ?? EmbeddingGenerator(),
       _indexFinalizer = IndexFinalizer(database);

  /// Index a single file through complete 8-step pipeline
  Future<IndexingResult> indexFile(String uri) async {
    final startTime = DateTime.now();

    try {
      // STEP 1: Read file from SAF URI (with retry)
      final readResult = await _fileReader.readFile(uri);
      if (!readResult.success) {
        return _failureResult('Step 1 failed: ${readResult.error}', startTime);
      }

      final metadataResult = await _fileReader.readMetadata(uri);
      if (!metadataResult.success) {
        return _failureResult(
          'Step 1 (metadata) failed: ${metadataResult.error}',
          startTime,
        );
      }

      // STEP 2: Detect MIME type
      final mimeType = _mimeDetector.detectMimeType(
        filePath: uri,
        fileData: readResult.data,
      );

      // STEP 3: Extract and normalize metadata
      final fileCompanion = _metadataExtractor.extractMetadata(
        uri: uri,
        mimeType: mimeType,
        size: metadataResult.size!,
        createdAt: metadataResult.created!,
        modifiedAt: metadataResult.modified!,
        fileData: readResult.data!,
      );

      // Insert file record
      final fileId = await _database.filesDao.insertFile(fileCompanion);

      // STEP 4: OCR text extraction (if applicable)
      if (_mimeDetector.supportsOcr(mimeType)) {
        final ocrResult = await _ocrProcessor.extractText(
          filePath: uri,
          mimeType: mimeType,
        );

        if (ocrResult.success && ocrResult.text.isNotEmpty) {
          // Store extracted text
          await _database
              .into(_database.extractedText)
              .insert(
                ExtractedTextCompanion.insert(
                  fileId: fileId,
                  content: ocrResult.text,
                  confidence: Value(ocrResult.confidence),
                ),
              );

          // STEP 7: Insert into FTS5 table for full-text search
          await _insertIntoFts(
            fileId,
            fileCompanion.normalizedName.value,
            ocrResult.text,
          );
        }
      }

      // STEP 5: ML image labeling (if applicable)
      if (_mimeDetector.isImage(mimeType)) {
        final labelResult = await _imageLabeler.labelImage(
          filePath: uri,
          mimeType: mimeType,
        );

        if (labelResult.success && labelResult.labels.isNotEmpty) {
          // Store labels (one row per label)
          for (int i = 0; i < labelResult.labels.length; i++) {
            await _database
                .into(_database.imageLabels)
                .insert(
                  ImageLabelsCompanion.insert(
                    fileId: fileId,
                    label: labelResult.labels[i],
                    confidence: labelResult.confidences[i],
                  ),
                );
          }
        }
      }

      // STEP 6: Generate embedding vector
      final textForEmbedding = await _getTextForEmbedding(fileId);
      if (textForEmbedding.isNotEmpty) {
        final embeddingResult = await _embeddingGenerator.generateEmbedding(
          textForEmbedding,
        );

        if (embeddingResult.success) {
          await _database
              .into(_database.embeddings)
              .insert(
                EmbeddingsCompanion.insert(
                  fileId: fileId,
                  vector: embeddingResult.vector,
                  dim: embeddingResult.dimensions,
                  modelVersion: embeddingResult.modelVersion,
                ),
              );
        }
      }

      // STEP 8: Finalize indexing and log activity
      final finalized = await _indexFinalizer.finalizeIndex(
        fileId: fileId,
        uri: uri,
      );

      if (!finalized) {
        return _failureResult('Step 8 (finalization) failed', startTime);
      }

      final duration = DateTime.now().difference(startTime);
      return IndexingResult.success(fileId, duration);
    } catch (e) {
      return _failureResult('Unexpected error: $e', startTime);
    }
  }

  /// Index multiple files (batch operation)
  Future<List<IndexingResult>> indexFiles(List<String> uris) async {
    final results = <IndexingResult>[];

    for (final uri in uris) {
      final result = await indexFile(uri);
      results.add(result);
    }

    return results;
  }

  /// Get text content for embedding generation
  Future<String> _getTextForEmbedding(int fileId) async {
    final textEntries = await (_database.select(
      _database.extractedText,
    )..where((t) => t.fileId.equals(fileId))).get();

    if (textEntries.isEmpty) {
      return '';
    }

    return textEntries.first.content;
  }

  /// Insert into FTS5 table for full-text search
  Future<void> _insertIntoFts(
    int fileId,
    String fileName,
    String content,
  ) async {
    await _database.customInsert(
      'INSERT INTO files_fts (rowid, normalized_name, content) VALUES (?, ?, ?)',
      variables: [
        Variable<int>(fileId),
        Variable<String>(fileName),
        Variable<String>(content),
      ],
      updates: {_database.filesFts},
    );
  }

  /// Helper to create failure result
  IndexingResult _failureResult(String error, DateTime startTime) {
    final duration = DateTime.now().difference(startTime);
    return IndexingResult.failure(error, duration);
  }

  /// Dispose resources
  void dispose() {
    _ocrProcessor.dispose();
    _imageLabeler.dispose();
  }
}
