// MIME Detector - Step 3 of File Indexing Pipeline
// Refs: phase4_plan.md Task 1, feature_specs_ultra.md FEATURE 1

import 'package:mime/mime.dart';

/// Detects MIME type using content-based detection with extension fallback
class MimeDetector {
  /// Detect MIME type from file data and path
  ///
  /// Uses mime package for content-based detection.
  /// Falls back to extension mapping if content detection fails.
  String detectMimeType({
    required String filePath,
    required List<int>? fileData,
  }) {
    // Try content-based detection first
    if (fileData != null && fileData.isNotEmpty) {
      final detectedType = lookupMimeType(filePath, headerBytes: fileData);
      if (detectedType != null) {
        return detectedType;
      }
    }

    // Fallback to extension-based detection
    final detectedType = lookupMimeType(filePath);
    if (detectedType != null) {
      return detectedType;
    }

    // Ultimate fallback
    return 'application/octet-stream';
  }

  /// Check if file is an image
  bool isImage(String mimeType) {
    return mimeType.startsWith('image/');
  }

  /// Check if file is a PDF
  bool isPdf(String mimeType) {
    return mimeType == 'application/pdf';
  }

  /// Check if file is a document (PDF or text-based)
  bool isDocument(String mimeType) {
    return isPdf(mimeType) ||
        mimeType.startsWith('text/') ||
        mimeType.contains('document') ||
        mimeType.contains('word') ||
        mimeType.contains('spreadsheet') ||
        mimeType.contains('presentation');
  }

  /// Check if file supports OCR extraction
  bool supportsOcr(String mimeType) {
    return isImage(mimeType) || isPdf(mimeType);
  }
}
