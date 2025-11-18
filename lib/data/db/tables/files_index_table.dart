// Files Index Table - Primary file metadata
// Refs: database_schema_ultra.md lines 12-25

import 'package:drift/drift.dart';

@DataClassName('FileIndexEntry')
class FilesIndex extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uri => text().unique()();
  TextColumn get normalizedName => text()();
  TextColumn get mime => text()();
  IntColumn get size => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get modifiedAt => dateTime()();
  TextColumn get parentUri => text().nullable()();
  TextColumn get checksum => text()();
  BoolColumn get isIndexed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastIndexedAt => dateTime().nullable()();
}
