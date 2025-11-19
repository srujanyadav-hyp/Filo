import '../../data/db/database.dart';
import '../indexing/embedding_generator.dart';
import 'cosine_similarity.dart';

/// Semantic Search Service
///
/// Performs semantic search using embedding-based similarity
/// Per search_architecture_ultra.md: 384-D vectors with cosine similarity
class SemanticSearchService {
  final FiloDatabase database;
  final EmbeddingGenerator embeddingGenerator;

  SemanticSearchService(this.database, this.embeddingGenerator);

  /// Search files using semantic similarity
  ///
  /// Returns list of file IDs ranked by semantic similarity to query
  Future<List<SemanticSearchResult>> search(
    String query, {
    int limit = 20,
    double minSimilarity = 0.3,
  }) async {
    // Generate embedding for query
    final queryEmbeddingResult = await embeddingGenerator.generateEmbedding(
      query,
    );
    if (!queryEmbeddingResult.success) {
      return [];
    }
    final queryVector = _bytesToVector(queryEmbeddingResult.vector);

    // Get all file embeddings from database
    final allEmbeddings = await database.select(database.embeddings).get();

    if (allEmbeddings.isEmpty) {
      return [];
    }

    // Convert to list of vectors
    final documentVectors = <int, List<double>>{};
    for (final embedding in allEmbeddings) {
      final vector = _bytesToVector(embedding.vector);
      if (vector.isNotEmpty) {
        documentVectors[embedding.fileId] = vector;
      }
    }

    // Calculate similarities
    final results = <SemanticSearchResult>[];
    for (final entry in documentVectors.entries) {
      final similarity = CosineSimilarityCalculator.calculate(
        queryVector,
        entry.value,
      );

      if (similarity >= minSimilarity) {
        results.add(
          SemanticSearchResult(fileId: entry.key, similarity: similarity),
        );
      }
    }

    // Sort by similarity (descending) and limit
    results.sort((a, b) => b.similarity.compareTo(a.similarity));
    return results.take(limit).toList();
  }

  /// Search with file metadata included
  ///
  /// Returns full file entries with similarity scores
  Future<List<SemanticFileResult>> searchWithMetadata(
    String query, {
    int limit = 20,
    double minSimilarity = 0.3,
  }) async {
    final semanticResults = await search(
      query,
      limit: limit,
      minSimilarity: minSimilarity,
    );

    if (semanticResults.isEmpty) {
      return [];
    }

    // Get file metadata
    final fileIds = semanticResults.map((r) => r.fileId).toList();
    final files = await database.filesDao.getFilesByIds(fileIds);

    // Combine results
    final results = <SemanticFileResult>[];
    for (final result in semanticResults) {
      final file = files.firstWhere((f) => f.id == result.fileId);
      results.add(
        SemanticFileResult(file: file, similarity: result.similarity),
      );
    }

    return results;
  }

  /// Convert byte array to vector of doubles
  List<double> _bytesToVector(List<int> bytes) {
    if (bytes.isEmpty) return [];

    // Convert bytes back to doubles
    // Assuming each double is stored as 8 bytes (64-bit float)
    final vector = <double>[];
    for (var i = 0; i < bytes.length; i += 8) {
      if (i + 8 <= bytes.length) {
        // Simple conversion - in production, use proper byte conversion
        final value = bytes[i] / 255.0;
        vector.add(value);
      }
    }

    return vector;
  }
}

/// Semantic search result with file ID and similarity score
class SemanticSearchResult {
  final int fileId;
  final double similarity;

  SemanticSearchResult({required this.fileId, required this.similarity});
}

/// Semantic file result with full file entry and similarity
class SemanticFileResult {
  final FileIndexEntry file;
  final double similarity;

  SemanticFileResult({required this.file, required this.similarity});
}
