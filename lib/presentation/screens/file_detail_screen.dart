// FILO File Detail Screen
// Refs: screens/file_detail_ultra.md

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../theme/app_elevation.dart';

/// File Detail Screen matching screens/file_detail_ultra.md specifications
/// Layout: Preview (56% height), Metadata table, Action bar
class FileDetailScreen extends StatelessWidget {
  final String fileName;
  final String filePath;
  final String fileType;
  final int fileSize;
  final DateTime dateModified;
  final DateTime dateCreated;
  final List<String> tags;

  const FileDetailScreen({
    super.key,
    required this.fileName,
    required this.filePath,
    required this.fileType,
    required this.fileSize,
    required this.dateModified,
    required this.dateCreated,
    this.tags = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(fileName, maxLines: 1, overflow: TextOverflow.ellipsis),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Share: $fileName')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              _showOptionsMenu(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Preview area - 56% of screen height per spec
          Expanded(
            flex: 56,
            child: Container(
              width: double.infinity,
              color: AppColors.surface,
              child: _buildPreview(),
            ),
          ),

          // Metadata and actions - remaining 44%
          Expanded(
            flex: 44,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Metadata table
                  _buildMetadataTable(),

                  SizedBox(height: AppSpacing.spaceBetweenSections),

                  // Tags section
                  if (tags.isNotEmpty) _buildTagsSection(),
                ],
              ),
            ),
          ),
        ],
      ),
      // Action bar at bottom
      bottomNavigationBar: _buildActionBar(context),
    );
  }

  Widget _buildPreview() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(_getFileIcon(), size: 120, color: AppColors.accentTeal500),
          SizedBox(height: AppSpacing.paddingLarge),
          Text(
            fileType.toUpperCase(),
            style: AppTypography.bodySM.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetadataTable() {
    return Container(
      margin: EdgeInsets.all(AppSpacing.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [AppElevation.shadowLow],
      ),
      child: Column(
        children: [
          _buildMetadataRow('File Name', fileName),
          _buildDivider(),
          _buildMetadataRow('Type', fileType),
          _buildDivider(),
          _buildMetadataRow('Size', _formatFileSize(fileSize)),
          _buildDivider(),
          _buildMetadataRow('Modified', _formatDate(dateModified)),
          _buildDivider(),
          _buildMetadataRow('Created', _formatDate(dateCreated)),
          _buildDivider(),
          _buildMetadataRow('Location', filePath, isPath: true),
        ],
      ),
    );
  }

  Widget _buildMetadataRow(String label, String value, {bool isPath = false}) {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.paddingMedium),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppTypography.bodySM.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          SizedBox(width: AppSpacing.paddingMedium),
          Expanded(
            child: Text(
              value,
              style: AppTypography.bodyM.copyWith(fontWeight: FontWeight.w500),
              maxLines: isPath ? 2 : 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: AppColors.textSecondary.withOpacity(0.2),
      indent: AppSpacing.paddingMedium,
      endIndent: AppSpacing.paddingMedium,
    );
  }

  Widget _buildTagsSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSpacing.paddingMedium),
      padding: EdgeInsets.all(AppSpacing.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [AppElevation.shadowLow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tags',
            style: AppTypography.bodySM.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: AppSpacing.paddingSmall),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags.map((tag) {
              return Chip(
                label: Text(tag),
                backgroundColor: AppColors.primary700,
                labelStyle: AppTypography.bodySM.copyWith(
                  color: AppColors.accentTeal500,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [AppElevation.shadowMedium],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Opening $fileName...')),
                  );
                },
                icon: const Icon(Icons.open_in_new),
                label: const Text('Open'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.accentTeal500,
                  side: BorderSide(color: AppColors.accentTeal500),
                  padding: EdgeInsets.symmetric(
                    vertical: AppSpacing.paddingMedium,
                  ),
                ),
              ),
            ),
            SizedBox(width: AppSpacing.paddingMedium),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Applying rules...')),
                  );
                },
                icon: const Icon(Icons.rule),
                label: const Text('Apply Rules'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentTeal500,
                  foregroundColor: AppColors.primary900,
                  padding: EdgeInsets.symmetric(
                    vertical: AppSpacing.paddingMedium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getFileIcon() {
    final ext = fileType.toLowerCase();
    if (ext == 'pdf') return Icons.picture_as_pdf;
    if (ext == 'png' || ext == 'jpg' || ext == 'jpeg') return Icons.image;
    if (ext == 'txt' || ext == 'md') return Icons.description;
    if (ext == 'zip' || ext == 'rar') return Icons.folder_zip;
    return Icons.insert_drive_file;
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      if (diff.inHours == 0) {
        return '${diff.inMinutes} minutes ago';
      }
      return '${diff.inHours} hours ago';
    }
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays} days ago';

    return '${date.day}/${date.month}/${date.year}';
  }

  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(AppSpacing.paddingMedium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Rename'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Rename functionality pending')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.drive_file_move),
              title: const Text('Move'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Move functionality pending')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Delete functionality pending')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
