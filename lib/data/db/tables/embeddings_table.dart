// Embeddings Table - Vector embeddings for semantic search
// Refs: database_schema_ultra.md lines 27-35

import 'package:drift/drift.dart';
import 'files_index_table.dart';

@DataClassName('Embedding')
class Embeddings extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get fileId =>
      integer().references(FilesIndex, #id, onDelete: KeyAction.cascade)();
  BlobColumn get vector => blob()();
  IntColumn get dim => integer()();
  TextColumn get modelVersion => text()();
  TextColumn get quantizationLevel => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
