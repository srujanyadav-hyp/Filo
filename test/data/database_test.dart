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

  group('Extracted Text DAO Tests', () {
    test('Insert and retrieve extracted text', () async {
      final filesDao = database.filesDao;

      // First insert a file
      final fileId = await filesDao.insertFile(
        FilesIndexCompanion.insert(
          uri: '/storage/document.pdf',
          normalizedName: 'document.pdf',
          mime: 'application/pdf',
          size: 1024,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now(),
          checksum: 'xyz123',
        ),
      );

      // Insert extracted text
      await database
          .into(database.extractedText)
          .insert(
            ExtractedTextCompanion.insert(
              fileId: fileId,
              content: 'This is the extracted text from the PDF',
              confidence: const Value(0.95),
            ),
          );

      // Retrieve extracted text
      final extracted = await (database.select(
        database.extractedText,
      )..where((tbl) => tbl.fileId.equals(fileId))).getSingle();

      expect(
        extracted.content,
        equals('This is the extracted text from the PDF'),
      );
      expect(extracted.confidence, equals(0.95));
    });

    test('Query files by extracted text content', () async {
      final filesDao = database.filesDao;

      // Insert file and extracted text
      final fileId = await filesDao.insertFile(
        FilesIndexCompanion.insert(
          uri: '/storage/invoice.pdf',
          normalizedName: 'invoice.pdf',
          mime: 'application/pdf',
          size: 2048,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now(),
          checksum: 'inv456',
        ),
      );

      await database
          .into(database.extractedText)
          .insert(
            ExtractedTextCompanion.insert(
              fileId: fileId,
              content: 'Invoice for services rendered',
            ),
          );

      // Search for files with specific text
      final results = await (database.select(
        database.extractedText,
      )..where((tbl) => tbl.content.contains('Invoice'))).get();

      expect(results.length, equals(1));
      expect(results.first.fileId, equals(fileId));
    });
  });

  group('Image Labels DAO Tests', () {
    test('Insert and retrieve image labels', () async {
      final filesDao = database.filesDao;

      // Insert a file
      final fileId = await filesDao.insertFile(
        FilesIndexCompanion.insert(
          uri: '/storage/photo.jpg',
          normalizedName: 'photo.jpg',
          mime: 'image/jpeg',
          size: 5120,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now(),
          checksum: 'img789',
        ),
      );

      // Insert image labels
      await database
          .into(database.imageLabels)
          .insert(
            ImageLabelsCompanion.insert(
              fileId: fileId,
              label: 'dog',
              confidence: 0.88,
            ),
          );

      // Retrieve labels
      final labels = await (database.select(
        database.imageLabels,
      )..where((tbl) => tbl.fileId.equals(fileId))).getSingle();

      expect(labels.label, equals('dog'));
      expect(labels.confidence, equals(0.88));
    });

    test('Query files by image labels', () async {
      final filesDao = database.filesDao;

      // Insert multiple files with labels
      final fileId1 = await filesDao.insertFile(
        FilesIndexCompanion.insert(
          uri: '/storage/cat.jpg',
          normalizedName: 'cat.jpg',
          mime: 'image/jpeg',
          size: 3072,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now(),
          checksum: 'cat111',
        ),
      );

      await database
          .into(database.imageLabels)
          .insert(
            ImageLabelsCompanion.insert(
              fileId: fileId1,
              label: 'cat',
              confidence: 0.92,
            ),
          );

      final fileId2 = await filesDao.insertFile(
        FilesIndexCompanion.insert(
          uri: '/storage/dog.jpg',
          normalizedName: 'dog.jpg',
          mime: 'image/jpeg',
          size: 4096,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now(),
          checksum: 'dog222',
        ),
      );

      await database
          .into(database.imageLabels)
          .insert(
            ImageLabelsCompanion.insert(
              fileId: fileId2,
              label: 'dog',
              confidence: 0.89,
            ),
          );

      // Search for cat images
      final catResults = await (database.select(
        database.imageLabels,
      )..where((tbl) => tbl.label.contains('cat'))).get();

      expect(catResults.length, equals(1));
      expect(catResults.first.fileId, equals(fileId1));
    });
  });

  group('Embeddings DAO Tests', () {
    test('Insert and retrieve embeddings', () async {
      final filesDao = database.filesDao;

      // Insert a file
      final fileId = await filesDao.insertFile(
        FilesIndexCompanion.insert(
          uri: '/storage/report.pdf',
          normalizedName: 'report.pdf',
          mime: 'application/pdf',
          size: 8192,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now(),
          checksum: 'rep333',
        ),
      );

      // Insert embedding vector as blob
      final embeddingVector = Uint8List.fromList(
        List.generate(384, (i) => i % 256),
      );

      await database
          .into(database.embeddings)
          .insert(
            EmbeddingsCompanion.insert(
              fileId: fileId,
              vector: embeddingVector,
              dim: 384,
              modelVersion: 'all-MiniLM-L6-v2',
            ),
          );

      // Retrieve embedding
      final embedding = await (database.select(
        database.embeddings,
      )..where((tbl) => tbl.fileId.equals(fileId))).getSingle();

      expect(embedding.modelVersion, equals('all-MiniLM-L6-v2'));
      expect(embedding.vector.length, equals(384));
      expect(embedding.dim, equals(384));
    });

    test('Query embeddings by model', () async {
      final filesDao = database.filesDao;

      // Insert files with different embedding models
      final fileId1 = await filesDao.insertFile(
        FilesIndexCompanion.insert(
          uri: '/storage/doc1.pdf',
          normalizedName: 'doc1.pdf',
          mime: 'application/pdf',
          size: 1024,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now(),
          checksum: 'doc1',
        ),
      );

      await database
          .into(database.embeddings)
          .insert(
            EmbeddingsCompanion.insert(
              fileId: fileId1,
              vector: Uint8List.fromList([1, 2, 3]),
              dim: 3,
              modelVersion: 'all-MiniLM-L6-v2',
            ),
          );

      final fileId2 = await filesDao.insertFile(
        FilesIndexCompanion.insert(
          uri: '/storage/doc2.pdf',
          normalizedName: 'doc2.pdf',
          mime: 'application/pdf',
          size: 2048,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now(),
          checksum: 'doc2',
        ),
      );

      await database
          .into(database.embeddings)
          .insert(
            EmbeddingsCompanion.insert(
              fileId: fileId2,
              vector: Uint8List.fromList([4, 5, 6]),
              dim: 3,
              modelVersion: 'text-embedding-3-small',
            ),
          );

      // Get all embeddings for specific model
      final miniLMEmbeddings = await (database.select(
        database.embeddings,
      )..where((tbl) => tbl.modelVersion.equals('all-MiniLM-L6-v2'))).get();

      expect(miniLMEmbeddings.length, equals(1));
      expect(miniLMEmbeddings.first.fileId, equals(fileId1));
    });
  });

  group('Rule Execution Log DAO Tests', () {
    test('Insert and retrieve rule execution log', () async {
      final rulesDao = database.rulesDao;
      final filesDao = database.filesDao;

      // Insert a rule and a file
      final ruleId = await rulesDao.insertRule(
        RulesCompanion.insert(
          name: 'Move Invoices',
          conditionsJson: '{"contains": "invoice"}',
          actionsJson: '{"move": "/invoices"}',
        ),
      );

      final fileId = await filesDao.insertFile(
        FilesIndexCompanion.insert(
          uri: '/storage/invoice123.pdf',
          normalizedName: 'invoice123.pdf',
          mime: 'application/pdf',
          size: 2048,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now(),
          checksum: 'inv123',
        ),
      );

      // Log rule execution
      await database
          .into(database.ruleExecutionLog)
          .insert(
            RuleExecutionLogCompanion.insert(
              ruleId: ruleId,
              fileId: fileId,
              status: 'success',
            ),
          );

      // Retrieve execution log
      final logs = await (database.select(
        database.ruleExecutionLog,
      )..where((tbl) => tbl.ruleId.equals(ruleId))).get();

      expect(logs.length, equals(1));
      expect(logs.first.status, equals('success'));
    });

    test('Query execution history for file', () async {
      final rulesDao = database.rulesDao;
      final filesDao = database.filesDao;

      // Insert rule and file
      final ruleId = await rulesDao.insertRule(
        RulesCompanion.insert(
          name: 'Tag Documents',
          conditionsJson: '{"type": "pdf"}',
          actionsJson: '{"tag": "document"}',
        ),
      );

      final fileId = await filesDao.insertFile(
        FilesIndexCompanion.insert(
          uri: '/storage/document.pdf',
          normalizedName: 'document.pdf',
          mime: 'application/pdf',
          size: 4096,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now(),
          checksum: 'doc456',
        ),
      );

      // Log multiple executions
      await database
          .into(database.ruleExecutionLog)
          .insert(
            RuleExecutionLogCompanion.insert(
              ruleId: ruleId,
              fileId: fileId,
              status: 'success',
            ),
          );

      await database
          .into(database.ruleExecutionLog)
          .insert(
            RuleExecutionLogCompanion.insert(
              ruleId: ruleId,
              fileId: fileId,
              status: 'failed',
              errorMessage: const Value('file locked'),
            ),
          );

      // Get all executions for this file
      final fileExecutions = await (database.select(
        database.ruleExecutionLog,
      )..where((tbl) => tbl.fileId.equals(fileId))).get();

      expect(fileExecutions.length, equals(2));
      expect(
        fileExecutions.where((e) => e.status == 'success').length,
        equals(1),
      );
      expect(
        fileExecutions.where((e) => e.status == 'failed').length,
        equals(1),
      );
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
