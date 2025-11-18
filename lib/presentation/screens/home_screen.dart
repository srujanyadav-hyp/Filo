// FILO Home Screen
// Refs: screens/home_shelf_ultra.md (full file), ui_blueprint_ultra_ultra.md lines 50-80

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/file_card_widget.dart';
import '../widgets/quick_action_button.dart';
import 'file_detail_screen.dart';

/// Home/Shelf screen matching screens/home_shelf_ultra.md specifications
/// Components: Search bar, Quick actions row, Recent list, Folder categories grid
/// Spacing: between cards 12dp, between sections 24dp
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              // TODO: Navigate to settings
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
                    // TODO: Navigate to search results screen
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
                          onPressed: () {
                            // TODO: Add files action
                          },
                        ),
                        QuickActionButton(
                          icon: Icons.rule,
                          label: 'Rules',
                          onPressed: () {
                            // TODO: Navigate to rules
                          },
                        ),
                        QuickActionButton(
                          icon: Icons.folder_outlined,
                          label: 'Browse',
                          onPressed: () {
                            // TODO: Browse files
                          },
                        ),
                        QuickActionButton(
                          icon: Icons.history,
                          label: 'Activity',
                          onPressed: () {
                            // TODO: Navigate to activity log
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
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.paddingMedium,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    // Mock data - will be replaced with provider data
                    final mockFiles = [
                      {
                        'name': 'Project Proposal.pdf',
                        'subtitle': '2 hours ago • 1.2 MB',
                        'icon': Icons.picture_as_pdf,
                      },
                      {
                        'name': 'Meeting Notes.txt',
                        'subtitle': 'Yesterday • 45 KB',
                        'icon': Icons.description,
                      },
                      {
                        'name': 'Screenshot_20251118.png',
                        'subtitle': '3 days ago • 856 KB',
                        'icon': Icons.image,
                      },
                    ];

                    if (index >= mockFiles.length) return null;

                    final file = mockFiles[index];

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: AppSpacing.spaceBetweenCards, // 12dp per spec
                      ),
                      child: FileCardWidget(
                        fileName: file['name'] as String,
                        subtitle: file['subtitle'] as String,
                        fileIcon: file['icon'] as IconData,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FileDetailScreen(
                                fileName: file['name'] as String,
                                filePath:
                                    '/storage/emulated/0/Documents/${file['name']}',
                                fileType: (file['name'] as String)
                                    .split('.')
                                    .last,
                                fileSize: file['name'] == 'Project Proposal.pdf'
                                    ? 1258291
                                    : 45056,
                                dateModified: DateTime.now().subtract(
                                  const Duration(hours: 2),
                                ),
                                dateCreated: DateTime.now().subtract(
                                  const Duration(days: 7),
                                ),
                                tags: file['name'] == 'Project Proposal.pdf'
                                    ? ['Work', 'Important']
                                    : [],
                              ),
                            ),
                          );
                        },
                        onMorePressed: () {
                          // TODO: Show file options menu
                        },
                      ),
                    );
                  },
                  childCount: 3, // Mock count
                ),
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
                          // TODO: Navigate to folder view
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
        onPressed: () {
          // TODO: Add quick action (file picker)
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
