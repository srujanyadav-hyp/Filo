import 'package:flutter_test/flutter_test.dart';
import 'package:filo/core/rules/rule_validator.dart';
import 'package:filo/data/models/rule_model.dart';
import 'package:filo/data/models/condition_model.dart';
import 'package:filo/data/models/action_model.dart';

void main() {
  late RuleValidator validator;

  setUp(() {
    validator = RuleValidator();
  });

  group('Rule Validation', () {
    test('valid rule passes validation', () {
      final rule = RuleModel(
        id: 'rule_001',
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
          ActionModel(type: ActionTypes.addTag, params: {'tags': 'processed'}),
        ],
        metadata: RuleMetadata(
          createdAt: DateTime.now(),
          createdBy: 'manual',
          safetyClass: 'low',
        ),
      );

      final result = validator.validateRule(rule);

      expect(result.isValid, true);
      expect(result.errors, isEmpty);
    });

    test('rule with empty ID fails', () {
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

      final result = validator.validateRule(rule);

      expect(result.isValid, false);
      expect(result.errors, contains('Rule ID cannot be empty'));
    });

    test('rule with no conditions fails', () {
      final rule = RuleModel(
        id: 'rule_002',
        trigger: RuleTrigger(type: 'manual'),
        conditions: [],
        actions: [
          ActionModel(type: ActionTypes.addTag, params: {'tags': 'test'}),
        ],
        metadata: RuleMetadata(
          createdAt: DateTime.now(),
          createdBy: 'manual',
          safetyClass: 'low',
        ),
      );

      final result = validator.validateRule(rule);

      expect(result.isValid, false);
      expect(
        result.errors,
        contains('Rule must have at least one condition group'),
      );
    });

    test('rule with no actions fails', () {
      final rule = RuleModel(
        id: 'rule_003',
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
        actions: [],
        metadata: RuleMetadata(
          createdAt: DateTime.now(),
          createdBy: 'manual',
          safetyClass: 'low',
        ),
      );

      final result = validator.validateRule(rule);

      expect(result.isValid, false);
      expect(result.errors, contains('Rule must have at least one action'));
    });
  });

  group('Trigger Validation', () {
    test('valid trigger types pass', () {
      final validTypes = ['manual', 'on_file_added', 'scheduled'];

      for (final type in validTypes) {
        final trigger = RuleTrigger(type: type);
        final result = validator.validateTrigger(trigger);
        expect(result.isValid, true, reason: 'Type $type should be valid');
      }
    });

    test('invalid trigger type fails', () {
      final trigger = RuleTrigger(type: 'invalid_type');
      final result = validator.validateTrigger(trigger);

      expect(result.isValid, false);
      expect(result.errors.first, contains('Invalid trigger type'));
    });
  });

  group('Condition Group Validation', () {
    test('valid AND group passes', () {
      final group = ConditionGroup(
        operator: 'AND',
        conditions: [
          ConditionModel(
            type: 'extension',
            operator: ConditionOperators.equals,
            value: 'pdf',
          ),
          ConditionModel(
            type: 'mime',
            operator: ConditionOperators.contains,
            value: 'application',
          ),
        ],
      );

      final result = validator.validateConditionGroup(group);

      expect(result.isValid, true);
    });

    test('valid OR group passes', () {
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
            value: 'docx',
          ),
        ],
      );

      final result = validator.validateConditionGroup(group);

      expect(result.isValid, true);
    });

    test('invalid operator fails', () {
      final group = ConditionGroup(
        operator: 'XOR',
        conditions: [
          ConditionModel(
            type: 'extension',
            operator: ConditionOperators.equals,
            value: 'pdf',
          ),
        ],
      );

      final result = validator.validateConditionGroup(group);

      expect(result.isValid, false);
      expect(
        result.errors,
        contains('Condition group operator must be AND or OR'),
      );
    });

    test('empty conditions list fails', () {
      final group = ConditionGroup(operator: 'AND', conditions: []);

      final result = validator.validateConditionGroup(group);

      expect(result.isValid, false);
      expect(
        result.errors,
        contains('Condition group must have at least one condition'),
      );
    });
  });

  group('Condition Validation', () {
    test('valid condition types pass', () {
      final validTypes = [
        'extension',
        'mime',
        'folder',
        'filename_regex',
        'ocr_contains',
        'image_labels_include',
        'file_size',
        'created_date',
        'modified_date',
      ];

      for (final type in validTypes) {
        final condition = ConditionModel(
          type: type,
          operator: ConditionOperators.getValidOperators(type)[0],
          value: 'test',
        );
        final result = validator.validateCondition(condition);
        expect(result.isValid, true, reason: 'Type $type should be valid');
      }
    });

    test('invalid condition type fails', () {
      final condition = ConditionModel(
        type: 'invalid_type',
        operator: ConditionOperators.equals,
        value: 'test',
      );

      final result = validator.validateCondition(condition);

      expect(result.isValid, false);
      expect(result.errors.first, contains('Invalid condition type'));
    });

    test('invalid operator for condition type fails', () {
      final condition = ConditionModel(
        type: 'file_size',
        operator: ConditionOperators.regex, // Invalid for file_size
        value: 1024,
      );

      final result = validator.validateCondition(condition);

      expect(result.isValid, false);
      expect(result.errors.first, contains('Invalid operator'));
    });

    test('null value fails', () {
      final condition = ConditionModel(
        type: 'extension',
        operator: ConditionOperators.equals,
        value: null,
      );

      final result = validator.validateCondition(condition);

      expect(result.isValid, false);
      expect(result.errors, contains('Condition value cannot be null'));
    });
  });

  group('Action Validation', () {
    test('valid move action passes', () {
      final action = ActionModel(
        type: ActionTypes.move,
        params: {'target': 'content://downloads/moved/'},
      );

      final result = validator.validateAction(action);

      expect(result.isValid, true);
    });

    test('move action without target fails', () {
      final action = ActionModel(type: ActionTypes.move, params: {});

      final result = validator.validateAction(action);

      expect(result.isValid, false);
      expect(
        result.errors,
        contains('move action requires "target" parameter'),
      );
    });

    test('rename action without pattern fails', () {
      final action = ActionModel(type: ActionTypes.rename, params: {});

      final result = validator.validateAction(action);

      expect(result.isValid, false);
      expect(
        result.errors,
        contains('rename action requires "pattern" parameter'),
      );
    });

    test('add_tag action without tags fails', () {
      final action = ActionModel(type: ActionTypes.addTag, params: {});

      final result = validator.validateAction(action);

      expect(result.isValid, false);
      expect(
        result.errors,
        contains('add_tag action requires "tags" parameter'),
      );
    });

    test('notify action without message fails', () {
      final action = ActionModel(type: ActionTypes.notify, params: {});

      final result = validator.validateAction(action);

      expect(result.isValid, false);
      expect(
        result.errors,
        contains('notify action requires "message" parameter'),
      );
    });

    test('invalid action type fails', () {
      final action = ActionModel(
        type: 'delete', // Not supported in v0
        params: {},
      );

      final result = validator.validateAction(action);

      expect(result.isValid, false);
      expect(result.errors.first, contains('Invalid action type'));
    });
  });

  group('Metadata Validation', () {
    test('valid metadata passes', () {
      final metadata = RuleMetadata(
        createdAt: DateTime.now(),
        createdBy: 'manual',
        safetyClass: 'low',
      );

      final result = validator.validateMetadata(metadata);

      expect(result.isValid, true);
    });

    test('invalid createdBy fails', () {
      final metadata = RuleMetadata(
        createdAt: DateTime.now(),
        createdBy: 'robot',
        safetyClass: 'low',
      );

      final result = validator.validateMetadata(metadata);

      expect(result.isValid, false);
      expect(
        result.errors.first,
        contains('created_by must be "ai" or "manual"'),
      );
    });

    test('invalid safetyClass fails', () {
      final metadata = RuleMetadata(
        createdAt: DateTime.now(),
        createdBy: 'manual',
        safetyClass: 'critical',
      );

      final result = validator.validateMetadata(metadata);

      expect(result.isValid, false);
      expect(result.errors.first, contains('safety_class must be one of'));
    });
  });
}
