import 'dart:math' as math;

/// Cosine Similarity Calculator
///
/// Calculates cosine similarity between embedding vectors
/// Per search_architecture_ultra.md: dot(v1, v2) / (||v1|| * ||v2||)
class CosineSimilarityCalculator {
  /// Calculate cosine similarity between two vectors
  ///
  /// Returns value between -1 and 1:
  /// - 1: identical vectors
  /// - 0: orthogonal vectors
  /// - -1: opposite vectors
  static double calculate(List<double> vector1, List<double> vector2) {
    if (vector1.length != vector2.length) {
      throw ArgumentError('Vectors must have the same dimension');
    }

    if (vector1.isEmpty) {
      return 0.0;
    }

    // Calculate dot product
    var dotProduct = 0.0;
    for (var i = 0; i < vector1.length; i++) {
      dotProduct += vector1[i] * vector2[i];
    }

    // Calculate magnitudes
    var magnitude1 = 0.0;
    var magnitude2 = 0.0;
    for (var i = 0; i < vector1.length; i++) {
      magnitude1 += vector1[i] * vector1[i];
      magnitude2 += vector2[i] * vector2[i];
    }

    magnitude1 = math.sqrt(magnitude1);
    magnitude2 = math.sqrt(magnitude2);

    // Avoid division by zero
    if (magnitude1 == 0 || magnitude2 == 0) {
      return 0.0;
    }

    // Calculate cosine similarity
    return dotProduct / (magnitude1 * magnitude2);
  }

  /// Calculate similarity for batch of vectors
  ///
  /// Returns list of similarity scores
  static List<double> calculateBatch(
    List<double> queryVector,
    List<List<double>> documentVectors,
  ) {
    return documentVectors.map((doc) => calculate(queryVector, doc)).toList();
  }

  /// Find top K most similar vectors
  ///
  /// Returns indices of top K vectors sorted by similarity (descending)
  static List<int> findTopK(
    List<double> queryVector,
    List<List<double>> documentVectors,
    int k,
  ) {
    // Calculate all similarities
    final similarities = <int, double>{};
    for (var i = 0; i < documentVectors.length; i++) {
      similarities[i] = calculate(queryVector, documentVectors[i]);
    }

    // Sort by similarity (descending)
    final sorted = similarities.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Return top K indices
    return sorted.take(k).map((e) => e.key).toList();
  }
}
