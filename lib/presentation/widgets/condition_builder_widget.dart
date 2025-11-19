// FILO Condition Builder Widget
// Allows drag-drop style condition configuration

import 'package:flutter/material.dart';
import '../../data/models/condition_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Condition Builder Widget
///
/// Displays and edits a single condition with:
/// - Field selector (file_name, mime_type, size, etc.)
/// - Operator selector (equals, contains, greater_than, etc.)
/// - Value input
/// - Delete button
class ConditionBuilderWidget extends StatelessWidget {
  final ConditionModel condition;
  final ValueChanged<ConditionModel> onUpdate;
  final VoidCallback onDelete;

  const ConditionBuilderWidget({
    super.key,
    required this.condition,
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
                // Field selector
                Expanded(flex: 2, child: _buildFieldSelector()),
                const SizedBox(width: 12),

                // Operator selector
                Expanded(flex: 2, child: _buildOperatorSelector()),
                const SizedBox(width: 12),

                // Value input
                Expanded(flex: 3, child: _buildValueInput()),

                // Delete button
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: onDelete,
                  tooltip: 'Remove condition',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldSelector() {
    return DropdownButtonFormField<String>(
      value: condition.type,
      decoration: InputDecoration(
        labelText: 'Field',
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items: const [
        DropdownMenuItem(value: 'file_name', child: Text('File Name')),
        DropdownMenuItem(value: 'mime_type', child: Text('File Type')),
        DropdownMenuItem(value: 'size', child: Text('File Size')),
        DropdownMenuItem(value: 'extension', child: Text('Extension')),
        DropdownMenuItem(value: 'folder_path', child: Text('Folder')),
        DropdownMenuItem(value: 'modified_at', child: Text('Modified Date')),
        DropdownMenuItem(value: 'tags', child: Text('Tags')),
      ],
      onChanged: (value) {
        if (value != null) {
          onUpdate(
            ConditionModel(
              type: value,
              operator: _getDefaultOperator(value),
              value: condition.value,
            ),
          );
        }
      },
    );
  }

  Widget _buildOperatorSelector() {
    final availableOperators = ConditionOperators.getValidOperators(
      _getFieldType(condition.type),
    );

    return DropdownButtonFormField<String>(
      value: availableOperators.contains(condition.operator)
          ? condition.operator
          : availableOperators.first,
      decoration: InputDecoration(
        labelText: 'Operator',
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items: availableOperators.map((op) {
        return DropdownMenuItem(value: op, child: Text(_operatorLabel(op)));
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          onUpdate(
            ConditionModel(
              type: condition.type,
              operator: value,
              value: condition.value,
            ),
          );
        }
      },
    );
  }

  Widget _buildValueInput() {
    // Different input types based on field type
    final fieldType = _getFieldType(condition.type);

    if (fieldType == 'numeric') {
      return TextField(
        decoration: InputDecoration(
          labelText: 'Value',
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: AppColors.surface,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          suffixText: _getUnitSuffix(condition.type),
        ),
        keyboardType: TextInputType.number,
        controller: TextEditingController(text: condition.value),
        onChanged: (value) {
          onUpdate(
            ConditionModel(
              type: condition.type,
              operator: condition.operator,
              value: value,
            ),
          );
        },
      );
    } else if (fieldType == 'date') {
      return TextField(
        decoration: InputDecoration(
          labelText: 'Value',
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: AppColors.surface,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          hintText: 'YYYY-MM-DD',
        ),
        controller: TextEditingController(text: condition.value),
        onChanged: (value) {
          onUpdate(
            ConditionModel(
              type: condition.type,
              operator: condition.operator,
              value: value,
            ),
          );
        },
      );
    } else {
      // String input
      return TextField(
        decoration: InputDecoration(
          labelText: 'Value',
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: AppColors.surface,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
        ),
        controller: TextEditingController(text: condition.value),
        onChanged: (value) {
          onUpdate(
            ConditionModel(
              type: condition.type,
              operator: condition.operator,
              value: value,
            ),
          );
        },
      );
    }
  }

  String _getFieldType(String field) {
    switch (field) {
      case 'size':
        return 'numeric';
      case 'modified_at':
      case 'created_at':
        return 'date';
      case 'tags':
        return 'array';
      default:
        return 'string';
    }
  }

  String _getDefaultOperator(String field) {
    final fieldType = _getFieldType(field);
    switch (fieldType) {
      case 'numeric':
        return 'greater_than';
      case 'date':
        return 'after';
      case 'array':
        return 'includes';
      default:
        return 'contains';
    }
  }

  String? _getUnitSuffix(String field) {
    switch (field) {
      case 'size':
        return 'bytes';
      default:
        return null;
    }
  }

  String _operatorLabel(String operator) {
    switch (operator) {
      case 'equals':
        return 'Equals';
      case 'not_equals':
        return 'Not Equals';
      case 'contains':
        return 'Contains';
      case 'not_contains':
        return 'Does Not Contain';
      case 'starts_with':
        return 'Starts With';
      case 'ends_with':
        return 'Ends With';
      case 'regex':
        return 'Matches Regex';
      case 'greater_than':
        return 'Greater Than';
      case 'less_than':
        return 'Less Than';
      case 'between':
        return 'Between';
      case 'before':
        return 'Before';
      case 'after':
        return 'After';
      case 'date_range':
        return 'Date Range';
      case 'includes':
        return 'Includes';
      case 'excludes':
        return 'Excludes';
      case 'includes_any':
        return 'Includes Any';
      case 'includes_all':
        return 'Includes All';
      default:
        return operator;
    }
  }
}


