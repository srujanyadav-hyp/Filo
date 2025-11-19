import 'action_model.dart';
import 'condition_model.dart';

/// Rule model representing an automation rule in FILO
///
/// A rule consists of:
/// - Trigger: Event that activates the rule
/// - Conditions: Criteria for file matching
/// - Actions: Operations to perform on matched files
/// - Metadata: Rule creation info and safety classification
class RuleModel {
  final String id;
  final RuleTrigger trigger;
  final List<ConditionGroup> conditions;
  final List<ActionModel> actions;
  final RuleMetadata metadata;

  RuleModel({
    required this.id,
    required this.trigger,
    required this.conditions,
    required this.actions,
    required this.metadata,
  });

  factory RuleModel.fromJson(Map<String, dynamic> json) {
    return RuleModel(
      id: json['id'] as String,
      trigger: RuleTrigger.fromJson(json['trigger'] as Map<String, dynamic>),
      conditions: (json['conditions'] as List)
          .map((c) => ConditionGroup.fromJson(c as Map<String, dynamic>))
          .toList(),
      actions: (json['actions'] as List)
          .map((a) => ActionModel.fromJson(a as Map<String, dynamic>))
          .toList(),
      metadata: RuleMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trigger': trigger.toJson(),
      'conditions': conditions.map((c) => c.toJson()).toList(),
      'actions': actions.map((a) => a.toJson()).toList(),
      'metadata': metadata.toJson(),
    };
  }
}

/// Trigger configuration for when a rule should execute
class RuleTrigger {
  final String type; // 'manual', 'on_file_added', 'scheduled'
  final Map<String, dynamic>? config;

  RuleTrigger({required this.type, this.config});

  factory RuleTrigger.fromJson(Map<String, dynamic> json) {
    return RuleTrigger(
      type: json['type'] as String,
      config: json['config'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'type': type, if (config != null) 'config': config};
  }
}

/// Group of conditions with logical operator (AND/OR)
class ConditionGroup {
  final String operator; // 'AND' or 'OR'
  final List<ConditionModel> conditions;

  ConditionGroup({required this.operator, required this.conditions});

  factory ConditionGroup.fromJson(Map<String, dynamic> json) {
    return ConditionGroup(
      operator: json['operator'] as String,
      conditions: (json['conditions'] as List)
          .map((c) => ConditionModel.fromJson(c as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'operator': operator,
      'conditions': conditions.map((c) => c.toJson()).toList(),
    };
  }
}

/// Metadata about rule creation and safety
class RuleMetadata {
  final DateTime createdAt;
  final String createdBy; // 'ai' or 'manual'
  final String safetyClass; // 'low', 'medium', 'high'
  final String? description;

  RuleMetadata({
    required this.createdAt,
    required this.createdBy,
    required this.safetyClass,
    this.description,
  });

  factory RuleMetadata.fromJson(Map<String, dynamic> json) {
    return RuleMetadata(
      createdAt: DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as String,
      safetyClass: json['safety_class'] as String,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt.toIso8601String(),
      'created_by': createdBy,
      'safety_class': safetyClass,
      if (description != null) 'description': description,
    };
  }
}
