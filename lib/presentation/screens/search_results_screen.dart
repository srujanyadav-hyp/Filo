// FILO Search Results Screen
// Refs: screens/search_results_ultra.md, search_architecture_ultra.md

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/db/database.dart';
import '../../core/providers/database_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/file_card_widget.dart';
import 'file_detail_screen.dart';

/// Search Results Screen matching screens/search_results_ultra.md
/// Shows: FTS results, Semantic results, Score badge
class SearchResultsScreen extends ConsumerStatefulWidget {
  final String? initialQuery;

  const SearchResultsScreen({super.key, this.initialQuery});

  @override
  ConsumerState<SearchResultsScreen> createState() =>
      _SearchResultsScreenState();
}

class _SearchResultsScreenState extends ConsumerState<SearchResultsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<FileIndexEntry>? _searchResults;
  bool _isSearching = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    if (widget.initialQuery != null && widget.initialQuery!.isNotEmpty) {
      _searchController.text = widget.initialQuery!;
      _performSearch(widget.initialQuery!);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = null;
        _searchQuery = '';
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _searchQuery = query;
    });

    try {
      final database = ref.read(databaseProvider);

      // Perform combined search (FTS + OCR + Image labels)
      final fileIds = await database.searchDao.combinedSearch(query);

      // Fetch file details for matching IDs
      if (fileIds.isEmpty) {
        setState(() {
          _searchResults = [];
          _isSearching = false;
        });
        return;
      }

      final files = await database.filesDao.getFilesByIds(fileIds.toList());

      // Log search activity
      await database.activityLogDao.logActivity(
        activityType: 'search_performed',
        description: 'Searched for: "$query"',
        metadataJson: '{"results_count": ${files.length}}',
      );

      setState(() {
        _searchResults = files;
        _isSearching = false;
      });
    } catch (e) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Search error: ${e.toString()}'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Search'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.paddingMedium),
            child: TextField(
              controller: _searchController,
              autofocus: widget.initialQuery == null,
              style: AppTypography.bodyM,
              decoration: InputDecoration(
                hintText: 'Search files...',
                hintStyle: AppTypography.bodyM.copyWith(
                  color: AppColors.textSecondary,
                ),
                prefixIcon: Icon(Icons.search, color: AppColors.accentTeal500),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchResults = null;
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.paddingMedium,
                  vertical: AppSpacing.paddingSmall,
                ),
              ),
              onSubmitted: _performSearch,
              onChanged: (value) {
                setState(() {}); // Update to show/hide clear button
              },
            ),
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isSearching) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_searchResults == null) {
      return _buildEmptyState(
        icon: Icons.search,
        title: 'Start searching',
        message: 'Enter keywords to find files by name, content, or tags',
      );
    }

    if (_searchResults!.isEmpty) {
      return _buildEmptyState(
        icon: Icons.search_off,
        title: 'No results found',
        message: 'Try different keywords or check your spelling',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Results header
        Padding(
          padding: EdgeInsets.all(AppSpacing.paddingMedium),
          child: Row(
            children: [
              Text(
                '${_searchResults!.length} result${_searchResults!.length == 1 ? '' : 's'}',
                style: AppTypography.bodyM.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              Chip(
                label: Text(
                  'FTS',
                  style: AppTypography.bodySM.copyWith(
                    color: AppColors.accentTeal500,
                  ),
                ),
                backgroundColor: AppColors.primary700,
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ),

        // Results list
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.paddingMedium),
            itemCount: _searchResults!.length,
            separatorBuilder: (context, index) =>
                SizedBox(height: AppSpacing.spaceBetweenCards),
            itemBuilder: (context, index) {
              final file = _searchResults![index];
              return _buildSearchResultCard(file);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResultCard(FileIndexEntry file) {
    return FileCardWidget(
      fileName: file.normalizedName,
      subtitle: _buildSubtitle(file),
      fileIcon: _getFileIcon(file.normalizedName),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FileDetailScreen(
              fileName: file.normalizedName,
              filePath: file.uri,
              fileType: file.mime.split('/').last,
              fileSize: file.size,
              dateModified: file.modifiedAt,
              dateCreated: file.createdAt,
              tags:
                  [], // Tags will be loaded from metadata when FileMetadataDao is integrated
            ),
          ),
        );
      },
      onMorePressed: () {
        _showFileOptions(file);
      },
    );
  }

  String _buildSubtitle(FileIndexEntry file) {
    final parts = <String>[];

    // Add relative time
    final diff = DateTime.now().difference(file.modifiedAt);
    if (diff.inDays == 0) {
      if (diff.inHours == 0) {
        parts.add('${diff.inMinutes}m ago');
      } else {
        parts.add('${diff.inHours}h ago');
      }
    } else if (diff.inDays < 7) {
      parts.add('${diff.inDays}d ago');
    } else {
      parts.add(
        '${file.modifiedAt.day}/${file.modifiedAt.month}/${file.modifiedAt.year}',
      );
    }

    // Add file size
    parts.add(_formatFileSize(file.size));

    return parts.join(' • ');
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  IconData _getFileIcon(String fileName) {
    final ext = fileName.split('.').last.toLowerCase();
    if (ext == 'pdf') return Icons.picture_as_pdf;
    if (ext == 'png' || ext == 'jpg' || ext == 'jpeg') return Icons.image;
    if (ext == 'txt' || ext == 'md') return Icons.description;
    if (ext == 'zip' || ext == 'rar') return Icons.folder_zip;
    return Icons.insert_drive_file;
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String message,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: AppColors.textSecondary),
          SizedBox(height: AppSpacing.paddingMedium),
          Text(title, style: AppTypography.headingS),
          SizedBox(height: AppSpacing.paddingSmall),
          Text(
            message,
            style: AppTypography.bodyM.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showFileOptions(FileIndexEntry file) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.open_in_new),
              title: const Text('Open'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Opening ${file.normalizedName}...')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Share: ${file.normalizedName}')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.rule),
              title: const Text('Apply Rules'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Applying rules...')),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: AppColors.error),
              title: Text('Delete', style: TextStyle(color: AppColors.error)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Delete: ${file.normalizedName}'),
                    backgroundColor: AppColors.error,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
