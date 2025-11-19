// Index Finalizer - Step 8 of File Indexing Pipeline
// Refs: phase4_plan.md Task 1, feature_specs_ultra.md FEATURE 1

import '../../data/db/database.dart';

/// Finalizes indexing process and ensures data integrity
class IndexFinalizer {
  final FiloDatabase _database;

  IndexFinalizer(this._database);

  /// Mark file as indexed and log activity
  ///
  /// Performs final integrity check and updates is_indexed flag.
  Future<bool> finalizeIndex({required int fileId, required String uri}) async {
    try {
      // Verify foreign key integrity
      final file = await _database.filesDao.getFileById(fileId);
      if (file == null) {
        return false;
      }

      // Mark as indexed
      await _database.filesDao.markFileIndexed(fileId, DateTime.now());

      // Log activity
      await _database.activityLogDao.logActivity(
        activityType: 'file_indexed',
        description: 'Indexed file: ${file.normalizedName}',
        metadataJson: '{"file_id": $fileId, "uri": "$uri"}',
        relatedFileId: fileId,
      );

      return true;
    } catch (e) {
      // Log failure
      await _database.activityLogDao.logActivity(
        activityType: 'file_indexed',
        description: 'Failed to finalize index for: $uri',
        metadataJson: '{"error": "$e"}',
      );
      return false;
    }
  }
}
