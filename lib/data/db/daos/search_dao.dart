// Search DAO - Data access for search operations including FTS
// Refs: database_schema_ultra.md, search_architecture_ultra.md

import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/files_index_table.dart';
import '../tables/extracted_text_table.dart';
import '../tables/image_labels_table.dart';
import '../tables/files_fts_table.dart';

part 'search_dao.g.dart';

@DriftAccessor(tables: [FilesIndex, ExtractedText, ImageLabels, FilesFts])
class SearchDao extends DatabaseAccessor<FiloDatabase> with _$SearchDaoMixin {
  SearchDao(FiloDatabase db) : super(db);

  // Full-text search using FTS5
  Future<List<int>> searchFilesByContent(String query) async {
    final results = await customSelect(
      'SELECT file_id FROM files_fts WHERE files_fts MATCH ?',
      variables: [Variable.withString(query)],
      readsFrom: {filesFts},
    ).get();

    return results.map((row) => row.read<int>('file_id')).toList();
  }

  // Search in extracted text
  Future<List<int>> searchInExtractedText(String query) async {
    final results = await (select(
      extractedText,
    )..where((t) => t.content.like('%$query%'))).get();
    return results.map((r) => r.fileId).toSet().toList();
  }

  // Search by image labels
  Future<List<int>> searchByImageLabel(String label) async {
    final results = await (select(
      imageLabels,
    )..where((l) => l.label.like('%$label%'))).get();
    return results.map((r) => r.fileId).toSet().toList();
  }

  // Combined search across multiple sources
  Future<Set<int>> combinedSearch(String query) async {
    final Set<int> fileIds = {};

    // FTS search
    fileIds.addAll(await searchFilesByContent(query));

    // OCR text search
    fileIds.addAll(await searchInExtractedText(query));

    // Image label search
    fileIds.addAll(await searchByImageLabel(query));

    return fileIds;
  }
}
