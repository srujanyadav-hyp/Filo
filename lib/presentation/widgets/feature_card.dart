// FILO Feature Card Widget
// Per Phase 5 Task 2: Onboarding feature highlights

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Feature highlight card for onboarding
///
/// Displays icon, title, and description for a FILO feature.
class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color? iconColor;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Feature icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: (iconColor ?? AppColors.accentTeal500).withAlpha(25),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              size: 32,
              color: iconColor ?? AppColors.accentTeal500,
            ),
          ),

          SizedBox(height: AppSpacing.paddingMedium),

          // Feature title
          Text(
            title,
            style: AppTypography.headingS,
            textAlign: TextAlign.center,
          ),

          SizedBox(height: AppSpacing.paddingSmall),

          // Feature description
          Text(
            description,
            style: AppTypography.bodyM.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
