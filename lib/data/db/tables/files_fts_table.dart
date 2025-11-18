// Files FTS Table - Full-text search virtual table
// Refs: database_schema_ultra.md lines 37-50, search_architecture_ultra.md
// Note: Simplified version - FTS5 features added in migrations

import 'package:drift/drift.dart';

@DataClassName('FilesFtsEntry')
class FilesFts extends Table {
  IntColumn get fileId => integer()();
  TextColumn get content => text()();
  TextColumn get fileName => text()();
}
