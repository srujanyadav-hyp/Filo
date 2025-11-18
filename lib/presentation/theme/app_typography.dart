// FILO App Typography
// Refs: design_tokens_ultra_ultra.md section 2 (Typography Spec)

import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Complete typography system for FILO app matching design_tokens_ultra_ultra.md
class AppTypography {
  AppTypography._(); // Private constructor to prevent instantiation

  // HEADINGS (design_tokens_ultra_ultra.md section 2 - Headings)

  /// H1: 28sp / line-height 34sp / weight 700
  static const TextStyle headingXL = TextStyle(
    fontSize: 28,
    height: 34 / 28, // line-height as ratio
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  /// H2: 22sp / line-height 28sp / weight 600
  static const TextStyle headingL = TextStyle(
    fontSize: 22,
    height: 28 / 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  /// H3: 18sp / line-height 24sp / weight 600
  static const TextStyle headingM = TextStyle(
    fontSize: 18,
    height: 24 / 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  /// H4: 16sp / line-height 22sp / weight 500
  static const TextStyle headingS = TextStyle(
    fontSize: 16,
    height: 22 / 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  // BODY TEXT (design_tokens_ultra_ultra.md section 2 - Body)

  /// Body Large: 16sp / line-height 24sp / weight 400
  static const TextStyle bodyL = TextStyle(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  /// Body: 14sp / line-height 20sp / weight 400
  static const TextStyle bodyM = TextStyle(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  /// Body Small: 13sp / line-height 18sp / weight 400
  static const TextStyle bodySM = TextStyle(
    fontSize: 13,
    height: 18 / 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  // CAPTION (design_tokens_ultra_ultra.md section 2 - Caption)

  /// Caption: 12sp / line-height 16sp / weight 400 / letter spacing +0.3
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.3,
    color: AppColors.textSecondary,
  );

  // HELPER METHODS FOR COLOR VARIANTS

  /// Apply secondary color to any text style
  static TextStyle secondary(TextStyle style) {
    return style.copyWith(color: AppColors.textSecondary);
  }

  /// Apply disabled color to any text style
  static TextStyle disabled(TextStyle style) {
    return style.copyWith(color: AppColors.textDisabled);
  }

  /// Apply accent teal color to any text style
  static TextStyle accent(TextStyle style) {
    return style.copyWith(color: AppColors.accentTeal500);
  }

  /// Convert to Flutter TextTheme for MaterialApp
  static TextTheme get textTheme => const TextTheme(
    displayLarge: headingXL,
    displayMedium: headingL,
    displaySmall: headingM,
    headlineMedium: headingM,
    headlineSmall: headingS,
    titleLarge: headingS,
    titleMedium: bodyL,
    titleSmall: bodyM,
    bodyLarge: bodyL,
    bodyMedium: bodyM,
    bodySmall: bodySM,
    labelLarge: bodyM,
    labelMedium: bodySM,
    labelSmall: caption,
  );
}
