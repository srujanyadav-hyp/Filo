// Rules Table - Automation rules
// Refs: database_schema_ultra.md lines 10-35, rule_engine_ultra.md

import 'package:drift/drift.dart';

@DataClassName('Rule')
class Rules extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get conditionsJson => text()(); // Serialized rule conditions
  TextColumn get actionsJson => text()(); // Serialized rule actions
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
  IntColumn get priority => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastExecutedAt => dateTime().nullable()();
}
