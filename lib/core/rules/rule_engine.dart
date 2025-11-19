import '../../data/models/rule_model.dart';
import '../../data/models/action_model.dart';
import '../../data/db/database.dart';
import 'rule_parser.dart';
import 'rule_validator.dart';
import 'condition_evaluator.dart';
import 'action_executor.dart';

/// Main rule engine orchestrator
///
/// Executes the complete pipeline per rule_engine_ultra.md:
/// 1. Load candidate files
/// 2. Filter with condition tree
/// 3. Construct Action Plan
/// 4. Execute with atomic guarantees
/// 5. Persist audit logs
/// 6. Notify Flutter
///
/// Performance target: < 50ms per rule evaluation
class RuleEngine {
  final FiloDatabase database;
  final RuleParser parser;
  final RuleValidator validator;
  final ConditionEvaluator conditionEvaluator;
  final ActionExecutor actionExecutor;

  RuleEngine(this.database)
    : parser = RuleParser(),
      validator = RuleValidator(),
      conditionEvaluator = ConditionEvaluator(),
      actionExecutor = ActionExecutor(database);

  /// Execute a rule against candidate files
  ///
  /// Returns execution result with matched files and action outcomes
  Future<RuleExecutionResult> executeRule(
    RuleModel rule, {
    List<FileIndexEntry>? candidateFiles,
  }) async {
    final startTime = DateTime.now();

    try {
      // Step 1: Validate rule
      final validationResult = validator.validateRule(rule);
      if (!validationResult.isValid) {
        return RuleExecutionResult.failure(
          rule.id,
          'Validation failed: ${validationResult.errors.join(", ")}',
          duration: DateTime.now().difference(startTime),
        );
      }

      // Step 2: Load candidate files
      final candidates =
          candidateFiles ?? await database.filesDao.getAllFiles();

      // Step 3: Filter files with condition evaluation
      final matchedFiles = <FileIndexEntry>[];
      for (final file in candidates) {
        final matches = await conditionEvaluator.evaluateConditionGroups(
          rule.conditions,
          file,
        );
        if (matches) {
          matchedFiles.add(file);
        }
      }

      if (matchedFiles.isEmpty) {
        return RuleExecutionResult.success(
          ruleId: rule.id,
          matchedFiles: [],
          actionResults: {},
          duration: DateTime.now().difference(startTime),
        );
      }

      // Step 4: Execute actions on matched files
      final allActionResults = <int, List<ActionResult>>{};
      for (final file in matchedFiles) {
        final results = await actionExecutor.executeActions(rule.actions, file);
        allActionResults[file.id] = results;
      }

      // Step 5: Log execution to rule_execution_log
      await _logRuleExecution(rule.id, matchedFiles, allActionResults);

      final duration = DateTime.now().difference(startTime);
      return RuleExecutionResult.success(
        ruleId: rule.id,
        matchedFiles: matchedFiles,
        actionResults: allActionResults,
        duration: duration,
      );
    } catch (e) {
      return RuleExecutionResult.failure(
        rule.id,
        'Exception during execution: $e',
        duration: DateTime.now().difference(startTime),
      );
    }
  }

  /// Execute rule from JSON
  Future<RuleExecutionResult> executeRuleFromJson(
    Map<String, dynamic> ruleJson, {
    List<FileIndexEntry>? candidateFiles,
  }) async {
    final parseResult = parser.parseRule(ruleJson);
    if (!parseResult.success || parseResult.rule == null) {
      return RuleExecutionResult.failure(
        ruleJson['id']?.toString() ?? 'unknown',
        'Failed to parse rule: ${parseResult.error}',
        duration: Duration.zero,
      );
    }

    return executeRule(parseResult.rule!, candidateFiles: candidateFiles);
  }

