// Rule Execution Log Table - Audit trail for rule executions
// Refs: database_schema_ultra.md lines 10-35

import 'package:drift/drift.dart';
import 'files_index_table.dart';
import 'rules_table.dart';

@DataClassName('RuleExecutionLogEntry')
class RuleExecutionLog extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ruleId =>
      integer().references(Rules, #id, onDelete: KeyAction.cascade)();
  IntColumn get fileId =>
      integer().references(FilesIndex, #id, onDelete: KeyAction.cascade)();
  TextColumn get status => text()(); // 'success', 'failed', 'skipped'
  TextColumn get errorMessage => text().nullable()();
  DateTimeColumn get executedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get durationMs => integer().nullable()();
}
