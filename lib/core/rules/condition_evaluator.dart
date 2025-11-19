import '../../data/models/condition_model.dart';
import '../../data/models/rule_model.dart';
import '../../data/db/database.dart';

/// Condition evaluator for rule matching
///
/// Evaluates conditions against file data with support for:
/// - String operators (equals, contains, starts_with, ends_with, regex)
/// - Numeric operators (greater_than, less_than, between)
/// - Date operators (before, after, date_range)
/// - Array operators (includes, excludes, includes_any, includes_all)
/// - Boolean operators (is_true, is_false)
///
/// Per rule_engine_ultra.md: short-circuit evaluation and AND/OR logic
class ConditionEvaluator {
  /// Evaluate all condition groups against file
  ///
  /// Returns true if ANY condition group matches (OR logic at top level)
  Future<bool> evaluateConditionGroups(
    List<ConditionGroup> groups,
    FileIndexEntry file,
  ) async {
    for (final group in groups) {
      final result = await evaluateConditionGroup(group, file);
      if (result) return true; // Short-circuit on first match
    }
    return false;
  }

  /// Evaluate a single condition group
  ///
  /// Returns true if all (AND) or any (OR) conditions match
  Future<bool> evaluateConditionGroup(
    ConditionGroup group,
    FileIndexEntry file,
  ) async {
    if (group.operator == 'AND') {
      for (final condition in group.conditions) {
        final result = await evaluateCondition(condition, file);
        if (!result) return false; // Short-circuit on first failure
      }
      return true;
    } else {
      // OR operator
      for (final condition in group.conditions) {
        final result = await evaluateCondition(condition, file);
        if (result) return true; // Short-circuit on first match
      }
      return false;
    }
  }

  /// Evaluate a single condition
  Future<bool> evaluateCondition(
    ConditionModel condition,
    FileIndexEntry file,
  ) async {
    switch (condition.type) {
      case 'extension':
        return _evaluateExtension(condition, file);
      case 'mime':
        return _evaluateMime(condition, file);
      case 'folder':
        return _evaluateFolder(condition, file);
      case 'filename_regex':
        return _evaluateFilenameRegex(condition, file);
      case 'ocr_contains':
        return await _evaluateOcrContains(condition, file);
      case 'image_labels_include':
        return await _evaluateImageLabels(condition, file);
      case 'file_size':
        return _evaluateFileSize(condition, file);
      case 'created_date':
        return _evaluateCreatedDate(condition, file);
      case 'modified_date':
        return _evaluateModifiedDate(condition, file);
      default:
        return false;
    }
  }

  /// Evaluate extension condition
  bool _evaluateExtension(ConditionModel condition, FileIndexEntry file) {
    final filename = file.normalizedName;
    final extension = filename.contains('.')
        ? filename.substring(filename.lastIndexOf('.') + 1).toLowerCase()
        : '';
    return _evaluateStringOperator(
      condition.operator,
      extension,
      condition.value,
    );
  }

  /// Evaluate MIME type condition
  bool _evaluateMime(ConditionModel condition, FileIndexEntry file) {
    return _evaluateStringOperator(
      condition.operator,
      file.mime,
      condition.value,
    );
  }

  /// Evaluate folder/directory condition
  bool _evaluateFolder(ConditionModel condition, FileIndexEntry file) {
    // Extract directory from SAF URI
    final uri = file.uri;
    final directoryPath = uri.contains('/')
        ? uri.substring(0, uri.lastIndexOf('/'))
        : '';
    return _evaluateStringOperator(
      condition.operator,
      directoryPath,
      condition.value,
    );
  }

  /// Evaluate filename regex condition
  bool _evaluateFilenameRegex(ConditionModel condition, FileIndexEntry file) {
    return _evaluateStringOperator(
      condition.operator,
      file.normalizedName,
      condition.value,
    );
  }

  /// Evaluate OCR text content condition
  Future<bool> _evaluateOcrContains(
    ConditionModel condition,
    FileIndexEntry file,
  ) async {
    // TODO: Query extracted_text table for file.id
    // For now, return false (will be implemented with database integration)
    return false;
  }

