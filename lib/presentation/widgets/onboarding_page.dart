// FILO Onboarding Page Widget
// Per Phase 5 Task 2: Individual onboarding page

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Individual page in onboarding flow
///
/// Displays illustration, title, subtitle, and optional content.
class OnboardingPage extends StatelessWidget {
  final Widget illustration;
  final String title;
  final String subtitle;
  final Widget? content;

  const OnboardingPage({
    super.key,
    required this.illustration,
    required this.title,
    required this.subtitle,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.paddingLarge),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration (224dp per spec)
          SizedBox(width: 224, height: 224, child: illustration),

          SizedBox(height: AppSpacing.xxxl),

          // Title (24sp bold per spec)
          Text(
            title,
            style: AppTypography.headingL.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: AppSpacing.paddingMedium),

          // Subtitle (16sp regular per spec)
          Text(
            subtitle,
            style: AppTypography.bodyL.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),

          // Optional content (e.g., feature cards)
          if (content != null) ...[SizedBox(height: AppSpacing.xxxl), content!],
        ],
      ),
    );
  }
}
