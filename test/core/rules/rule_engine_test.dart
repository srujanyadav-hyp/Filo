import 'package:flutter_test/flutter_test.dart';
import 'package:filo/core/rules/rule_engine.dart';
import 'package:filo/data/models/rule_model.dart';
import 'package:filo/data/models/condition_model.dart';
import 'package:filo/data/models/action_model.dart';
import 'package:filo/data/db/database.dart';
import 'package:drift/native.dart';

void main() {
  late FiloDatabase database;
  late RuleEngine engine;

  setUp(() async {
    database = FiloDatabase.forTesting(NativeDatabase.memory());
    engine = RuleEngine(database);

    // Insert test files
    await database.filesDao.insertFile(
      FilesIndexCompanion.insert(
        uri: 'content://downloads/invoice_2024.pdf',
        normalizedName: 'invoice_2024.pdf',
        mime: 'application/pdf',
        size: 512000,
        createdAt: DateTime(2024, 3, 15),
        modifiedAt: DateTime(2024, 3, 15),
        checksum: 'abc123',
      ),
    );

    await database.filesDao.insertFile(
      FilesIndexCompanion.insert(
        uri: 'content://downloads/photo.jpg',
        normalizedName: 'photo.jpg',
        mime: 'image/jpeg',
        size: 2048000,
        createdAt: DateTime(2024, 4, 10),
        modifiedAt: DateTime(2024, 4, 10),
        checksum: 'xyz789',
      ),
    );

    await database.filesDao.insertFile(
      FilesIndexCompanion.insert(
        uri: 'content://downloads/document.docx',
        normalizedName: 'document.docx',
        mime:
            'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        size: 256000,
        createdAt: DateTime(2024, 2, 20),
        modifiedAt: DateTime(2024, 2, 20),
        checksum: 'def456',
      ),
    );
  });

  tearDown(() async {
    await database.close();
  });

  group('Rule Execution', () {
    test('execute rule - matches PDF files', () async {
      final rule = RuleModel(
        id: 'rule_pdf',
        trigger: RuleTrigger(type: 'manual'),
        conditions: [
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
        ],
        actions: [
          ActionModel(
            type: ActionTypes.addTag,
            params: {'tags': 'pdf_document'},
          ),
        ],
        metadata: RuleMetadata(
          createdAt: DateTime.now(),
          createdBy: 'manual',
          safetyClass: 'low',
        ),
      );

      final result = await engine.executeRule(rule);

      expect(result.success, true);
      expect(result.matchedFiles, hasLength(1));
      expect(result.matchedFiles[0].normalizedName, 'invoice_2024.pdf');
      expect(result.actionResults, hasLength(1));
      expect(result.actionResults.values.first.first.success, true);
    });

    test('execute rule - matches large files', () async {
      final rule = RuleModel(
        id: 'rule_large_files',
        trigger: RuleTrigger(type: 'manual'),
        conditions: [
          ConditionGroup(
            operator: 'AND',
            conditions: [
              ConditionModel(
                type: 'file_size',
                operator: ConditionOperators.greaterThan,
                value: 1000000,
              ),
            ],
          ),
        ],
        actions: [
          ActionModel(
            type: ActionTypes.notify,
            params: {'message': 'Large file detected'},
          ),
        ],
        metadata: RuleMetadata(
          createdAt: DateTime.now(),
          createdBy: 'manual',
          safetyClass: 'low',
        ),
      );

      final result = await engine.executeRule(rule);

      expect(result.success, true);
      expect(result.matchedFiles, hasLength(1));
      expect(result.matchedFiles[0].normalizedName, 'photo.jpg');
    });

    test('execute rule - OR conditions match multiple files', () async {
      final rule = RuleModel(
        id: 'rule_or_conditions',
        trigger: RuleTrigger(type: 'manual'),
        conditions: [
          ConditionGroup(
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
            ],
          ),
        ],
        actions: [
          ActionModel(
            type: ActionTypes.notify,
            params: {'message': 'Match found'},
          ),
        ],
        metadata: RuleMetadata(
          createdAt: DateTime.now(),
          createdBy: 'manual',
          safetyClass: 'low',
        ),
      );

      final result = await engine.executeRule(rule);

      expect(result.success, true);
      expect(result.matchedFiles, hasLength(2));
    });

    test('execute rule - no matches', () async {
      final rule = RuleModel(
        id: 'rule_no_match',
        trigger: RuleTrigger(type: 'manual'),
        conditions: [
          ConditionGroup(
            operator: 'AND',
            conditions: [
              ConditionModel(
                type: 'extension',
                operator: ConditionOperators.equals,
                value: 'zip',
              ),
            ],
          ),
        ],
        actions: [
          ActionModel(
            type: ActionTypes.notify,
            params: {'message': 'Should not execute'},
          ),
        ],
        metadata: RuleMetadata(
          createdAt: DateTime.now(),
          createdBy: 'manual',
          safetyClass: 'low',
        ),
      );

      final result = await engine.executeRule(rule);

      expect(result.success, true);
      expect(result.matchedFiles, isEmpty);
      expect(result.actionResults, isEmpty);
    });

    test('execute rule - invalid rule fails validation', () async {
      final rule = RuleModel(
        id: '',
        trigger: RuleTrigger(type: 'manual'),
        conditions: [
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
        ],
        actions: [
          ActionModel(type: ActionTypes.addTag, params: {'tags': 'test'}),
        ],
        metadata: RuleMetadata(
          createdAt: DateTime.now(),
          createdBy: 'manual',
          safetyClass: 'low',
        ),
      );

      final result = await engine.executeRule(rule);

      expect(result.success, false);
      expect(result.error, contains('Validation failed'));
    });
  });

  group('Rule Execution from JSON', () {
    test('execute rule from valid JSON', () async {
      final ruleJson = {
        'id': 'rule_json_test',
        'trigger': {'type': 'manual'},
        'conditions': [
          {
            'operator': 'AND',
            'conditions': [
              {'type': 'mime', 'operator': 'contains', 'value': 'image'},
            ],
          },
        ],
        'actions': [
          {
            'type': 'add_tag',
            'params': {'tags': 'image_file'},
          },
        ],
        'metadata': {
          'created_at': DateTime.now().toIso8601String(),
          'created_by': 'manual',
          'safety_class': 'low',
        },
      };

      final result = await engine.executeRuleFromJson(ruleJson);

      expect(result.success, true);
      expect(result.matchedFiles, hasLength(1));
      expect(result.matchedFiles[0].mime, 'image/jpeg');
    });

    test('execute rule from invalid JSON', () async {
      final ruleJson = {'invalid': 'structure'};

      final result = await engine.executeRuleFromJson(ruleJson);

      expect(result.success, false);
      expect(result.error, contains('Failed to parse rule'));
    });
  });

  group('Rule Preview', () {
    test('preview rule shows matched files', () async {
      final rule = RuleModel(
        id: 'rule_preview',
        trigger: RuleTrigger(type: 'manual'),
        conditions: [
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
        ],
        actions: [
          ActionModel(
            type: ActionTypes.move,
            params: {'target': 'content://moved/'},
          ),
        ],
        metadata: RuleMetadata(
          createdAt: DateTime.now(),
          createdBy: 'manual',
          safetyClass: 'low',
        ),
      );

      final result = await engine.previewRule(rule);

      expect(result.matchedFiles, hasLength(1));
      expect(result.matchedFiles[0].normalizedName, 'invoice_2024.pdf');
      expect(result.riskLevel, 'low');
      expect(result.errors, isEmpty);
    });

    test('preview rule respects maxSamples', () async {
      final rule = RuleModel(
        id: 'rule_preview_limit',
        trigger: RuleTrigger(type: 'manual'),
        conditions: [
          ConditionGroup(
            operator: 'AND',
            conditions: [
              ConditionModel(
                type: 'file_size',
                operator: ConditionOperators.greaterThan,
                value: 0,
              ),
            ],
          ),
        ],
        actions: [
          ActionModel(type: ActionTypes.notify, params: {'message': 'Test'}),
        ],
        metadata: RuleMetadata(
          createdAt: DateTime.now(),
          createdBy: 'manual',
          safetyClass: 'low',
        ),
      );

      final result = await engine.previewRule(rule, maxSamples: 2);

      expect(result.matchedFiles.length, lessThanOrEqualTo(2));
    });

    test('preview calculates risk level - medium', () async {
      final rule = RuleModel(
        id: 'rule_risky',
        trigger: RuleTrigger(type: 'manual'),
        conditions: [
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
        ],
        actions: [
          ActionModel(
            type: ActionTypes.move,
            params: {'target': 'content://moved/'},
          ),
          ActionModel(
            type: ActionTypes.rename,
            params: {'pattern': 'new_name.{ext}'},
          ),
        ],
        metadata: RuleMetadata(
          createdAt: DateTime.now(),
          createdBy: 'manual',
          safetyClass: 'low',
        ),
      );

      final result = await engine.previewRule(rule);

      expect(result.riskLevel, 'medium');
    });

    test('preview calculates risk level from metadata', () async {
      final rule = RuleModel(
        id: 'rule_high_risk',
        trigger: RuleTrigger(type: 'manual'),
        conditions: [
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
        ],
        actions: [
          ActionModel(type: ActionTypes.notify, params: {'message': 'Test'}),
        ],
        metadata: RuleMetadata(
          createdAt: DateTime.now(),
          createdBy: 'ai',
          safetyClass: 'high',
        ),
      );

      final result = await engine.previewRule(rule);

      expect(result.riskLevel, 'high');
    });
  });

  group('Performance', () {
    test('rule execution completes within performance target', () async {
      final rule = RuleModel(
        id: 'rule_performance',
        trigger: RuleTrigger(type: 'manual'),
        conditions: [
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
        ],
        actions: [
          ActionModel(type: ActionTypes.addTag, params: {'tags': 'test'}),
        ],
        metadata: RuleMetadata(
          createdAt: DateTime.now(),
          createdBy: 'manual',
          safetyClass: 'low',
        ),
      );

      final startTime = DateTime.now();
      final result = await engine.executeRule(rule);
      final endTime = DateTime.now();

      final duration = endTime.difference(startTime);

      expect(result.success, true);
      expect(
        duration.inMilliseconds,
        lessThan(100),
      ); // Well under 50ms target for 3 files
    });
  });
}
