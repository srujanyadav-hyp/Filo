// Metadata Extractor - Step 2 of File Indexing Pipeline
// Refs: phase4_plan.md Task 1, feature_specs_ultra.md FEATURE 1

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import '../../data/db/database.dart';

/// Extracts and normalizes file metadata
class MetadataExtractor {
  /// Extract metadata and create FilesIndexCompanion for database insertion
  ///
  /// Generates:
  /// - Normalized filename
  /// - SHA256 checksum
  /// - Timestamps
  FilesIndexCompanion extractMetadata({
    required String uri,
    required String mimeType,
    required int size,
    required DateTime createdAt,
    required DateTime modifiedAt,
    required List<int> fileData,
  }) {
    // Generate checksum
    final checksum = _generateChecksum(fileData);

    // Normalize filename
    final normalizedName = _normalizeFilename(uri);

    return FilesIndexCompanion.insert(
      uri: uri,
      normalizedName: normalizedName,
      mime: mimeType,
      size: size,
      createdAt: createdAt,
      modifiedAt: modifiedAt,
      checksum: checksum,
      isIndexed: const Value(false), // Will be set to true after full pipeline
    );
  }

  /// Generate SHA256 checksum for file integrity
  String _generateChecksum(List<int> data) {
    final bytes = sha256.convert(data);
    return bytes.toString();
  }

  /// Normalize filename (extract from path, lowercase, trim)
  String _normalizeFilename(String uri) {
    final basename = p.basename(uri);
    return basename.trim();
  }
}
