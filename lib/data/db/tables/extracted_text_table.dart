// Extracted Text Table - OCR results
// Refs: database_schema_ultra.md lines 27-32

import 'package:drift/drift.dart';
import 'files_index_table.dart';

@DataClassName('ExtractedTextEntry')
class ExtractedText extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get fileId =>
      integer().references(FilesIndex, #id, onDelete: KeyAction.cascade)();
  TextColumn get content => text()();
  RealColumn get confidence => real().nullable()();
  TextColumn get ocrEngineVersion => text().nullable()();
  DateTimeColumn get extractedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
