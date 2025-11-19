// File Reader - Step 1 of File Indexing Pipeline
// Refs: phase4_plan.md Task 1, feature_specs_ultra.md FEATURE 1

import 'dart:io';
import 'dart:typed_data';

/// Result of file reading operation
class FileReadResult {
  final Uint8List? data;
  final String? error;
  final bool success;

  FileReadResult.success(this.data) : success = true, error = null;

  FileReadResult.failure(this.error) : success = false, data = null;
}

/// Reads files from Storage Access Framework URIs with retry logic
class FileReader {
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(milliseconds: 500);

  /// Read file from URI with automatic retry on failure
  ///
  /// Implements retry logic as per spec: "SAF inaccessible → retry 3 times"
  Future<FileReadResult> readFile(String uri) async {
    int attempts = 0;

    while (attempts < maxRetries) {
      try {
        attempts++;

        // Convert URI to file path (simplified for now)
        // TODO: Proper SAF URI handling with platform channels
        final file = File(uri);

        if (!await file.exists()) {
          if (attempts < maxRetries) {
            await Future.delayed(retryDelay);
            continue;
          }
          return FileReadResult.failure('File does not exist: $uri');
        }

        final data = await file.readAsBytes();
        return FileReadResult.success(data);
      } catch (e) {
        if (attempts < maxRetries) {
          await Future.delayed(retryDelay);
          continue;
        }
        return FileReadResult.failure(
          'Failed to read file after $maxRetries attempts: $e',
        );
      }
    }

    return FileReadResult.failure('Unexpected error in readFile');
  }

  /// Read file metadata without loading full content
  Future<FileMetadataResult> readMetadata(String uri) async {
    try {
      final file = File(uri);

      if (!await file.exists()) {
        return FileMetadataResult.failure('File does not exist: $uri');
      }

      final stat = await file.stat();

      return FileMetadataResult.success(
        size: stat.size,
        modified: stat.modified,
        created: stat
            .modified, // Note: File creation time not available on all platforms
        accessed: stat.accessed,
      );
    } catch (e) {
      return FileMetadataResult.failure('Failed to read metadata: $e');
    }
  }
}

/// Result of metadata reading operation
class FileMetadataResult {
  final int? size;
  final DateTime? modified;
  final DateTime? created;
  final DateTime? accessed;
  final String? error;
  final bool success;

  FileMetadataResult.success({
    required this.size,
    required this.modified,
    required this.created,
    required this.accessed,
  }) : success = true,
       error = null;

  FileMetadataResult.failure(this.error)
    : success = false,
      size = null,
      modified = null,
      created = null,
      accessed = null;
}