  /// Preview rule execution (dry run)
  ///
  /// Shows which files would match without executing actions
  Future<RulePreviewResult> previewRule(
    RuleModel rule, {
    List<FileIndexEntry>? candidateFiles,
    int maxSamples = 10,
  }) async {
    final startTime = DateTime.now();

    // Validate rule
    final validationResult = validator.validateRule(rule);
    if (!validationResult.isValid) {
      return RulePreviewResult(
        ruleId: rule.id,
        matchedFiles: [],
        riskLevel: _calculateRiskLevel(rule),
        errors: validationResult.errors,
        duration: DateTime.now().difference(startTime),
      );
    }

    // Load candidates
    final candidates = candidateFiles ?? await database.filesDao.getAllFiles();

    // Filter with conditions
    final matchedFiles = <FileIndexEntry>[];
    for (final file in candidates) {
      if (matchedFiles.length >= maxSamples) break;

      final matches = await conditionEvaluator.evaluateConditionGroups(
        rule.conditions,
        file,
      );
      if (matches) {
        matchedFiles.add(file);
      }
    }

    return RulePreviewResult(
      ruleId: rule.id,
      matchedFiles: matchedFiles,
      riskLevel: _calculateRiskLevel(rule),
      errors: [],
      duration: DateTime.now().difference(startTime),
    );
  }

  /// Calculate risk level for rule (per safety framework)
  String _calculateRiskLevel(RuleModel rule) {
    // Use metadata safety class if available
    if (rule.metadata.safetyClass == 'high') return 'high';
    if (rule.metadata.safetyClass == 'medium') return 'medium';

    // Check for risky actions
    final hasMove = rule.actions.any((a) => a.type == ActionTypes.move);
    final hasRename = rule.actions.any((a) => a.type == ActionTypes.rename);

    if (hasMove && hasRename) return 'medium';
    if (hasMove || hasRename) return 'low';

    return 'low';
  }

  /// Log rule execution to database
  Future<void> _logRuleExecution(
    String ruleId,
    List<FileIndexEntry> matchedFiles,
    Map<int, List<ActionResult>> actionResults,
  ) async {
    for (final file in matchedFiles) {
      final results = actionResults[file.id] ?? [];
      final allSuccess = results.every((r) => r.success);

      // Log to activity_log
      await database.activityLogDao.logActivity(
        activityType: 'rule_executed',
        description:
            'Rule $ruleId ${allSuccess ? "succeeded" : "failed"} on ${file.normalizedName}',
        metadataJson:
            '{"rule_id": "$ruleId", "file_id": ${file.id}, "success": $allSuccess}',
        relatedFileId: file.id,
      );
    }
  }
}

/// Result of rule execution
class RuleExecutionResult {
  final bool success;
  final String ruleId;
  final List<FileIndexEntry> matchedFiles;
  final Map<int, List<ActionResult>> actionResults;
  final String? error;
  final Duration duration;

  RuleExecutionResult({
    required this.success,
    required this.ruleId,
    required this.matchedFiles,
    required this.actionResults,
    this.error,
    required this.duration,
  });

  factory RuleExecutionResult.success({
    required String ruleId,
    required List<FileIndexEntry> matchedFiles,
    required Map<int, List<ActionResult>> actionResults,
    required Duration duration,
  }) {
    return RuleExecutionResult(
      success: true,
      ruleId: ruleId,
      matchedFiles: matchedFiles,
      actionResults: actionResults,
      duration: duration,
    );
  }

  factory RuleExecutionResult.failure(
    String ruleId,
    String error, {
    required Duration duration,
  }) {
    return RuleExecutionResult(
      success: false,
      ruleId: ruleId,
      matchedFiles: [],
      actionResults: {},
      error: error,
      duration: duration,
    );
  }
}

/// Result of rule preview (dry run)
class RulePreviewResult {
  final String ruleId;
  final List<FileIndexEntry> matchedFiles;
  final String riskLevel; // 'low', 'medium', 'high'
  final List<String> errors;
  final Duration duration;

  RulePreviewResult({
    required this.ruleId,
    required this.matchedFiles,
    required this.riskLevel,
    required this.errors,
    required this.duration,
  });
}
