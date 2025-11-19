/// Action model for rule execution
///
/// Supported actions (per rule_engine_ultra.md):
/// - move: Move file to different directory
/// - rename: Rename file with pattern
/// - add_tag: Add metadata tags
/// - notify: Show user notification
class ActionModel {
  final String type;
  final Map<String, dynamic> params;

  ActionModel({required this.type, required this.params});

  factory ActionModel.fromJson(Map<String, dynamic> json) {
    return ActionModel(
      type: json['type'] as String,
      params: json['params'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'params': params};
  }
}

/// Action types supported by the rule engine
class ActionTypes {
  static const String move = 'move';
  static const String rename = 'rename';
  static const String addTag = 'add_tag';
  static const String notify = 'notify';

  static const List<String> all = [move, rename, addTag, notify];

  /// Validate if action type is supported
  static bool isValid(String type) => all.contains(type);
}

/// Action execution result
class ActionResult {
  final bool success;
  final String actionType;
  final String? error;
  final Map<String, dynamic>? metadata;

  ActionResult({
    required this.success,
    required this.actionType,
    this.error,
    this.metadata,
  });

  factory ActionResult.success(
    String actionType, {
    Map<String, dynamic>? metadata,
  }) {
    return ActionResult(
      success: true,
      actionType: actionType,
      metadata: metadata,
    );
  }

  factory ActionResult.failure(String actionType, String error) {
    return ActionResult(success: false, actionType: actionType, error: error);
  }
}
