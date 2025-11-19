import 'package:flutter_test/flutter_test.dart';
import 'package:filo/core/rules/condition_evaluator.dart';
import 'package:filo/data/models/condition_model.dart';
import 'package:filo/data/models/rule_model.dart';
import 'package:filo/data/db/database.dart';

void main() {
  late ConditionEvaluator evaluator;

  setUp(() {
    evaluator = ConditionEvaluator();
  });

  group('String Operators', () {
    final testFile = FileIndexEntry(
      id: 1,
      uri: 'content://com.android.providers.downloads.documents/document/1',
      normalizedName: 'test_document.pdf',
      mime: 'application/pdf',
      size: 1024,
      createdAt: DateTime(2024, 1, 1),
      modifiedAt: DateTime(2024, 1, 15),
      checksum: 'abc123',
      isIndexed: true,
    );

    test('equals operator - match', () async {
      final condition = ConditionModel(
        type: 'extension',
        operator: ConditionOperators.equals,
        value: 'pdf',
      );

      final result = await evaluator.evaluateCondition(condition, testFile);
      expect(result, true);
    });

    test('equals operator - no match', () async {
      final condition = ConditionModel(
        type: 'extension',
        operator: ConditionOperators.equals,
        value: 'jpg',
      );

      final result = await evaluator.evaluateCondition(condition, testFile);
      expect(result, false);
    });

    test('not_equals operator - match', () async {
      final condition = ConditionModel(
        type: 'extension',
        operator: ConditionOperators.notEquals,
        value: 'jpg',
      );

      final result = await evaluator.evaluateCondition(condition, testFile);
      expect(result, true);
    });

    test('contains operator - match', () async {
      final condition = ConditionModel(
        type: 'filename_regex',
        operator: ConditionOperators.contains,
        value: 'document',
      );

      final result = await evaluator.evaluateCondition(condition, testFile);
      expect(result, true);
    });

    test('contains operator - case insensitive', () async {
      final condition = ConditionModel(
        type: 'filename_regex',
        operator: ConditionOperators.contains,
        value: 'DOCUMENT',
      );

      final result = await evaluator.evaluateCondition(condition, testFile);
      expect(result, true);
    });

    test('not_contains operator - match', () async {
      final condition = ConditionModel(
        type: 'filename_regex',
        operator: ConditionOperators.notContains,
        value: 'invoice',
      );

      final result = await evaluator.evaluateCondition(condition, testFile);
      expect(result, true);
    });

    test('starts_with operator - match', () async {
      final condition = ConditionModel(
        type: 'filename_regex',
        operator: ConditionOperators.startsWith,
        value: 'test',
      );

      final result = await evaluator.evaluateCondition(condition, testFile);
      expect(result, true);
    });

    test('starts_with operator - no match', () async {
      final condition = ConditionModel(
        type: 'filename_regex',
        operator: ConditionOperators.startsWith,
        value: 'invoice',
      );

      final result = await evaluator.evaluateCondition(condition, testFile);
      expect(result, false);
    });

    test('ends_with operator - match', () async {
      final condition = ConditionModel(
        type: 'filename_regex',
        operator: ConditionOperators.endsWith,
        value: '.pdf',
      );

      final result = await evaluator.evaluateCondition(condition, testFile);
      expect(result, true);
    });

    test('regex operator - simple pattern match', () async {
      final condition = ConditionModel(
        type: 'filename_regex',
        operator: ConditionOperators.regex,
        value: r'test_\w+\.pdf',
      );

      final result = await evaluator.evaluateCondition(condition, testFile);
      expect(result, true);
    });

    test('regex operator - no match', () async {
      final condition = ConditionModel(
        type: 'filename_regex',
        operator: ConditionOperators.regex,
        value: r'^\d+\.jpg$',
      );

      final result = await evaluator.evaluateCondition(condition, testFile);
      expect(result, false);
    });

    test('regex operator - invalid pattern returns false', () async {
      final condition = ConditionModel(
        type: 'filename_regex',
        operator: ConditionOperators.regex,
        value: r'[unclosed',
      );

      final result = await evaluator.evaluateCondition(condition, testFile);
      expect(result, false);
    });
  });

  group('MIME Type Operators', () {
    test('PDF MIME type equals', () async {
      final file = FileIndexEntry(
        id: 1,
        uri: 'content://test/1',
        normalizedName: 'doc.pdf',
        mime: 'application/pdf',
        size: 1024,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        checksum: 'abc',
        isIndexed: true,
      );

      final condition = ConditionModel(
        type: 'mime',
        operator: ConditionOperators.equals,
        value: 'application/pdf',
      );

      final result = await evaluator.evaluateCondition(condition, file);
      expect(result, true);
    });

    test('Image MIME type contains', () async {
      final file = FileIndexEntry(
        id: 1,
        uri: 'content://test/1',
        normalizedName: 'photo.jpg',
        mime: 'image/jpeg',
        size: 2048,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        checksum: 'xyz',
        isIndexed: true,
      );

      final condition = ConditionModel(
        type: 'mime',
        operator: ConditionOperators.contains,
        value: 'image',
      );

      final result = await evaluator.evaluateCondition(condition, file);
      expect(result, true);
    });
  });

  group('Numeric Operators', () {
    test('greater_than operator - match', () async {
      final file = FileIndexEntry(
        id: 1,
        uri: 'content://test/1',
        normalizedName: 'large_file.zip',
        mime: 'application/zip',
        size: 10485760, // 10 MB
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        checksum: 'abc',
        isIndexed: true,
      );

      final condition = ConditionModel(
        type: 'file_size',
        operator: ConditionOperators.greaterThan,
        value: 5242880, // 5 MB
      );

      final result = await evaluator.evaluateCondition(condition, file);
      expect(result, true);
    });

    test('greater_than operator - no match', () async {
      final file = FileIndexEntry(
        id: 1,
        uri: 'content://test/1',
        normalizedName: 'small_file.txt',
        mime: 'text/plain',
        size: 1024, // 1 KB
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        checksum: 'abc',
        isIndexed: true,
      );

      final condition = ConditionModel(
        type: 'file_size',
        operator: ConditionOperators.greaterThan,
        value: 5242880, // 5 MB
      );

      final result = await evaluator.evaluateCondition(condition, file);
      expect(result, false);
    });

    test('less_than operator - match', () async {
      final file = FileIndexEntry(
        id: 1,
        uri: 'content://test/1',
        normalizedName: 'small_file.txt',
        mime: 'text/plain',
        size: 1024,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        checksum: 'abc',
        isIndexed: true,
      );

      final condition = ConditionModel(
        type: 'file_size',
        operator: ConditionOperators.lessThan,
        value: 2048,
      );

      final result = await evaluator.evaluateCondition(condition, file);
      expect(result, true);
    });

    test('between operator - match', () async {
      final file = FileIndexEntry(
        id: 1,
        uri: 'content://test/1',
        normalizedName: 'medium_file.doc',
        mime: 'application/msword',
        size: 512000,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        checksum: 'abc',
        isIndexed: true,
      );

      final condition = ConditionModel(
        type: 'file_size',
        operator: ConditionOperators.between,
        value: [102400, 1048576], // 100 KB to 1 MB
      );

      final result = await evaluator.evaluateCondition(condition, file);
      expect(result, true);
    });

    test('between operator - no match (below range)', () async {
      final file = FileIndexEntry(
        id: 1,
        uri: 'content://test/1',
        normalizedName: 'tiny_file.txt',
        mime: 'text/plain',
        size: 50000,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        checksum: 'abc',
        isIndexed: true,
      );

      final condition = ConditionModel(
        type: 'file_size',
        operator: ConditionOperators.between,
        value: [102400, 1048576],
      );

      final result = await evaluator.evaluateCondition(condition, file);
      expect(result, false);
    });
  });

  group('Date Operators', () {
    test('before operator - match', () async {
      final file = FileIndexEntry(
        id: 1,
        uri: 'content://test/1',
        normalizedName: 'old_file.txt',
        mime: 'text/plain',
        size: 1024,
        createdAt: DateTime(2023, 1, 1),
        modifiedAt: DateTime(2023, 1, 1),
        checksum: 'abc',
        isIndexed: true,
      );

      final condition = ConditionModel(
        type: 'created_date',
        operator: ConditionOperators.before,
        value: '2024-01-01T00:00:00.000Z',
      );

      final result = await evaluator.evaluateCondition(condition, file);
      expect(result, true);
    });

    test('after operator - match', () async {
      final file = FileIndexEntry(
        id: 1,
        uri: 'content://test/1',
        normalizedName: 'new_file.txt',
        mime: 'text/plain',
        size: 1024,
        createdAt: DateTime(2024, 6, 1),
        modifiedAt: DateTime(2024, 6, 1),
        checksum: 'abc',
        isIndexed: true,
      );

      final condition = ConditionModel(
        type: 'created_date',
        operator: ConditionOperators.after,
        value: '2024-01-01T00:00:00.000Z',
      );

      final result = await evaluator.evaluateCondition(condition, file);
      expect(result, true);
    });

    test('date_range operator - match', () async {
      final file = FileIndexEntry(
        id: 1,
        uri: 'content://test/1',
        normalizedName: 'file.txt',
        mime: 'text/plain',
        size: 1024,
        createdAt: DateTime(2024, 3, 15),
        modifiedAt: DateTime(2024, 3, 15),
        checksum: 'abc',
        isIndexed: true,
      );

      final condition = ConditionModel(
        type: 'created_date',
        operator: ConditionOperators.dateRange,
        value: ['2024-01-01T00:00:00.000Z', '2024-12-31T23:59:59.999Z'],
      );

      final result = await evaluator.evaluateCondition(condition, file);
      expect(result, true);
    });

    test('modified_date after operator', () async {
      final file = FileIndexEntry(
        id: 1,
        uri: 'content://test/1',
        normalizedName: 'file.txt',
        mime: 'text/plain',
        size: 1024,
        createdAt: DateTime(2023, 1, 1),
        modifiedAt: DateTime(2024, 5, 20),
        checksum: 'abc',
        isIndexed: true,
      );

      final condition = ConditionModel(
        type: 'modified_date',
        operator: ConditionOperators.after,
        value: '2024-01-01T00:00:00.000Z',
      );

      final result = await evaluator.evaluateCondition(condition, file);
      expect(result, true);
    });
  });

  group('Folder/Directory Operators', () {
    test('folder equals - match', () async {
      final file = FileIndexEntry(
        id: 1,
        uri: 'content://downloads/documents/invoices/invoice_2024.pdf',
        normalizedName: 'invoice_2024.pdf',
        mime: 'application/pdf',
        size: 1024,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        checksum: 'abc',
        isIndexed: true,
      );

      final condition = ConditionModel(
        type: 'folder',
        operator: ConditionOperators.equals,
        value: 'content://downloads/documents/invoices',
      );

      final result = await evaluator.evaluateCondition(condition, file);
      expect(result, true);
    });

    test('folder contains - match', () async {
      final file = FileIndexEntry(
        id: 1,
        uri: 'content://downloads/documents/work/reports/Q1.pdf',
        normalizedName: 'Q1.pdf',
        mime: 'application/pdf',
        size: 1024,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        checksum: 'abc',
        isIndexed: true,
      );

      final condition = ConditionModel(
        type: 'folder',
        operator: ConditionOperators.contains,
        value: 'work',
      );

      final result = await evaluator.evaluateCondition(condition, file);
      expect(result, true);
    });

    test('folder starts_with - match', () async {
      final file = FileIndexEntry(
        id: 1,
        uri: 'content://downloads/documents/personal/photo.jpg',
        normalizedName: 'photo.jpg',
        mime: 'image/jpeg',
        size: 2048,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        checksum: 'xyz',
        isIndexed: true,
      );

      final condition = ConditionModel(
        type: 'folder',
        operator: ConditionOperators.startsWith,
        value: 'content://downloads',
      );

      final result = await evaluator.evaluateCondition(condition, file);
      expect(result, true);
    });
  });

  group('Condition Groups - AND Logic', () {
    final testFile = FileIndexEntry(
      id: 1,
      uri: 'content://downloads/invoices/invoice_2024.pdf',
      normalizedName: 'invoice_2024.pdf',
      mime: 'application/pdf',
      size: 512000,
      createdAt: DateTime(2024, 3, 15),
      modifiedAt: DateTime(2024, 3, 15),
      checksum: 'abc',
      isIndexed: true,
    );

    test('AND group - all conditions match', () async {
      final group = ConditionGroup(
        operator: 'AND',
        conditions: [
          ConditionModel(
            type: 'extension',
            operator: ConditionOperators.equals,
            value: 'pdf',
          ),
          ConditionModel(
            type: 'folder',
            operator: ConditionOperators.contains,
            value: 'invoices',
          ),
          ConditionModel(
            type: 'file_size',
            operator: ConditionOperators.greaterThan,
            value: 100000,
          ),
        ],
      );

      final result = await evaluator.evaluateConditionGroup(group, testFile);
      expect(result, true);
    });

    test('AND group - one condition fails', () async {
      final group = ConditionGroup(
        operator: 'AND',
        conditions: [
          ConditionModel(
            type: 'extension',
            operator: ConditionOperators.equals,
            value: 'pdf',
          ),
          ConditionModel(
            type: 'folder',
            operator: ConditionOperators.contains,
            value: 'photos',
          ),
          ConditionModel(
            type: 'file_size',
            operator: ConditionOperators.greaterThan,
            value: 100000,
          ),
        ],
      );

      final result = await evaluator.evaluateConditionGroup(group, testFile);
      expect(result, false);
    });

    test('AND group - short circuit on first failure', () async {
      final group = ConditionGroup(
        operator: 'AND',
        conditions: [
          ConditionModel(
            type: 'extension',
            operator: ConditionOperators.equals,
            value: 'jpg',
          ), // Fails first
          ConditionModel(
            type: 'folder',
            operator: ConditionOperators.contains,
            value: 'invoices',
          ),
          ConditionModel(
            type: 'file_size',
            operator: ConditionOperators.greaterThan,
            value: 100000,
          ),
        ],
      );

      final result = await evaluator.evaluateConditionGroup(group, testFile);
      expect(result, false);
    });
  });

  group('Condition Groups - OR Logic', () {
    final testFile = FileIndexEntry(
      id: 1,
      uri: 'content://downloads/documents/report.docx',
      normalizedName: 'report.docx',
      mime:
          'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      size: 256000,
      createdAt: DateTime(2024, 2, 10),
      modifiedAt: DateTime(2024, 2, 10),
      checksum: 'def',
      isIndexed: true,
    );

    test('OR group - first condition matches', () async {
      final group = ConditionGroup(
        operator: 'OR',
        conditions: [
          ConditionModel(
            type: 'extension',
            operator: ConditionOperators.equals,
            value: 'docx',
          ),
          ConditionModel(
            type: 'extension',
            operator: ConditionOperators.equals,
            value: 'pdf',
          ),
          ConditionModel(
            type: 'extension',
            operator: ConditionOperators.equals,
            value: 'txt',
          ),
        ],
      );

      final result = await evaluator.evaluateConditionGroup(group, testFile);
      expect(result, true);
    });

    test('OR group - last condition matches', () async {
      final group = ConditionGroup(
        operator: 'OR',
        conditions: [
          ConditionModel(
            type: 'extension',
            operator: ConditionOperators.equals,
            value: 'pdf',
          ),
          ConditionModel(
            type: 'extension',
            operator: ConditionOperators.equals,
            value: 'txt',
          ),
          ConditionModel(
            type: 'extension',
            operator: ConditionOperators.equals,
            value: 'docx',
          ),
        ],
      );

      final result = await evaluator.evaluateConditionGroup(group, testFile);
      expect(result, true);
    });

    test('OR group - no conditions match', () async {
      final group = ConditionGroup(
        operator: 'OR',
        conditions: [
          ConditionModel(
            type: 'extension',
            operator: ConditionOperators.equals,
            value: 'pdf',
          ),
          ConditionModel(
            type: 'extension',
            operator: ConditionOperators.equals,
            value: 'jpg',
          ),
          ConditionModel(
            type: 'extension',
            operator: ConditionOperators.equals,
            value: 'png',
          ),
        ],
      );

      final result = await evaluator.evaluateConditionGroup(group, testFile);
      expect(result, false);
    });

    test('OR group - short circuit on first match', () async {
      final group = ConditionGroup(
        operator: 'OR',
        conditions: [
          ConditionModel(
            type: 'extension',
            operator: ConditionOperators.equals,
            value: 'docx',
          ), // Matches first
          ConditionModel(
            type: 'file_size',
            operator: ConditionOperators.greaterThan,
            value: 999999999,
          ),
        ],
      );

      final result = await evaluator.evaluateConditionGroup(group, testFile);
      expect(result, true);
    });
  });

  group('Multiple Condition Groups', () {
    final testFile = FileIndexEntry(
      id: 1,
      uri: 'content://downloads/work/spreadsheet.xlsx',
      normalizedName: 'spreadsheet.xlsx',
      mime: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      size: 1048576, // 1 MB
      createdAt: DateTime(2024, 4, 1),
      modifiedAt: DateTime(2024, 4, 5),
      checksum: 'ghi',
      isIndexed: true,
    );

    test('multiple groups - first group matches', () async {
      final groups = [
        ConditionGroup(
          operator: 'AND',
          conditions: [
            ConditionModel(
              type: 'extension',
              operator: ConditionOperators.equals,
              value: 'xlsx',
            ),
            ConditionModel(
              type: 'folder',
              operator: ConditionOperators.contains,
              value: 'work',
            ),
          ],
        ),
        ConditionGroup(
          operator: 'AND',
          conditions: [
            ConditionModel(
              type: 'extension',
              operator: ConditionOperators.equals,
              value: 'pdf',
            ),
          ],
        ),
      ];

      final result = await evaluator.evaluateConditionGroups(groups, testFile);
      expect(result, true);
    });

    test('multiple groups - second group matches', () async {
      final groups = [
        ConditionGroup(
          operator: 'AND',
          conditions: [
            ConditionModel(
              type: 'extension',
              operator: ConditionOperators.equals,
              value: 'pdf',
            ),
          ],
        ),
        ConditionGroup(
          operator: 'AND',
          conditions: [
            ConditionModel(
              type: 'extension',
              operator: ConditionOperators.equals,
              value: 'xlsx',
            ),
            ConditionModel(
              type: 'file_size',
              operator: ConditionOperators.greaterThan,
              value: 500000,
            ),
          ],
        ),
      ];

      final result = await evaluator.evaluateConditionGroups(groups, testFile);
      expect(result, true);
    });

    test('multiple groups - no groups match', () async {
      final groups = [
        ConditionGroup(
          operator: 'AND',
          conditions: [
            ConditionModel(
              type: 'extension',
              operator: ConditionOperators.equals,
              value: 'pdf',
            ),
          ],
        ),
        ConditionGroup(
          operator: 'AND',
          conditions: [
            ConditionModel(
              type: 'extension',
              operator: ConditionOperators.equals,
              value: 'docx',
            ),
          ],
        ),
      ];

      final result = await evaluator.evaluateConditionGroups(groups, testFile);
      expect(result, false);
    });
  });

  group('Edge Cases', () {
    test('file with no extension', () async {
      final file = FileIndexEntry(
        id: 1,
        uri: 'content://test/1',
        normalizedName: 'README',
        mime: 'text/plain',
        size: 1024,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        checksum: 'abc',
        isIndexed: true,
      );

      final condition = ConditionModel(
        type: 'extension',
        operator: ConditionOperators.equals,
        value: '',
      );

      final result = await evaluator.evaluateCondition(condition, file);
      expect(result, true);
    });

    test('empty folder path', () async {
      final file = FileIndexEntry(
        id: 1,
        uri: 'file.txt',
        normalizedName: 'file.txt',
        mime: 'text/plain',
        size: 1024,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        checksum: 'abc',
        isIndexed: true,
      );

      final condition = ConditionModel(
        type: 'folder',
        operator: ConditionOperators.equals,
        value: '',
      );

      final result = await evaluator.evaluateCondition(condition, file);
      expect(result, true);
    });

    test('zero byte file', () async {
      final file = FileIndexEntry(
        id: 1,
        uri: 'content://test/1',
        normalizedName: 'empty.txt',
        mime: 'text/plain',
        size: 0,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        checksum: 'abc',
        isIndexed: true,
      );

      final condition = ConditionModel(
        type: 'file_size',
        operator: ConditionOperators.equals,
        value: 0,
      );

      final result = await evaluator.evaluateCondition(condition, file);
      expect(result, false); // equals not in valid operators for file_size
    });
  });
}
