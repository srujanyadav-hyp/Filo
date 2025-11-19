import '../../data/models/rule_model.dart';
import '../../data/models/condition_model.dart';
import '../../data/models/action_model.dart';

/// Schema validator for rule JSON
///
/// Validates rule structure, field types, and business logic constraints
/// per rule_engine_ultra.md safety requirements
class RuleValidator {
  /// Validate a complete rule
  ValidationResult validateRule(RuleModel rule) {
    final errors = <String>[];

    // Validate ID
    if (rule.id.isEmpty) {
      errors.add('Rule ID cannot be empty');
    }

    // Validate trigger
    final triggerResult = validateTrigger(rule.trigger);
    if (!triggerResult.isValid) {
      errors.addAll(triggerResult.errors);
    }

    // Validate conditions
    if (rule.conditions.isEmpty) {
      errors.add('Rule must have at least one condition group');
    }
    for (final group in rule.conditions) {
      final condResult = validateConditionGroup(group);
      if (!condResult.isValid) {
        errors.addAll(condResult.errors);
      }
    }

    // Validate actions
    if (rule.actions.isEmpty) {
      errors.add('Rule must have at least one action');
    }
    for (final action in rule.actions) {
      final actionResult = validateAction(action);
      if (!actionResult.isValid) {
        errors.addAll(actionResult.errors);
      }
    }

    // Validate metadata
    final metadataResult = validateMetadata(rule.metadata);
    if (!metadataResult.isValid) {
      errors.addAll(metadataResult.errors);
    }

    return errors.isEmpty
        ? ValidationResult.success()
        : ValidationResult.failure(errors);
  }

  /// Validate trigger configuration
  ValidationResult validateTrigger(RuleTrigger trigger) {
    final errors = <String>[];
    final validTypes = ['manual', 'on_file_added', 'scheduled'];

    if (!validTypes.contains(trigger.type)) {
      errors.add(
        'Invalid trigger type: ${trigger.type}. Must be one of: ${validTypes.join(", ")}',
      );
    }

    return errors.isEmpty
        ? ValidationResult.success()
        : ValidationResult.failure(errors);
  }

  /// Validate condition group
  ValidationResult validateConditionGroup(ConditionGroup group) {
    final errors = <String>[];

    if (group.operator != 'AND' && group.operator != 'OR') {
      errors.add('Condition group operator must be AND or OR');
    }

    if (group.conditions.isEmpty) {
      errors.add('Condition group must have at least one condition');
    }

    for (final condition in group.conditions) {
      final condResult = validateCondition(condition);
      if (!condResult.isValid) {
        errors.addAll(condResult.errors);
      }
    }

    return errors.isEmpty
        ? ValidationResult.success()
        : ValidationResult.failure(errors);
  }

  /// Validate individual condition
  ValidationResult validateCondition(ConditionModel condition) {
    final errors = <String>[];

    // Validate condition type
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
    if (!validTypes.contains(condition.type)) {
      errors.add('Invalid condition type: ${condition.type}');
    }

    // Validate operator for condition type
    final validOperators = ConditionOperators.getValidOperators(condition.type);
    if (!validOperators.contains(condition.operator)) {
      errors.add(
        'Invalid operator "${condition.operator}" for condition type "${condition.type}"',
      );
    }

    // Validate value is not null
    if (condition.value == null) {
      errors.add('Condition value cannot be null');
    }

    return errors.isEmpty
        ? ValidationResult.success()
        : ValidationResult.failure(errors);
  }

  /// Validate action configuration
  ValidationResult validateAction(ActionModel action) {
    final errors = <String>[];

    if (!ActionTypes.isValid(action.type)) {
      errors.add('Invalid action type: ${action.type}');
    }

    // Validate required parameters per action type
    switch (action.type) {
      case ActionTypes.move:
        if (!action.params.containsKey('target')) {
          errors.add('move action requires "target" parameter');
        }
        break;
      case ActionTypes.rename:
        if (!action.params.containsKey('pattern')) {
          errors.add('rename action requires "pattern" parameter');
        }
        break;
      case ActionTypes.addTag:
        if (!action.params.containsKey('tags')) {
          errors.add('add_tag action requires "tags" parameter');
        }
        break;
      case ActionTypes.notify:
        if (!action.params.containsKey('message')) {
          errors.add('notify action requires "message" parameter');
        }
        break;
    }

    return errors.isEmpty
        ? ValidationResult.success()
        : ValidationResult.failure(errors);
  }

  /// Validate metadata
  ValidationResult validateMetadata(RuleMetadata metadata) {
    final errors = <String>[];

    if (metadata.createdBy != 'ai' && metadata.createdBy != 'manual') {
      errors.add('created_by must be "ai" or "manual"');
    }

    final validSafetyClasses = ['low', 'medium', 'high'];
    if (!validSafetyClasses.contains(metadata.safetyClass)) {
      errors.add(
        'safety_class must be one of: ${validSafetyClasses.join(", ")}',
      );
    }

    return errors.isEmpty
        ? ValidationResult.success()
        : ValidationResult.failure(errors);
  }
}

/// Result of validation operation
class ValidationResult {
  final bool isValid;
  final List<String> errors;

  ValidationResult({required this.isValid, required this.errors});

  factory ValidationResult.success() {
    return ValidationResult(isValid: true, errors: []);
  }

  factory ValidationResult.failure(List<String> errors) {
    return ValidationResult(isValid: false, errors: errors);
  }
}
