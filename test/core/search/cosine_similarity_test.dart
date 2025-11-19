import 'package:flutter_test/flutter_test.dart';
import 'package:filo/core/search/cosine_similarity.dart';
import 'dart:math' as math;

void main() {
  group('CosineSimilarityCalculator', () {
    group('calculate', () {
      test('identical vectors should return 1.0', () {
        final v1 = [1.0, 0.0, 0.0];
        final v2 = [1.0, 0.0, 0.0];

        final similarity = CosineSimilarityCalculator.calculate(v1, v2);

        expect(similarity, 1.0);
      });

      test('orthogonal vectors should return 0.0', () {
        final v1 = [1.0, 0.0];
        final v2 = [0.0, 1.0];

        final similarity = CosineSimilarityCalculator.calculate(v1, v2);

        expect(similarity, closeTo(0.0, 0.0001));
      });

      test('opposite vectors should return -1.0', () {
        final v1 = [1.0, 0.0, 0.0];
        final v2 = [-1.0, 0.0, 0.0];

        final similarity = CosineSimilarityCalculator.calculate(v1, v2);

        expect(similarity, closeTo(-1.0, 0.0001));
      });

      test('45 degree angle vectors should return 0.707', () {
        final v1 = [1.0, 0.0];
        final v2 = [1.0, 1.0];

        final similarity = CosineSimilarityCalculator.calculate(v1, v2);

        // cos(45°) = 1/sqrt(2) ≈ 0.707
        expect(similarity, closeTo(1.0 / math.sqrt(2), 0.0001));
      });

      test('should handle normalized vectors', () {
        final v1 = [0.6, 0.8]; // Already normalized (magnitude = 1)
        final v2 = [0.8, 0.6];

        final similarity = CosineSimilarityCalculator.calculate(v1, v2);

        // dot product = 0.6*0.8 + 0.8*0.6 = 0.96
        expect(similarity, closeTo(0.96, 0.0001));
      });

      test('should handle multi-dimensional vectors', () {
        final v1 = [1.0, 2.0, 3.0, 4.0, 5.0];
        final v2 = [5.0, 4.0, 3.0, 2.0, 1.0];

        final similarity = CosineSimilarityCalculator.calculate(v1, v2);

        // dot product = 1*5 + 2*4 + 3*3 + 4*2 + 5*1 = 35
        // mag1 = sqrt(1+4+9+16+25) = sqrt(55)
        // mag2 = sqrt(25+16+9+4+1) = sqrt(55)
        // similarity = 35 / 55 = 0.636...
        expect(similarity, closeTo(35.0 / 55.0, 0.0001));
      });

      test('should throw ArgumentError for different dimensions', () {
        final v1 = [1.0, 2.0, 3.0];
        final v2 = [1.0, 2.0];

        expect(
          () => CosineSimilarityCalculator.calculate(v1, v2),
          throwsArgumentError,
        );
      });

      test('should return 0.0 for zero magnitude vector', () {
        final v1 = [1.0, 2.0, 3.0];
        final v2 = [0.0, 0.0, 0.0];

        final similarity = CosineSimilarityCalculator.calculate(v1, v2);

        expect(similarity, 0.0);
      });

      test('should handle empty vectors', () {
        final v1 = <double>[];
        final v2 = <double>[];

        final similarity = CosineSimilarityCalculator.calculate(v1, v2);

        expect(similarity, 0.0);
      });

      test('should handle negative values', () {
        final v1 = [-1.0, -2.0, -3.0];
        final v2 = [1.0, 2.0, 3.0];

        final similarity = CosineSimilarityCalculator.calculate(v1, v2);

        // dot product = -1 -4 -9 = -14
        // magnitudes are both sqrt(14)
        // similarity = -14 / 14 = -1.0
        expect(similarity, closeTo(-1.0, 0.0001));
      });

      test('should handle small values', () {
        final v1 = [0.001, 0.002, 0.003];
        final v2 = [0.003, 0.002, 0.001];

        final similarity = CosineSimilarityCalculator.calculate(v1, v2);

        expect(similarity, greaterThan(0.0));
        expect(similarity, lessThan(1.0));
      });
    });

    group('calculateBatch', () {
      test('should calculate similarities for multiple documents', () {
        final query = [1.0, 0.0, 0.0];
        final documents = [
          [1.0, 0.0, 0.0], // Identical
          [0.0, 1.0, 0.0], // Orthogonal
          [-1.0, 0.0, 0.0], // Opposite
        ];

        final similarities = CosineSimilarityCalculator.calculateBatch(
          query,
          documents,
        );

        expect(similarities.length, 3);
        expect(similarities[0], closeTo(1.0, 0.0001));
        expect(similarities[1], closeTo(0.0, 0.0001));
        expect(similarities[2], closeTo(-1.0, 0.0001));
      });

      test('should return empty list for empty documents', () {
        final query = [1.0, 2.0, 3.0];
        final documents = <List<double>>[];

        final similarities = CosineSimilarityCalculator.calculateBatch(
          query,
          documents,
        );

        expect(similarities, isEmpty);
      });

      test('should handle large batch', () {
        final query = [1.0, 0.0];
        final documents = List.generate(100, (i) {
          final angle = (i / 100) * math.pi * 2;
          return [math.cos(angle), math.sin(angle)];
        });

        final similarities = CosineSimilarityCalculator.calculateBatch(
          query,
          documents,
        );

        expect(similarities.length, 100);
        expect(similarities[0], closeTo(1.0, 0.0001)); // 0 degrees
        expect(similarities[25], closeTo(0.0, 0.0001)); // 90 degrees
        expect(similarities[50], closeTo(-1.0, 0.0001)); // 180 degrees
      });
    });

    group('findTopK', () {
      test('should return top K most similar document indices', () {
        final query = [1.0, 0.0];
        final documents = [
          [1.0, 0.0], // 0: similarity 1.0
          [0.0, 1.0], // 1: similarity 0.0
          [0.9, 0.1], // 2: similarity ~0.99
          [-1.0, 0.0], // 3: similarity -1.0
          [0.8, 0.2], // 4: similarity ~0.98
        ];

        final topK = CosineSimilarityCalculator.findTopK(query, documents, 3);

        expect(topK.length, 3);
        expect(topK[0], 0); // Most similar
        expect(topK[1], 2); // Second most similar
        expect(topK[2], 4); // Third most similar
      });

      test('should return all indices when k >= document count', () {
        final query = [1.0, 0.0];
        final documents = [
          [1.0, 0.0],
          [0.0, 1.0],
        ];

        final topK = CosineSimilarityCalculator.findTopK(query, documents, 10);

        expect(topK.length, 2);
      });

      test('should return empty list for k = 0', () {
        final query = [1.0, 0.0];
        final documents = [
          [1.0, 0.0],
          [0.0, 1.0],
        ];

        final topK = CosineSimilarityCalculator.findTopK(query, documents, 0);

        expect(topK, isEmpty);
      });

      test('should handle negative similarities correctly', () {
        final query = [1.0, 0.0];
        final documents = [
          [-1.0, 0.0], // 0: similarity -1.0
          [-0.5, 0.5], // 1: similarity ~-0.35
          [0.0, 1.0], // 2: similarity 0.0
          [0.5, 0.5], // 3: similarity ~0.35
          [1.0, 0.0], // 4: similarity 1.0
        ];

        final topK = CosineSimilarityCalculator.findTopK(query, documents, 3);

        expect(topK[0], 4); // 1.0 is highest
        expect(topK[1], 3); // 0.35 is second
        expect(topK[2], 2); // 0.0 is third
      });

      test('should maintain order for equal similarities', () {
        final query = [1.0, 0.0];
        final documents = [
          [1.0, 0.0], // 0: similarity 1.0
          [1.0, 0.0], // 1: similarity 1.0
          [1.0, 0.0], // 2: similarity 1.0
        ];

        final topK = CosineSimilarityCalculator.findTopK(query, documents, 2);

        expect(topK.length, 2);
        expect(topK, contains(0));
        expect(topK, contains(1));
      });
    });
  });
}
