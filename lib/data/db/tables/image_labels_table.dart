// Image Labels Table - ML-generated labels
// Refs: database_schema_ultra.md lines 10-35

import 'package:drift/drift.dart';
import 'files_index_table.dart';

@DataClassName('ImageLabel')
class ImageLabels extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get fileId =>
      integer().references(FilesIndex, #id, onDelete: KeyAction.cascade)();
  TextColumn get label => text()();
  RealColumn get confidence => real()();
  TextColumn get modelVersion => text().nullable()();
  DateTimeColumn get labeledAt => dateTime().withDefault(currentDateAndTime)();
}
