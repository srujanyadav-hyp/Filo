/// Condition model for rule evaluation
///
/// Supported condition types (per rule_engine_ultra.md):
/// - extension: File extension matching
/// - mime: MIME type matching
/// - folder: Directory path matching
/// - filename_regex: Filename pattern matching
/// - ocr_contains: Text content matching
/// - image_labels_include: ML label matching
/// - file_size: Size comparison
/// - created_date: Creation date comparison
/// - modified_date: Modification date comparison
class ConditionModel {
  final String type;
  final String operator;
  final dynamic value;
  final Map<String, dynamic>? metadata;

  ConditionModel({
    required this.type,
    required this.operator,
    required this.value,
    this.metadata,
  });

  factory ConditionModel.fromJson(Map<String, dynamic> json) {
    return ConditionModel(
      type: json['type'] as String,
      operator: json['operator'] as String,
      value: json['value'],
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'operator': operator,
      'value': value,
      if (metadata != null) 'metadata': metadata,
    };
  }
}

/// Supported operators for different condition types
class ConditionOperators {
  // String operators
  static const String equals = 'equals';
  static const String contains = 'contains';
  static const String startsWith = 'starts_with';
  static const String endsWith = 'ends_with';
  static const String regex = 'regex';
  static const String notEquals = 'not_equals';
  static const String notContains = 'not_contains';

  // Numeric operators
  static const String greaterThan = 'greater_than';
  static const String lessThan = 'less_than';
  static const String between = 'between';

  // Date operators
  static const String before = 'before';
  static const String after = 'after';
  static const String dateRange = 'date_range';

  // Array operators
  static const String includes = 'includes';
  static const String excludes = 'excludes';
  static const String includesAny = 'includes_any';
  static const String includesAll = 'includes_all';

  // Boolean operators
  static const String isTrue = 'is_true';
  static const String isFalse = 'is_false';

  /// Get valid operators for a condition type
  static List<String> getValidOperators(String conditionType) {
    switch (conditionType) {
      case 'extension':
      case 'mime':
        return [equals, notEquals, contains, startsWith, endsWith];
      case 'folder':
        return [equals, notEquals, contains, startsWith];
      case 'filename_regex':
        return [regex, notContains];
      case 'ocr_contains':
        return [contains, notContains, regex];
      case 'image_labels_include':
        return [includes, excludes, includesAny, includesAll];
      case 'file_size':
        return [greaterThan, lessThan, between];
      case 'created_date':
      case 'modified_date':
        return [before, after, dateRange];
      default:
        return [equals, notEquals];
    }
  }
}
