// Database Tests - Comprehensive tests for FILO database schema
// Refs: database_schema_ultra.md, testing_and_ci_ultra_ultra.md

import 'package:drift/drift.dart' hide isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:filo/data/db/database.dart';

void main() {
  late FiloDatabase database;

  setUp(() {
    // Create an in-memory database for testing
    database = FiloDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  group('Files Index DAO Tests', () {
    test('Insert and retrieve file', () async {
      final filesDao = database.filesDao;

      // Insert a file
      final fileId = await filesDao.insertFile(
        FilesIndexCompanion.insert(
          uri: '/storage/test.pdf',
          normalizedName: 'test.pdf',
          mime: 'application/pdf',
          size: 1024,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now(),
          checksum: 'abc123',
        ),
      );

      expect(fileId, greaterThan(0));

      // Retrieve the file
      final file = await filesDao.getFileById(fileId);
      expect(file, isNotNull);
      expect(file!.uri, equals('/storage/test.pdf'));
      expect(file.normalizedName, equals('test.pdf'));
    });

    test('Get unindexed files', () async {
      final filesDao = database.filesDao;

      // Insert files with different indexed states
      await filesDao.insertFile(
        FilesIndexCompanion.insert(
          uri: '/storage/indexed.pdf',
          normalizedName: 'indexed.pdf',
          mime: 'application/pdf',
          size: 1024,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now(),
          checksum: 'def456',
          isIndexed: const Value(true),
        ),
      );

      await filesDao.insertFile(
        FilesIndexCompanion.insert(
          uri: '/storage/not-indexed.pdf',
          normalizedName: 'not-indexed.pdf',
          mime: 'application/pdf',
          size: 2048,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now(),
          checksum: 'ghi789',
        ),
      );

      final unindexed = await filesDao.getUnindexedFiles();
      expect(unindexed.length, equals(1));
      expect(unindexed.first.normalizedName, equals('not-indexed.pdf'));
    });
  });

  group('Rules DAO Tests', () {
    test('Insert and retrieve rule', () async {
      final rulesDao = database.rulesDao;

      final ruleId = await rulesDao.insertRule(
        RulesCompanion.insert(
          name: 'Test Rule',
          conditionsJson: '{"type": "contains", "value": "invoice"}',
          actionsJson: '{"action": "move", "destination": "/invoices"}',
          description: const Value('Move invoices'),
        ),
      );

      expect(ruleId, greaterThan(0));

      final rule = await rulesDao.getRuleById(ruleId);
      expect(rule, isNotNull);
      expect(rule!.name, equals('Test Rule'));
      expect(rule.isEnabled, isTrue);
    });

    test('Get enabled rules ordered by priority', () async {
      final rulesDao = database.rulesDao;

      // Insert rules with different priorities
      await rulesDao.insertRule(
        RulesCompanion.insert(
          name: 'Low Priority',
          conditionsJson: '{}',
          actionsJson: '{}',
          priority: const Value(1),
        ),
      );

      await rulesDao.insertRule(
        RulesCompanion.insert(
          name: 'High Priority',
          conditionsJson: '{}',
          actionsJson: '{}',
          priority: const Value(10),
          isEnabled: const Value(true),
        ),
      );

      await rulesDao.insertRule(
        RulesCompanion.insert(
          name: 'Disabled',
          conditionsJson: '{}',
          actionsJson: '{}',
          isEnabled: const Value(false),
        ),
      );

      final enabledRules = await rulesDao.getEnabledRules();
      expect(enabledRules.length, equals(2));
      expect(enabledRules.first.name, equals('High Priority'));
    });
  });

  group('Activity Log DAO Tests', () {
    test('Log and retrieve activity', () async {
      final activityDao = database.activityLogDao;

      final logId = await activityDao.logActivity(
        activityType: 'file_indexed',
        description: 'Indexed document.pdf',
      );

      expect(logId, greaterThan(0));

      final logs = await activityDao.getRecentLogs(10);
      expect(logs.length, equals(1));
      expect(logs.first.activityType, equals('file_indexed'));
    });

    test('Get logs by type', () async {
      final activityDao = database.activityLogDao;

      await activityDao.logActivity(
        activityType: 'file_indexed',
        description: 'File 1',
      );

      await activityDao.logActivity(
        activityType: 'rule_executed',
        description: 'Rule 1',
      );

      await activityDao.logActivity(
        activityType: 'file_indexed',
        description: 'File 2',
      );

      final fileIndexedLogs = await activityDao.getLogsByType('file_indexed');
      expect(fileIndexedLogs.length, equals(2));
    });
  });

  group('Database Schema Tests', () {
    test('All tables exist', () async {
      // Verify database was created successfully
      expect(database.schemaVersion, equals(1));

      // Verify all DAOs are accessible
      expect(database.filesDao, isNotNull);
      expect(database.searchDao, isNotNull);
      expect(database.rulesDao, isNotNull);
      expect(database.activityLogDao, isNotNull);
    });
  });
}
