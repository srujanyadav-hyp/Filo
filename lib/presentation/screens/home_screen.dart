// FILO Home Screen
// Refs: screens/home_shelf_ultra.md (full file), ui_blueprint_ultra_ultra.md lines 50-80

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/file_card_widget.dart';
import '../widgets/quick_action_button.dart';
import 'file_detail_screen.dart';
import 'settings_screen.dart';
import 'activity_log_screen.dart';
import 'search_results_screen.dart';
import '../../core/providers/database_provider.dart';
import '../../data/db/database.dart';

/// Home/Shelf screen matching screens/home_shelf_ultra.md specifications
/// Components: Search bar, Quick actions row, Recent list, Folder categories grid
/// Spacing: between cards 12dp, between sections 24dp
///
/// Phase 5 Task 3: Integrated with FilesDao to load real file data
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<FileIndexEntry>? _recentFiles;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecentFiles();
  }

  Future<void> _loadRecentFiles() async {
    try {
      final database = ref.read(databaseProvider);
      final files = await database.filesDao.getRecentFiles(limit: 10);
      setState(() {
        _recentFiles = files;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _recentFiles = [];
        _isLoading = false;
      });
    }
  }

  String _formatFileSubtitle(FileIndexEntry file) {
    // Format time ago
    final diff = DateTime.now().difference(file.modifiedAt);
    String timeAgo;
    if (diff.inMinutes < 60) {
      timeAgo = '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      timeAgo = '${diff.inHours}h ago';
    } else if (diff.inDays < 7) {
      timeAgo = '${diff.inDays}d ago';
    } else {
      timeAgo =
          '${file.modifiedAt.day}/${file.modifiedAt.month}/${file.modifiedAt.year}';
    }

    // Format file size
    String size;
    if (file.size < 1024) {
      size = '${file.size} B';
    } else if (file.size < 1024 * 1024) {
      size = '${(file.size / 1024).toStringAsFixed(1)} KB';
    } else if (file.size < 1024 * 1024 * 1024) {
      size = '${(file.size / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      size = '${(file.size / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    }

    return '$timeAgo • $size';
  }

  IconData _getFileIcon(String fileName) {
    final ext = fileName.split('.').last.toLowerCase();
    if (ext == 'pdf') return Icons.picture_as_pdf;
    if (['png', 'jpg', 'jpeg', 'gif', 'bmp', 'webp'].contains(ext)) {
      return Icons.image;
    }
    if (['txt', 'md', 'doc', 'docx'].contains(ext)) return Icons.description;
    if (['zip', 'rar', '7z', 'tar', 'gz'].contains(ext)) {
      return Icons.folder_zip;
    }
    if (['mp4', 'avi', 'mkv', 'mov', 'wmv'].contains(ext)) {
      return Icons.video_file;
    }
    if (['mp3', 'wav', 'flac', 'aac', 'ogg'].contains(ext)) {
      return Icons.audio_file;
    }
    return Icons.insert_drive_file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('FILO'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Search bar section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.paddingMedium), // 16dp
                child: SearchBarWidget(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchResultsScreen(),
                      ),
                    );
                  },
                  readOnly: true, // Tap navigates to search screen
                ),
              ),
            ),

            // 24dp spacing between sections per spec
            SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.spaceBetweenSections),
            ),

            // Quick actions row
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.paddingMedium,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Quick Actions', style: AppTypography.headingS),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        QuickActionButton(
                          icon: Icons.add,
                          label: 'Add Files',
                          onPressed: () async {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'File picker integration pending',
                                ),
                              ),
                            );
                          },
                        ),
                        QuickActionButton(
                          icon: Icons.rule,
                          label: 'Rules',
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Rule builder requires database setup',
                                ),
                              ),
                            );
                          },
                        ),
                        QuickActionButton(
                          icon: Icons.folder_outlined,
                          label: 'Browse',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SearchResultsScreen(),
                              ),
                            );
                          },
                        ),
                        QuickActionButton(
                          icon: Icons.history,
                          label: 'Activity',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ActivityLogScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // 24dp spacing between sections
            SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.spaceBetweenSections),
            ),

            // Recent files section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.paddingMedium,
                ),
                child: Text('Recent Files', style: AppTypography.headingS),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.paddingMedium),
            ),

            // Recent files list with 12dp spacing between cards
            // Phase 5 Task 3: Now loading real data from FilesDao
            _isLoading
                ? SliverToBoxAdapter(
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                : _recentFiles == null || _recentFiles!.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(AppSpacing.xxxl),
                        child: Column(
                          children: [
                            Icon(
                              Icons.folder_open,
                              size: 64,
                              color: AppColors.textSecondary,
                            ),
                            SizedBox(height: AppSpacing.paddingMedium),
                            Text(
                              'No files indexed yet',
                              style: AppTypography.bodyM.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.paddingMedium,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        if (index >= _recentFiles!.length) return null;

                        final file = _recentFiles![index];

                        return Padding(
                          padding: EdgeInsets.only(
                            bottom:
                                AppSpacing.spaceBetweenCards, // 12dp per spec
                          ),
                          child: FileCardWidget(
                            fileName: file.normalizedName,
                            subtitle: _formatFileSubtitle(file),
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
                                        [], // TODO: Load from FileMetadataDao in future
                                  ),
                                ),
                              );
                            },
                            onMorePressed: () {
                              _showFileOptionsMenu(context, {
                                'name': file.normalizedName,
                                'uri': file.uri,
                              });
                            },
                          ),
                        );
                      }, childCount: _recentFiles!.length),
                    ),
                  ),

            // 24dp spacing before folder categories
            SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.spaceBetweenSections),
            ),

            // Folder categories section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.paddingMedium,
                ),
                child: Text('Folder Categories', style: AppTypography.headingS),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.paddingMedium),
            ),

            // Folder categories grid (2 columns per spec)
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.paddingMedium,
              ),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final mockFolders = [
                      {'name': 'Documents', 'count': '24 files'},
                      {'name': 'Images', 'count': '156 files'},
                      {'name': 'Downloads', 'count': '8 files'},
                      {'name': 'Work', 'count': '32 files'},
                    ];

                    if (index >= mockFolders.length) return null;

                    final folder = mockFolders[index];

                    return Card(
                      child: InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Opening ${folder['name']}...'),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: EdgeInsets.all(AppSpacing.paddingMedium),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_outlined,
                                size: 48,
                                color: AppColors.accentTeal500,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                folder['name'] as String,
                                style: AppTypography.bodyM.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                folder['count'] as String,
                                style: AppTypography.bodySM.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: 4, // Mock count
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns per spec
                  mainAxisSpacing: 12, // 12dp spacing between cards
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.2,
                ),
              ),
            ),

            // Bottom padding
            SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxxl)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('File picker integration pending')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showFileOptionsMenu(BuildContext context, Map<String, Object> file) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(AppSpacing.paddingMedium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Share functionality pending')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.rule),
              title: const Text('Apply Rule'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Rule application pending')),
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
