// FILO Database - Drift configuration
// Refs: database_schema_ultra.md lines 10-50

import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/files_index_table.dart';
import 'tables/extracted_text_table.dart';
import 'tables/image_labels_table.dart';
import 'tables/embeddings_table.dart';
import 'tables/rules_table.dart';
import 'tables/rule_execution_log_table.dart';
import 'tables/activity_log_table.dart';
import 'tables/files_fts_table.dart';

import 'daos/files_dao.dart';
import 'daos/search_dao.dart';
import 'daos/rules_dao.dart';
import 'daos/activity_log_dao.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    FilesIndex,
    ExtractedText,
    ImageLabels,
    Embeddings,
    Rules,
    RuleExecutionLog,
    ActivityLog,
    FilesFts,
  ],
  daos: [FilesDao, SearchDao, RulesDao, ActivityLogDao],
)
class FiloDatabase extends _$FiloDatabase {
  FiloDatabase() : super(_openConnection());

  // Test constructor
  FiloDatabase.forTesting(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();

      // Create FTS5 virtual table manually (Drift doesn't fully support FTS5 syntax)
      await customStatement('''
            CREATE VIRTUAL TABLE IF NOT EXISTS files_fts USING fts5(
              file_id,
              content,
              file_name
            );
            ''');
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // Future migrations will go here
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'filo.db'));
    return NativeDatabase(file);
  });
}
