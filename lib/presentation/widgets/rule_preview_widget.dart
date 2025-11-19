// FILO Rule Preview Widget
// Shows rule preview and test results

import 'package:flutter/material.dart';
import '../../data/models/rule_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Rule Preview Widget
///
/// Displays:
/// - Rule configuration summary
/// - Matching files from preview test
/// - Expected actions
class RulePreviewWidget extends StatelessWidget {
  final RuleModel rule;
  final List<String> previewResults;

  const RulePreviewWidget({
    super.key,
    required this.rule,
    required this.previewResults,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rule summary
          _buildRuleSummary(),
          const SizedBox(height: 24),

          // Preview results
          _buildPreviewResults(),
        ],
      ),
    );
  }

  Widget _buildRuleSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rule Summary',
          style: AppTypography.bodyM.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        // Trigger
        _buildSummaryItem(
          'Trigger',
          rule.trigger.type.replaceAll('_', ' ').toUpperCase(),
          Icons.play_circle_outline,
        ),

        // Conditions count
        _buildSummaryItem(
          'Conditions',
          '${(rule.conditions.isNotEmpty ? rule.conditions.first.conditions.length : 0)} condition(s)',
          Icons.filter_list,
        ),

        // Actions count
        _buildSummaryItem(
          'Actions',
          '${rule.actions.length} action(s)',
          Icons.bolt_outlined,
        ),

        // Safety class
        _buildSummaryItem(
          'Safety',
          rule.metadata.safetyClass.toUpperCase(),
          _getSafetyIcon(rule.metadata.safetyClass),
          color: _getSafetyColor(rule.metadata.safetyClass),
        ),
      ],
    );
  }

  Widget _buildSummaryItem(
    String label,
    String value,
    IconData icon, {
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color ?? AppColors.textSecondary),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.bodySM.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  value,
                  style: AppTypography.bodyM.copyWith(color: color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Matching Files',
          style: AppTypography.bodyM.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        if (previewResults.isEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: const Center(child: Text('Run test to see matching files')),
          )
        else
          ...previewResults.take(10).map((fileName) {
            return ListTile(
              dense: true,
              leading: const Icon(Icons.insert_drive_file, size: 16),
              title: Text(
                fileName,
                style: AppTypography.bodySM,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              tileColor: AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide(color: AppColors.border),
              ),
            );
          }),

        if (previewResults.length > 10)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              '+ ${previewResults.length - 10} more files',
              style: AppTypography.bodySM.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
      ],
    );
  }

  Color _getSafetyColor(String safetyClass) {
    switch (safetyClass) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
      default:
        return Colors.green;
    }
  }

  IconData _getSafetyIcon(String safetyClass) {
    switch (safetyClass) {
      case 'high':
        return Icons.warning;
      case 'medium':
        return Icons.info_outline;
      case 'low':
      default:
        return Icons.check_circle_outline;
    }
  }
}

