// Image Labeler - Step 5 of File Indexing Pipeline
// Refs: phase4_plan.md Task 1, feature_specs_ultra.md FEATURE 1

import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';

/// Result of image labeling
class ImageLabelingResult {
  final List<String> labels;
  final List<double> confidences;
  final bool success;
  final String? error;

  ImageLabelingResult.success({required this.labels, required this.confidences})
    : success = true,
      error = null;

  ImageLabelingResult.failure(this.error)
    : success = false,
      labels = const [],
      confidences = const [];

  ImageLabelingResult.skipped(String reason)
    : success = true,
      labels = const [],
      confidences = const [],
      error = reason;
}

/// Generates ML labels for images using Google ML Kit
class ImageLabelerService {
  final ImageLabeler _imageLabeler = ImageLabeler(
    options: ImageLabelerOptions(confidenceThreshold: 0.5),
  );

  /// Generate labels for image file
  ///
  /// Returns top 5 labels with confidence scores.
  /// Skips processing for non-image files.
  Future<ImageLabelingResult> labelImage({
    required String filePath,
    required String mimeType,
  }) async {
    // Skip if not an image
    if (!mimeType.startsWith('image/')) {
      return ImageLabelingResult.skipped('Not an image file');
    }

    try {
      final inputImage = InputImage.fromFilePath(filePath);
      final labels = await _imageLabeler.processImage(inputImage);

      // Take top 5 labels
      final topLabels = labels.take(5).toList();

      return ImageLabelingResult.success(
        labels: topLabels.map((l) => l.label).toList(),
        confidences: topLabels.map((l) => l.confidence).toList(),
      );
    } catch (e) {
      return ImageLabelingResult.failure('Image labeling failed: $e');
    }
  }

  /// Dispose resources
  void dispose() {
    _imageLabeler.close();
  }
}