  /// Evaluate image labels condition
  Future<bool> _evaluateImageLabels(
    ConditionModel condition,
    FileIndexEntry file,
  ) async {
    // TODO: Query image_labels table for file.id
    // For now, return false (will be implemented with database integration)
    return false;
  }

  /// Evaluate file size condition
  bool _evaluateFileSize(ConditionModel condition, FileIndexEntry file) {
    final size = file.size;
    return _evaluateNumericOperator(condition.operator, size, condition.value);
  }

  /// Evaluate created date condition
  bool _evaluateCreatedDate(ConditionModel condition, FileIndexEntry file) {
    return _evaluateDateOperator(
      condition.operator,
      file.createdAt,
      condition.value,
    );
  }

  /// Evaluate modified date condition
  bool _evaluateModifiedDate(ConditionModel condition, FileIndexEntry file) {
    return _evaluateDateOperator(
      condition.operator,
      file.modifiedAt,
      condition.value,
    );
  }

  /// Evaluate string operators
  bool _evaluateStringOperator(
    String operator,
    String actual,
    dynamic expected,
  ) {
    final expectedStr = expected.toString().toLowerCase();
    final actualLower = actual.toLowerCase();

    switch (operator) {
      case ConditionOperators.equals:
        return actualLower == expectedStr;
      case ConditionOperators.notEquals:
        return actualLower != expectedStr;
      case ConditionOperators.contains:
        return actualLower.contains(expectedStr);
      case ConditionOperators.notContains:
        return !actualLower.contains(expectedStr);
      case ConditionOperators.startsWith:
        return actualLower.startsWith(expectedStr);
      case ConditionOperators.endsWith:
        return actualLower.endsWith(expectedStr);
      case ConditionOperators.regex:
        try {
          final regex = RegExp(expected.toString(), caseSensitive: false);
          return regex.hasMatch(actual);
        } catch (e) {
          return false;
        }
      default:
        return false;
    }
  }

  /// Evaluate numeric operators
  bool _evaluateNumericOperator(String operator, int actual, dynamic expected) {
    switch (operator) {
      case ConditionOperators.greaterThan:
        return actual > (expected as num).toInt();
      case ConditionOperators.lessThan:
        return actual < (expected as num).toInt();
      case ConditionOperators.between:
        if (expected is List && expected.length == 2) {
          final min = (expected[0] as num).toInt();
          final max = (expected[1] as num).toInt();
          return actual >= min && actual <= max;
        }
        return false;
      default:
        return false;
    }
  }

  /// Evaluate date operators
  bool _evaluateDateOperator(
    String operator,
    DateTime actual,
    dynamic expected,
  ) {
    switch (operator) {
      case ConditionOperators.before:
        final expectedDate = DateTime.parse(expected.toString());
        return actual.isBefore(expectedDate);
      case ConditionOperators.after:
        final expectedDate = DateTime.parse(expected.toString());
        return actual.isAfter(expectedDate);
      case ConditionOperators.dateRange:
        if (expected is List && expected.length == 2) {
          final start = DateTime.parse(expected[0].toString());
          final end = DateTime.parse(expected[1].toString());
          return actual.isAfter(start) && actual.isBefore(end);
        }
        return false;
      default:
        return false;
    }
  }

  /// Evaluate array operators (for image labels, tags, etc.)
  bool _evaluateArrayOperator(
    String operator,
    List<String> actual,
    dynamic expected,
  ) {
    switch (operator) {
      case ConditionOperators.includes:
        return actual.contains(expected.toString());
      case ConditionOperators.excludes:
        return !actual.contains(expected.toString());
      case ConditionOperators.includesAny:
        if (expected is List) {
          return expected.any((item) => actual.contains(item.toString()));
        }
        return false;
      case ConditionOperators.includesAll:
        if (expected is List) {
          return expected.every((item) => actual.contains(item.toString()));
        }
        return false;
      default:
        return false;
    }
  }
}
