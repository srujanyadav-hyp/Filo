// Activity Log Table - User-facing history
// Refs: database_schema_ultra.md lines 10-35, screens/activity_log_ultra.md

import 'package:drift/drift.dart';
import 'files_index_table.dart';
import 'rules_table.dart';

@DataClassName('ActivityLogEntry')
class ActivityLog extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get activityType =>
      text()(); // 'file_indexed', 'rule_executed', 'search_performed', etc.
  TextColumn get description => text()();
  TextColumn get metadataJson =>
      text().nullable()(); // Additional context as JSON
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
  IntColumn get relatedFileId => integer().nullable().references(
    FilesIndex,
    #id,
    onDelete: KeyAction.setNull,
  )();
  IntColumn get relatedRuleId => integer().nullable().references(
    Rules,
    #id,
    onDelete: KeyAction.setNull,
  )();
}
