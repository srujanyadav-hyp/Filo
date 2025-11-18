// FILO App Theme
// Refs: design_tokens_ultra_ultra.md (full file), ui_blueprint_ultra_ultra.md lines 10-40

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_elevation.dart';

/// Complete theme configuration for FILO app
/// Combines all design tokens into MaterialApp-compatible ThemeData
class AppTheme {
  AppTheme._(); // Private constructor to prevent instantiation

  /// Dark theme for FILO (primary theme per design_tokens_ultra_ultra.md)
  static ThemeData get darkTheme => ThemeData(
    // BRIGHTNESS
    brightness: Brightness.dark,
    useMaterial3: true,

    // COLOR SCHEME
    colorScheme: ColorScheme.dark(
      // Primary colors
      primary: AppColors.accentTeal500,
      onPrimary: AppColors.textPrimary,
      primaryContainer: AppColors.primary700,
      onPrimaryContainer: AppColors.textPrimary,

      // Secondary colors
      secondary: AppColors.accentTeal300,
      onSecondary: AppColors.primary900,
      secondaryContainer: AppColors.primary600,
      onSecondaryContainer: AppColors.textPrimary,

      // Surface colors
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      surfaceContainerHighest: AppColors.surfaceElevated,

      // Background colors
      background: AppColors.background,
      onBackground: AppColors.textPrimary,

      // Error colors
      error: AppColors.error,
      onError: AppColors.textPrimary,

      // Outline
      outline: AppColors.textDisabled,
      outlineVariant: AppColors.primary700,
    ),

    // SCAFFOLD BACKGROUND
    scaffoldBackgroundColor: AppColors.background,

    // APP BAR THEME
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.textPrimary,
      elevation: AppElevation.low,
      centerTitle: false,
      titleTextStyle: AppTypography.headingM,
    ),

    // CARD THEME
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: AppElevation.medium,
      shadowColor: Colors.black.withOpacity(0.14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // ELEVATED BUTTON THEME
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accentTeal500,
        foregroundColor: AppColors.textPrimary,
        elevation: AppElevation.low,
        shadowColor: Colors.black.withOpacity(0.10),
        textStyle: AppTypography.bodyM.copyWith(fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),

    // TEXT BUTTON THEME
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.accentTeal500,
        textStyle: AppTypography.bodyM.copyWith(fontWeight: FontWeight.w600),
      ),
    ),

    // OUTLINED BUTTON THEME
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.accentTeal500,
        side: const BorderSide(color: AppColors.accentTeal500, width: 1.5),
        textStyle: AppTypography.bodyM.copyWith(fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),

    // ICON BUTTON THEME
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        highlightColor: AppColors.accentTeal500.withOpacity(0.2),
      ),
    ),

    // FLOATING ACTION BUTTON THEME
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.accentTeal500,
      foregroundColor: AppColors.textPrimary,
      elevation: AppElevation.high,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    // INPUT DECORATION THEME
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.primary700,
      hintStyle: AppTypography.bodyM.copyWith(color: AppColors.textDisabled),
      labelStyle: AppTypography.bodyM.copyWith(color: AppColors.textSecondary),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.accentTeal500, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),

    // CHIP THEME
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.primary700,
      labelStyle: AppTypography.bodySM,
      selectedColor: AppColors.accentTeal500,
      secondaryLabelStyle: AppTypography.bodySM.copyWith(
        color: AppColors.textPrimary,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),

    // DIVIDER THEME
    dividerTheme: DividerThemeData(
      color: AppColors.primary700,
      thickness: 1,
      space: 1,
    ),

    // BOTTOM NAVIGATION BAR THEME
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.accentTeal500,
      unselectedItemColor: AppColors.textSecondary,
      selectedLabelStyle: AppTypography.caption,
      unselectedLabelStyle: AppTypography.caption,
      elevation: AppElevation.medium,
      type: BottomNavigationBarType.fixed,
    ),

    // BOTTOM SHEET THEME
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.surface,
      elevation: AppElevation.high,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    ),

    // DIALOG THEME
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.surface,
      elevation: AppElevation.splash,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle: AppTypography.headingM,
      contentTextStyle: AppTypography.bodyM,
    ),

    // SNACKBAR THEME
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.surfaceElevated,
      contentTextStyle: AppTypography.bodyM,
      elevation: AppElevation.high,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),

    // TYPOGRAPHY
    textTheme: AppTypography.textTheme,

    // ICON THEME
    iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 24),
  );
}
