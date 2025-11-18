// FILO Quick Action Button Widget
// Refs: ui_blueprint_ultra_ultra.md (Component patterns)

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Quick action button for home screen
/// Circular icon button with label below
class QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 48dp diameter circular button
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primary700,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(icon, size: 24),
            color: AppColors.accentTeal500,
            onPressed: onPressed,
            splashRadius: 24,
          ),
        ),
        const SizedBox(height: 8),
        // Label below icon
        Text(label, style: AppTypography.caption, textAlign: TextAlign.center),
      ],
    );
  }
}
