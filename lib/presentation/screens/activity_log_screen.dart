// FILO Activity Log Screen
// Refs: screens/activity_log_ultra.md

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/db/database.dart';
import '../../core/providers/database_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Activity Log Screen matching screens/activity_log_ultra.md specifications
/// Shows: Timestamp, Applied rule, Result, Undo option
class ActivityLogScreen extends ConsumerStatefulWidget {
  const ActivityLogScreen({super.key});

  @override
  ConsumerState<ActivityLogScreen> createState() => _ActivityLogScreenState();
}

class _ActivityLogScreenState extends ConsumerState<ActivityLogScreen> {
  String? _selectedFilter;
  final List<String> _filters = [
    'All',
    'file_indexed',
    'rule_executed',
    'search_performed',
  ];

  @override
  Widget build(BuildContext context) {
    final database = ref.watch(databaseProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Activity Log'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            tooltip: 'Filter',
            onSelected: (value) {
              setState(() {
                _selectedFilter = value == 'All' ? null : value;
              });
            },
            itemBuilder: (context) => _filters.map((filter) {
              return PopupMenuItem(
                value: filter,
                child: Row(
                  children: [
                    if (_selectedFilter == filter ||
                        (filter == 'All' && _selectedFilter == null))
                      Icon(
                        Icons.check,
                        size: 20,
                        color: AppColors.accentTeal500,
                      ),
                    if (_selectedFilter != filter &&
                        !(filter == 'All' && _selectedFilter == null))
                      const SizedBox(width: 20),
                    SizedBox(width: AppSpacing.paddingSmall),
                    Text(_formatFilterName(filter)),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
      body: FutureBuilder<List<ActivityLogEntry>>(
        future: _selectedFilter == null
            ? database.activityLogDao.getAllLogs()
            : database.activityLogDao.getLogsByType(_selectedFilter!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: AppColors.error),
                  SizedBox(height: AppSpacing.paddingMedium),
                  Text(
                    'Error loading activity log',
                    style: AppTypography.bodyM,
                  ),
                  SizedBox(height: AppSpacing.paddingSmall),
                  Text(
                    snapshot.error.toString(),
                    style: AppTypography.bodySM.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          final logs = snapshot.data ?? [];

          if (logs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 64, color: AppColors.textSecondary),
                  SizedBox(height: AppSpacing.paddingMedium),
                  Text(
                    _selectedFilter == null
                        ? 'No activity yet'
                        : 'No ${_formatFilterName(_selectedFilter!).toLowerCase()} activities',
                    style: AppTypography.bodyM.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.all(AppSpacing.paddingMedium),
            itemCount: logs.length,
            separatorBuilder: (context, index) =>
                SizedBox(height: AppSpacing.spaceBetweenCards),
            itemBuilder: (context, index) {
              final log = logs[index];
              return _buildActivityCard(log);
            },
          );
        },
      ),
    );
  }

  Widget _buildActivityCard(ActivityLogEntry log) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row with icon and timestamp
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getActivityColor(log.activityType).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getActivityIcon(log.activityType),
                    color: _getActivityColor(log.activityType),
                    size: 20,
                  ),
                ),
                SizedBox(width: AppSpacing.paddingMedium),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatActivityType(log.activityType),
                        style: AppTypography.bodyM.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _formatTimestamp(log.timestamp),
                        style: AppTypography.bodySM.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Undo button if applicable
                if (_canUndo(log.activityType))
                  TextButton.icon(
                    onPressed: () {
                      _showUndoDialog(log);
                    },
                    icon: const Icon(Icons.undo, size: 16),
                    label: const Text('Undo'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.accentTeal500,
                    ),
                  ),
              ],
            ),

            SizedBox(height: AppSpacing.paddingSmall),

            // Description
            Text(log.description, style: AppTypography.bodyM),

            // Metadata (if available)
            if (log.metadataJson != null && log.metadataJson!.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: AppSpacing.paddingSmall),
                child: Container(
                  padding: EdgeInsets.all(AppSpacing.paddingSmall),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceElevated,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    log.metadataJson!,
                    style: AppTypography.bodySM.copyWith(
                      color: AppColors.textSecondary,
                      fontFamily: 'monospace',
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getActivityIcon(String activityType) {
    switch (activityType) {
      case 'file_indexed':
        return Icons.add_circle_outline;
      case 'rule_executed':
        return Icons.rule;
      case 'search_performed':
        return Icons.search;
      default:
        return Icons.info_outline;
    }
  }

  Color _getActivityColor(String activityType) {
    switch (activityType) {
      case 'file_indexed':
        return AppColors.success;
      case 'rule_executed':
        return AppColors.accentTeal500;
      case 'search_performed':
        return AppColors.info;
      default:
        return AppColors.textSecondary;
    }
  }

  String _formatActivityType(String activityType) {
    return activityType
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  String _formatFilterName(String filter) {
    if (filter == 'All') return filter;
    return _formatActivityType(filter);
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final diff = now.difference(timestamp);

    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';

    return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }

  bool _canUndo(String activityType) {
    // Only certain activity types support undo
    return activityType == 'rule_executed';
  }

  void _showUndoDialog(ActivityLogEntry log) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Undo Action'),
        content: Text(
          'Are you sure you want to undo this action?\n\n${log.description}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _performUndo(log);
            },
            child: const Text('Undo'),
          ),
        ],
      ),
    );
  }

  void _performUndo(ActivityLogEntry log) {
    // Implement undo logic based on activity type
    switch (log.activityType) {
      case 'file_moved':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Undoing: ${log.description}'),
            backgroundColor: AppColors.success,
          ),
        );
        // TODO: Actual file move undo requires FileIndexDao integration
        break;
      case 'file_renamed':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Undoing: ${log.description}'),
            backgroundColor: AppColors.success,
          ),
        );
        // TODO: Actual file rename undo requires FileIndexDao integration
        break;
      case 'file_deleted':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cannot undo: ${log.description}'),
            backgroundColor: AppColors.error,
          ),
        );
        break;
      case 'rule_executed':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Undoing: ${log.description}'),
            backgroundColor: AppColors.success,
          ),
        );
        // TODO: Rule execution undo requires RuleEngine integration
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Undo not supported for: ${log.activityType}'),
            backgroundColor: AppColors.warning,
          ),
        );
    }
  }
}
