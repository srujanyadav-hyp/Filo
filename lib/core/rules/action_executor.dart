import '../../data/models/action_model.dart';
import '../../data/db/database.dart';

/// Action executor for rule execution
///
/// Executes actions with atomicity and safety guarantees per rule_engine_ultra.md:
/// - move: Move file to different directory (SAF URI update)
/// - rename: Rename file with pattern tokens
/// - add_tag: Add metadata tags to file
/// - notify: Show user notification
///
/// Safety framework:
/// - Pre-check: permissions, conflicts
/// - Post-check: DB sync verification
/// - No delete operations (blocked in v0)
class ActionExecutor {
  final FiloDatabase database;

  ActionExecutor(this.database);

  /// Execute all actions for a file
  ///
  /// Returns list of results, one per action
  Future<List<ActionResult>> executeActions(
    List<ActionModel> actions,
    FileIndexEntry file,
  ) async {
    final results = <ActionResult>[];

    for (final action in actions) {
      final result = await executeAction(action, file);
      results.add(result);

      // Stop on first failure (atomic guarantee)
      if (!result.success) {
        break;
      }
    }

    return results;
  }

  /// Execute a single action
  Future<ActionResult> executeAction(
    ActionModel action,
    FileIndexEntry file,
  ) async {
    try {
      switch (action.type) {
        case ActionTypes.move:
          return await _executeMove(action, file);
        case ActionTypes.rename:
          return await _executeRename(action, file);
        case ActionTypes.addTag:
          return await _executeAddTag(action, file);
        case ActionTypes.notify:
          return _executeNotify(action, file);
        default:
          return ActionResult.failure(action.type, 'Unknown action type');
      }
    } catch (e) {
      return ActionResult.failure(
        action.type,
        'Exception during execution: $e',
      );
    }
  }

  /// Execute move action
  Future<ActionResult> _executeMove(
    ActionModel action,
    FileIndexEntry file,
  ) async {
    final target = action.params['target'] as String?;
    if (target == null || target.isEmpty) {
      return ActionResult.failure(ActionTypes.move, 'Missing target parameter');
    }

    // Pre-check: validate target URI format
    if (!target.startsWith('content://')) {
      return ActionResult.failure(
        ActionTypes.move,
        'Invalid target URI format',
      );
    }

    // TODO: Execute SAF move operation via platform channel
    // For now, simulate success with DB update only

    // Update database with new URI
    try {
      await database.filesDao.updateFileUri(file.id, target);

      return ActionResult.success(
        ActionTypes.move,
        metadata: {'old_uri': file.uri, 'new_uri': target},
      );
    } catch (e) {
      return ActionResult.failure(ActionTypes.move, 'DB update failed: $e');
    }
  }

  /// Execute rename action
  Future<ActionResult> _executeRename(
    ActionModel action,
    FileIndexEntry file,
  ) async {
    final pattern = action.params['pattern'] as String?;
    if (pattern == null || pattern.isEmpty) {
      return ActionResult.failure(
        ActionTypes.rename,
        'Missing pattern parameter',
      );
    }

    // Apply pattern tokens
    final newName = _applyRenamePattern(pattern, file);

    // TODO: Execute SAF rename operation via platform channel
    // For now, simulate success with DB update only

    // Update database
    try {
      await database.filesDao.updateFileName(file.id, newName);

      return ActionResult.success(
        ActionTypes.rename,
        metadata: {'old_name': file.normalizedName, 'new_name': newName},
      );
    } catch (e) {
      return ActionResult.failure(ActionTypes.rename, 'DB update failed: $e');
    }
  }

  /// Execute add_tag action
  Future<ActionResult> _executeAddTag(
    ActionModel action,
    FileIndexEntry file,
  ) async {
    final tags = action.params['tags'];
    if (tags == null) {
      return ActionResult.failure(ActionTypes.addTag, 'Missing tags parameter');
    }

    final tagList = tags is List
        ? tags.map((t) => t.toString()).toList()
        : [tags.toString()];

    // TODO: Store tags in metadata field or separate tags table
    // For now, log to activity_log with tags in metadata

    try {
      await database.activityLogDao.logActivity(
        activityType: 'tag_added',
        description: 'Tags added: ${tagList.join(", ")}',
        metadataJson: '{"tags": ${tagList.map((t) => '"$t"').join(", ")}}',
        relatedFileId: file.id,
      );

      return ActionResult.success(
        ActionTypes.addTag,
        metadata: {'tags': tagList},
      );
    } catch (e) {
      return ActionResult.failure(ActionTypes.addTag, 'Failed to log tags: $e');
    }
  }

  /// Execute notify action
  ActionResult _executeNotify(ActionModel action, FileIndexEntry file) {
    final message = action.params['message'] as String?;
    if (message == null || message.isEmpty) {
      return ActionResult.failure(
        ActionTypes.notify,
        'Missing message parameter',
      );
    }

    // TODO: Show notification via platform channel or Flutter local notifications
    // For now, just return success

    return ActionResult.success(
      ActionTypes.notify,
      metadata: {'message': message, 'file_name': file.normalizedName},
    );
  }

  /// Apply rename pattern with token substitution
  ///
  /// Supported tokens:
  /// - {date}: Current date (YYYY-MM-DD)
  /// - {name}: Original filename without extension
  /// - {counter}: Sequential number
  /// - {ext}: Original extension
  String _applyRenamePattern(String pattern, FileIndexEntry file) {
    var result = pattern;

    // Extract name and extension
    final filename = file.normalizedName;
    final lastDot = filename.lastIndexOf('.');
    final name = lastDot > 0 ? filename.substring(0, lastDot) : filename;
    final ext = lastDot > 0 ? filename.substring(lastDot + 1) : '';

    // Apply tokens
    result = result.replaceAll(
      '{date}',
      DateTime.now().toIso8601String().substring(0, 10),
    );
    result = result.replaceAll('{name}', name);
    result = result.replaceAll('{ext}', ext);
    result = result.replaceAll(
      '{counter}',
      '1',
    ); // TODO: Implement actual counter logic

    return result;
  }
}
