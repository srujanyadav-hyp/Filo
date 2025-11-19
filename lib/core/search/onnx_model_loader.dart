import 'dart:math' as math;
import 'package:onnxruntime/onnxruntime.dart';
import 'package:flutter/services.dart' show rootBundle;

/// ONNX Model Loader for all-MiniLM-L6-v2 embedding model
///
/// Loads and manages the ONNX model for generating 384-dimensional embeddings
/// Model: sentence-transformers/all-MiniLM-L6-v2
/// Per search_architecture_ultra.md: 384-D vector, on-device inference
class OnnxModelLoader {
  OrtSession? _session;
  OrtSessionOptions? _sessionOptions;
  bool _isInitialized = false;

  /// Initialize the ONNX model
  ///
  /// Loads model from assets and creates inference session
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Create session options
      _sessionOptions = OrtSessionOptions();

      // Load model from assets
      // Note: Model file should be placed in assets/models/all-MiniLM-L6-v2.onnx
      final modelData = await rootBundle.load(
        'assets/models/all-MiniLM-L6-v2.onnx',
      );
      final modelBytes = modelData.buffer.asUint8List();

      // Create inference session
      _session = OrtSession.fromBuffer(modelBytes, _sessionOptions!);

      _isInitialized = true;
    } catch (e) {
      // If model loading fails, use placeholder mode
      // This allows the app to work without the ONNX model file
      _isInitialized = false;
      rethrow;
    }
  }

  /// Generate embeddings for text using ONNX model
  ///
  /// Returns 384-dimensional float32 vector
  Future<List<double>> generateEmbedding(String text) async {
    if (!_isInitialized || _session == null) {
      throw StateError('ONNX model not initialized. Call initialize() first.');
    }

    try {
      // Tokenize input text (simplified - real implementation would use proper tokenizer)
      final tokens = _tokenize(text);

      // Create input tensor
      final inputIds = OrtValueTensor.createTensorWithDataList(
        [tokens],
        [1, tokens.length],
      );

      // Run inference
      final outputs = _session!.run(OrtRunOptions(), {'input_ids': inputIds});

      // Extract embedding from output (assuming first output is the embedding)
      // Note: ONNX outputs are indexed by integer position, not by name
      final outputTensor = outputs[0];
      final embedding = outputTensor?.value as List<List<double>>?;

      if (embedding == null) {
        throw Exception('Failed to extract embedding from ONNX output');
      }

      // Mean pooling over sequence dimension
      final pooled = _meanPooling(embedding);

      // Normalize to unit length
      final normalized = _normalize(pooled);

      inputIds.release();
      // Release all output tensors
      for (var i = 0; i < outputs.length; i++) {
        outputs[i]?.release();
      }

      return normalized;
    } catch (e) {
      throw Exception('Failed to generate embedding: $e');
    }
  }

  /// Simple tokenization (placeholder)
  ///
  /// Real implementation would use SentencePiece or WordPiece tokenizer
  List<int> _tokenize(String text) {
    // Simplified tokenization - split by whitespace and convert to char codes
    // This is a placeholder; real tokenization would use proper vocabulary
    final words = text.toLowerCase().split(RegExp(r'\s+'));
    final tokens = <int>[];

    // Add CLS token
    tokens.add(101);

    // Convert words to token IDs (simplified)
    for (final word in words) {
      for (final char in word.codeUnits) {
        tokens.add(char % 30000); // Map to vocabulary range
      }
    }

    // Add SEP token
    tokens.add(102);

    // Pad to fixed length (128 tokens)
    while (tokens.length < 128) {
      tokens.add(0);
    }

    return tokens.take(128).toList();
  }

  /// Mean pooling over sequence dimension
  List<double> _meanPooling(List<List<double>> embeddings) {
    if (embeddings.isEmpty) return List.filled(384, 0.0);

    final seqLen = embeddings.length;
    final embDim = embeddings[0].length;
    final result = List.filled(embDim, 0.0);

    for (var i = 0; i < embDim; i++) {
      var sum = 0.0;
      for (var j = 0; j < seqLen; j++) {
        sum += embeddings[j][i];
      }
      result[i] = sum / seqLen;
    }

    return result;
  }

  /// Normalize vector to unit length
  List<double> _normalize(List<double> vector) {
    var norm = 0.0;
    for (final val in vector) {
      norm += val * val;
    }
    norm = math.sqrt(norm);

    if (norm == 0) return vector;

    return vector.map((v) => v / norm).toList();
  }

  /// Check if model is initialized
  bool get isInitialized => _isInitialized;

  /// Dispose resources
  void dispose() {
    _session?.release();
    _sessionOptions?.release();
    _session = null;
    _sessionOptions = null;
    _isInitialized = false;
  }
}
