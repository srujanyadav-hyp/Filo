// Activity Log DAO - Data access for user activity history
// Refs: database_schema_ultra.md, screens/activity_log_ultra.md

import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/activity_log_table.dart';

part 'activity_log_dao.g.dart';

@DriftAccessor(tables: [ActivityLog])
class ActivityLogDao extends DatabaseAccessor<FiloDatabase>
    with _$ActivityLogDaoMixin {
  ActivityLogDao(super.db);

  // Get all activity logs
  Future<List<ActivityLogEntry>> getAllLogs() => (select(
    activityLog,
  )..orderBy([(l) => OrderingTerm.desc(l.timestamp)])).get();

  // Get recent logs
  Future<List<ActivityLogEntry>> getRecentLogs(int limit) =>
      (select(activityLog)
            ..orderBy([(l) => OrderingTerm.desc(l.timestamp)])
            ..limit(limit))
          .get();

  // Get logs by activity type
  Future<List<ActivityLogEntry>> getLogsByType(String activityType) =>
      (select(activityLog)
            ..where((l) => l.activityType.equals(activityType))
            ..orderBy([(l) => OrderingTerm.desc(l.timestamp)]))
          .get();

  // Get logs for a specific file
  Future<List<ActivityLogEntry>> getLogsForFile(int fileId) =>
      (select(activityLog)
            ..where((l) => l.relatedFileId.equals(fileId))
            ..orderBy([(l) => OrderingTerm.desc(l.timestamp)]))
          .get();

  // Get logs for a specific rule
  Future<List<ActivityLogEntry>> getLogsForRule(int ruleId) =>
      (select(activityLog)
            ..where((l) => l.relatedRuleId.equals(ruleId))
            ..orderBy([(l) => OrderingTerm.desc(l.timestamp)]))
          .get();

  // Log activity
  Future<int> logActivity({
    required String activityType,
    required String description,
    String? metadataJson,
    int? relatedFileId,
    int? relatedRuleId,
  }) => into(activityLog).insert(
    ActivityLogCompanion.insert(
      activityType: activityType,
      description: description,
      metadataJson: Value(metadataJson),
      relatedFileId: Value(relatedFileId),
      relatedRuleId: Value(relatedRuleId),
    ),
  );

  // Delete old logs (cleanup)
  Future<int> deleteLogsOlderThan(DateTime cutoffDate) => (delete(
    activityLog,
  )..where((l) => l.timestamp.isSmallerThanValue(cutoffDate))).go();

  // Get log statistics by type
  Future<Map<String, int>> getLogStatsByType() async {
    final results = await customSelect(
      'SELECT activity_type, COUNT(*) as count FROM activity_log GROUP BY activity_type',
      readsFrom: {activityLog},
    ).get();

    return {
      for (var row in results)
        row.read<String>('activity_type'): row.read<int>('count'),
    };
  }
}
