import '../../data/models/rule_model.dart';
import '../../data/models/condition_model.dart';
import '../../data/models/action_model.dart';

/// Parser for rule JSON to Dart objects
///
/// Converts JSON rule definitions into RuleModel instances
/// with validation and error handling
class RuleParser {
  /// Parse a rule from JSON
  ///
  /// Returns RuleParseResult with success/failure state
  RuleParseResult parseRule(Map<String, dynamic> json) {
    try {
      final rule = RuleModel.fromJson(json);
      return RuleParseResult.success(rule);
    } catch (e) {
      return RuleParseResult.failure('Failed to parse rule: $e');
    }
  }

  /// Parse multiple rules from JSON array
  ///
  /// Returns list of results, one per rule
  List<RuleParseResult> parseRules(List<dynamic> jsonList) {
    return jsonList.map((json) {
      if (json is! Map<String, dynamic>) {
        return RuleParseResult.failure(
          'Invalid rule format: expected object, got ${json.runtimeType}',
        );
      }
      return parseRule(json);
    }).toList();
  }

  /// Validate rule structure without full parsing
  ///
  /// Quick check for required fields
  bool hasRequiredFields(Map<String, dynamic> json) {
    return json.containsKey('id') &&
        json.containsKey('trigger') &&
        json.containsKey('conditions') &&
        json.containsKey('actions') &&
        json.containsKey('metadata');
  }
}

/// Result of rule parsing operation
class RuleParseResult {
  final bool success;
  final RuleModel? rule;
  final String? error;

  RuleParseResult({required this.success, this.rule, this.error});

  factory RuleParseResult.success(RuleModel rule) {
    return RuleParseResult(success: true, rule: rule);
  }

  factory RuleParseResult.failure(String error) {
    return RuleParseResult(success: false, error: error);
  }
}
