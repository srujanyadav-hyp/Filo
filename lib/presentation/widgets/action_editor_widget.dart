// FILO Action Editor Widget
// Allows configuration of rule actions

import 'package:flutter/material.dart';
import '../../data/models/action_model.dart';
import '../theme/app_colors.dart';

/// Action Editor Widget
///
/// Displays and edits a single action with:
/// - Action type selector (move, rename, add_tag, notify)
/// - Parameter inputs based on action type
/// - Delete button
class ActionEditorWidget extends StatelessWidget {
  final ActionModel action;
  final ValueChanged<ActionModel> onUpdate;
  final VoidCallback onDelete;

  const ActionEditorWidget({
    super.key,
    required this.action,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Action type selector
                Expanded(flex: 2, child: _buildActionTypeSelector()),
                const SizedBox(width: 12),

                // Parameters input
                Expanded(flex: 4, child: _buildParametersInput()),

                // Delete button
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: onDelete,
                  tooltip: 'Remove action',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTypeSelector() {
    return DropdownButtonFormField<String>(
      value: action.type,
      decoration: InputDecoration(
        labelText: 'Action',
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items: const [
        DropdownMenuItem(value: 'move', child: Text('Move')),
        DropdownMenuItem(value: 'rename', child: Text('Rename')),
        DropdownMenuItem(value: 'add_tag', child: Text('Add Tag')),
        DropdownMenuItem(value: 'notify', child: Text('Notify')),
      ],
      onChanged: (value) {
        if (value != null) {
          onUpdate(
            ActionModel(type: value, params: _getDefaultParameters(value)),
          );
        }
      },
    );
  }

  Widget _buildParametersInput() {
    switch (action.type) {
      case 'move':
        return _buildMoveParameters();
      case 'rename':
        return _buildRenameParameters();
      case 'add_tag':
        return _buildAddTagParameters();
      case 'notify':
        return _buildNotifyParameters();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildMoveParameters() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Target Folder',
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        hintText: '/Documents',
      ),
      controller: TextEditingController(
        text: action.params['target_folder'] ?? '',
      ),
      onChanged: (value) {
        onUpdate(
          ActionModel(type: action.type, params: {'target_folder': value}),
        );
      },
    );
  }

  Widget _buildRenameParameters() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Name Pattern',
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        hintText: '{date}_{name}',
      ),
      controller: TextEditingController(text: action.params['pattern'] ?? ''),
      onChanged: (value) {
        onUpdate(ActionModel(type: action.type, params: {'pattern': value}));
      },
    );
  }

  Widget _buildAddTagParameters() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Tag',
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        hintText: 'important',
      ),
      controller: TextEditingController(text: action.params['tag'] ?? ''),
      onChanged: (value) {
        onUpdate(ActionModel(type: action.type, params: {'tag': value}));
      },
    );
  }

  Widget _buildNotifyParameters() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Message',
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        hintText: 'File processed',
      ),
      controller: TextEditingController(text: action.params['message'] ?? ''),
      onChanged: (value) {
        onUpdate(ActionModel(type: action.type, params: {'message': value}));
      },
    );
  }

  Map<String, dynamic> _getDefaultParameters(String actionType) {
    switch (actionType) {
      case 'move':
        return {'target_folder': ''};
      case 'rename':
        return {'pattern': ''};
      case 'add_tag':
        return {'tag': ''};
      case 'notify':
        return {'message': ''};
      default:
        return {};
    }
  }
}
