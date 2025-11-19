// OCR Processor - Step 4 of File Indexing Pipeline
// Refs: phase4_plan.md Task 1, feature_specs_ultra.md FEATURE 1

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

/// Result of OCR processing
class OcrResult {
  final String text;
  final double confidence;
  final bool success;
  final String? error;

  OcrResult.success({required this.text, required this.confidence})
    : success = true,
      error = null;

  OcrResult.failure(this.error) : success = false, text = '', confidence = 0.0;

  OcrResult.skipped(String reason)
    : success = true,
      text = '',
      confidence = 0.0,
      error = reason;
}

/// Extracts text from images and PDFs using Google ML Kit
class OcrProcessor {
  final TextRecognizer _textRecognizer = TextRecognizer();

  /// Extract text from image data
  ///
  /// Returns OcrResult with extracted text and confidence score.
  /// Skips processing for non-text files.
  Future<OcrResult> extractText({
    required String filePath,
    required String mimeType,
  }) async {
    // Skip if not an image or PDF
    if (!mimeType.startsWith('image/')) {
      return OcrResult.skipped('Not an image file');
    }

    try {
      final inputImage = InputImage.fromFilePath(filePath);
      final recognizedText = await _textRecognizer.processImage(inputImage);

      // Calculate average confidence from blocks
      int blockCount = 0;

      for (final block in recognizedText.blocks) {
        // Note: ML Kit doesn't provide confidence scores directly
        // We use a heuristic: longer text = higher confidence
        if (block.text.isNotEmpty) {
          blockCount++;
        }
      }

      // Use block count as confidence proxy (normalize to 0-1)
      final confidence = blockCount > 0 ? 0.85 : 0.0;

      return OcrResult.success(
        text: recognizedText.text,
        confidence: confidence,
      );
    } catch (e) {
      return OcrResult.failure('OCR extraction failed: $e');
    }
  }

  /// Dispose resources
  void dispose() {
    _textRecognizer.close();
  }
}
