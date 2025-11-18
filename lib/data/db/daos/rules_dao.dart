// Rules DAO - Data access for automation rules
// Refs: database_schema_ultra.md, rule_engine_ultra.md

import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/rules_table.dart';
import '../tables/rule_execution_log_table.dart';

part 'rules_dao.g.dart';

@DriftAccessor(tables: [Rules, RuleExecutionLog])
class RulesDao extends DatabaseAccessor<FiloDatabase> with _$RulesDaoMixin {
  RulesDao(FiloDatabase db) : super(db);

  // Get all enabled rules ordered by priority
  Future<List<Rule>> getEnabledRules() =>
      (select(rules)
            ..where((r) => r.isEnabled.equals(true))
            ..orderBy([(r) => OrderingTerm.desc(r.priority)]))
          .get();

  // Get all rules
  Future<List<Rule>> getAllRules() => select(rules).get();

  // Get rule by ID
  Future<Rule?> getRuleById(int id) =>
      (select(rules)..where((r) => r.id.equals(id))).getSingleOrNull();

  // Insert rule
  Future<int> insertRule(RulesCompanion entry) => into(rules).insert(entry);

  // Update rule
  Future<bool> updateRule(Rule entry) => update(rules).replace(entry);

  // Delete rule
  Future<int> deleteRule(int id) =>
      (delete(rules)..where((r) => r.id.equals(id))).go();

  // Toggle rule enabled status
  Future<int> toggleRuleEnabled(int id, bool enabled) =>
      (update(rules)..where((r) => r.id.equals(id))).write(
        RulesCompanion(
          isEnabled: Value(enabled),
          updatedAt: Value(DateTime.now()),
        ),
      );

  // Log rule execution
  Future<int> logExecution({
    required int ruleId,
    required int fileId,
    required String status,
    String? errorMessage,
    int? durationMs,
  }) => into(ruleExecutionLog).insert(
    RuleExecutionLogCompanion.insert(
      ruleId: ruleId,
      fileId: fileId,
      status: status,
      errorMessage: Value(errorMessage),
      durationMs: Value(durationMs),
    ),
  );

  // Get execution logs for a rule
  Future<List<RuleExecutionLogEntry>> getExecutionLogs(int ruleId) =>
      (select(ruleExecutionLog)
            ..where((l) => l.ruleId.equals(ruleId))
            ..orderBy([(l) => OrderingTerm.desc(l.executedAt)]))
          .get();

  // Get recent execution logs
  Future<List<RuleExecutionLogEntry>> getRecentLogs(int limit) =>
      (select(ruleExecutionLog)
            ..orderBy([(l) => OrderingTerm.desc(l.executedAt)])
            ..limit(limit))
          .get();
}
