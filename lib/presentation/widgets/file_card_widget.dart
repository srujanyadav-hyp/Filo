// FILO File Card Widget
// Refs: ui_blueprint_ultra_ultra.md lines 64-97 (File Card Ultra Expanded)

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../theme/app_elevation.dart';

/// File card widget matching ui_blueprint_ultra_ultra.md specifications
/// Layout: |IMG(72x72)| 12dp | VStack(title, meta) | 12dp | ⋮ (48dp hitbox)|
/// Press animation: scale 1 → 0.96 (120ms easeOut)
class FileCardWidget extends StatefulWidget {
  final String fileName;
  final String subtitle; // Modified date, size, or tags
  final IconData? fileIcon;
  final VoidCallback? onTap;
  final VoidCallback? onMorePressed;

  const FileCardWidget({
    super.key,
    required this.fileName,
    required this.subtitle,
    this.fileIcon,
    this.onTap,
    this.onMorePressed,
  });

  @override
  State<FileCardWidget> createState() => _FileCardWidgetState();
}

class _FileCardWidgetState extends State<FileCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    // ui_blueprint_ultra_ultra.md: Press animation 120ms easeOut
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 120),
      vsync: this,
    );

    // Scale: 1 → 0.96 per spec
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    // Shadow increase to mid elevation on press
    _elevationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _animationController.reverse();
    widget.onTap?.call();
  }

  void _handleTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  // Lerp between low and medium elevation
                  BoxShadow(
                    color: Colors.black.withOpacity(
                      0.10 + (_elevationAnimation.value * 0.04), // 0.10 → 0.14
                    ),
                    offset: Offset(
                      0,
                      2 + (_elevationAnimation.value * 4), // 2 → 6
                    ),
                    blurRadius: 4 + (_elevationAnimation.value * 8), // 4 → 12
                  ),
                ],
              ),
              padding: EdgeInsets.all(AppSpacing.xl), // 12dp padding
              child: Row(
                children: [
                  // Image/Icon placeholder 72x72dp
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.primary700,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      widget.fileIcon ?? Icons.insert_drive_file,
                      size: 36,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  SizedBox(width: AppSpacing.xl), // 12dp spacing per spec
                  // Title and metadata
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Title: max 1 line, ellipsis trailing, medium weight
                        Text(
                          widget.fileName,
                          style: AppTypography.bodyM.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        // Subtitle: max 2 lines, line height 16dp
                        Text(
                          widget.subtitle,
                          style: AppTypography.bodySM.copyWith(
                            height: 16 / 13, // 16dp line height
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: AppSpacing.xl), // 12dp spacing
                  // More button (48dp hitbox per spec)
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: widget.onMorePressed,
                      splashRadius: 24,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
