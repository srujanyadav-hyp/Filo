// Files DAO - Data access for file operations
// Refs: database_schema_ultra.md, architecture_diagram_ultra.md line 8

import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/files_index_table.dart';

part 'files_dao.g.dart';

@DriftAccessor(tables: [FilesIndex])
class FilesDao extends DatabaseAccessor<FiloDatabase> with _$FilesDaoMixin {
  FilesDao(FiloDatabase db) : super(db);

  // Get all files
  Future<List<FileIndexEntry>> getAllFiles() => select(filesIndex).get();

  // Get file by ID
  Future<FileIndexEntry?> getFileById(int id) =>
      (select(filesIndex)..where((f) => f.id.equals(id))).getSingleOrNull();

  // Get file by URI
  Future<FileIndexEntry?> getFileByUri(String uri) =>
      (select(filesIndex)..where((f) => f.uri.equals(uri))).getSingleOrNull();

  // Insert file
  Future<int> insertFile(FilesIndexCompanion entry) =>
      into(filesIndex).insert(entry);

  // Update file
  Future<bool> updateFile(FileIndexEntry entry) =>
      update(filesIndex).replace(entry);

  // Delete file
  Future<int> deleteFile(int id) =>
      (delete(filesIndex)..where((f) => f.id.equals(id))).go();

  // Get files by parent URI
  Future<List<FileIndexEntry>> getFilesByParent(String parentUri) =>
      (select(filesIndex)..where((f) => f.parentUri.equals(parentUri))).get();

  // Get unindexed files
  Future<List<FileIndexEntry>> getUnindexedFiles() =>
      (select(filesIndex)..where((f) => f.isIndexed.equals(false))).get();

  // Mark file as indexed
  Future<int> markFileIndexed(int id, DateTime indexedAt) =>
      (update(filesIndex)..where((f) => f.id.equals(id))).write(
        FilesIndexCompanion(
          isIndexed: const Value(true),
          lastIndexedAt: Value(indexedAt),
        ),
      );

  // Search files by name pattern
  Future<List<FileIndexEntry>> searchFilesByName(String pattern) => (select(
    filesIndex,
  )..where((f) => f.normalizedName.like('%$pattern%'))).get();
}
