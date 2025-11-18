// Tests for FILO App Theme
// Refs: design_tokens_ultra_ultra.md (full file)

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:filo/presentation/theme/app_colors.dart';
import 'package:filo/presentation/theme/app_typography.dart';
import 'package:filo/presentation/theme/app_spacing.dart';
import 'package:filo/presentation/theme/app_elevation.dart';
import 'package:filo/presentation/theme/app_theme.dart';

void main() {
  group('AppColors', () {
    test('primary colors match spec exactly', () {
      // design_tokens_ultra_ultra.md section 1.1
      expect(AppColors.primary900, const Color(0xFF0A0F1F));
      expect(AppColors.primary800, const Color(0xFF0F172A));
      expect(AppColors.primary700, const Color(0xFF152240));
      expect(AppColors.primary600, const Color(0xFF1E3A8A));
    });

    test('accent colors match spec exactly', () {
      // design_tokens_ultra_ultra.md section 1.2
      expect(AppColors.accentTeal500, const Color(0xFF06B6D4));
      expect(AppColors.accentTeal300, const Color(0xFF5EEBF7));
    });

    test('surface colors derived from primary palette', () {
      expect(AppColors.background, AppColors.primary900);
      expect(AppColors.surface, AppColors.primary800);
      expect(AppColors.surfaceElevated, AppColors.primary700);
    });
  });

  group('AppTypography', () {
    test('heading XL matches spec (28sp, 34 line-height, 700 weight)', () {
      // design_tokens_ultra_ultra.md section 2 - Headings
      expect(AppTypography.headingXL.fontSize, 28.0);
      expect(AppTypography.headingXL.height, 34 / 28);
      expect(AppTypography.headingXL.fontWeight, FontWeight.w700);
    });

    test('heading L matches spec (22sp, 28 line-height, 600 weight)', () {
      expect(AppTypography.headingL.fontSize, 22.0);
      expect(AppTypography.headingL.height, 28 / 22);
      expect(AppTypography.headingL.fontWeight, FontWeight.w600);
    });

    test('heading M matches spec (18sp, 24 line-height, 600 weight)', () {
      expect(AppTypography.headingM.fontSize, 18.0);
      expect(AppTypography.headingM.height, 24 / 18);
      expect(AppTypography.headingM.fontWeight, FontWeight.w600);
    });

    test('heading S matches spec (16sp, 22 line-height, 500 weight)', () {
      expect(AppTypography.headingS.fontSize, 16.0);
      expect(AppTypography.headingS.height, 22 / 16);
      expect(AppTypography.headingS.fontWeight, FontWeight.w500);
    });

    test('body L matches spec (16sp, 24 line-height, 400 weight)', () {
      expect(AppTypography.bodyL.fontSize, 16.0);
      expect(AppTypography.bodyL.height, 24 / 16);
      expect(AppTypography.bodyL.fontWeight, FontWeight.w400);
    });

    test('body M matches spec (14sp, 20 line-height, 400 weight)', () {
      expect(AppTypography.bodyM.fontSize, 14.0);
      expect(AppTypography.bodyM.height, 20 / 14);
      expect(AppTypography.bodyM.fontWeight, FontWeight.w400);
    });

    test('body SM matches spec (13sp, 18 line-height, 400 weight)', () {
      expect(AppTypography.bodySM.fontSize, 13.0);
      expect(AppTypography.bodySM.height, 18 / 13);
      expect(AppTypography.bodySM.fontWeight, FontWeight.w400);
    });

    test(
      'caption matches spec (12sp, 16 line-height, +0.3 letter spacing)',
      () {
        expect(AppTypography.caption.fontSize, 12.0);
        expect(AppTypography.caption.height, 16 / 12);
        expect(AppTypography.caption.fontWeight, FontWeight.w400);
        expect(AppTypography.caption.letterSpacing, 0.3);
      },
    );
  });

  group('AppSpacing', () {
    test('spacing scale has exactly 10 values matching spec', () {
      // design_tokens_ultra_ultra.md section 5
      // Only use: 2, 4, 6, 8, 12, 16, 24, 32, 48, 64 dp increments
      expect(AppSpacing.xs, 2.0);
      expect(AppSpacing.sm, 4.0);
      expect(AppSpacing.md, 6.0);
      expect(AppSpacing.lg, 8.0);
      expect(AppSpacing.xl, 12.0);
      expect(AppSpacing.xxl, 16.0);
      expect(AppSpacing.xxxl, 24.0);
      expect(AppSpacing.huge, 32.0);
      expect(AppSpacing.massive, 48.0);
      expect(AppSpacing.gigantic, 64.0);
    });

    test('card spacing is 12dp per home_shelf_ultra.md', () {
      expect(AppSpacing.spaceBetweenCards, 12.0);
    });

    test('section spacing is 24dp per home_shelf_ultra.md', () {
      expect(AppSpacing.spaceBetweenSections, 24.0);
    });
  });

  group('AppElevation', () {
    test('elevation levels match spec', () {
      // design_tokens_ultra_ultra.md section 3
      expect(AppElevation.low, 1.0);
      expect(AppElevation.medium, 3.0);
      expect(AppElevation.high, 6.0);
      expect(AppElevation.splash, 8.0);
    });

    test('shadow low has correct y-offset, blur, and opacity', () {
      final shadow = AppElevation.shadowLow;
      expect(shadow.offset, const Offset(0, 2));
      expect(shadow.blurRadius, 4.0);
      expect(shadow.color.opacity, closeTo(0.10, 0.01));
    });

    test('shadow medium has correct y-offset, blur, and opacity', () {
      final shadow = AppElevation.shadowMedium;
      expect(shadow.offset, const Offset(0, 6));
      expect(shadow.blurRadius, 12.0);
      expect(shadow.color.opacity, closeTo(0.14, 0.01));
    });

    test('shadow high has correct y-offset, blur, and opacity', () {
      final shadow = AppElevation.shadowHigh;
      expect(shadow.offset, const Offset(0, 12));
      expect(shadow.blurRadius, 24.0);
      expect(shadow.color.opacity, closeTo(0.18, 0.01));
    });

    test('shadow splash has correct y-offset, blur, and opacity', () {
      final shadow = AppElevation.shadowSplash;
      expect(shadow.offset, const Offset(0, 18));
      expect(shadow.blurRadius, 30.0);
      expect(shadow.color.opacity, closeTo(0.25, 0.01));
    });
  });

  group('AppTheme', () {
    test('darkTheme uses correct primary color', () {
      final theme = AppTheme.darkTheme;
      expect(theme.colorScheme.primary, AppColors.accentTeal500);
    });

    test('darkTheme uses correct background color', () {
      final theme = AppTheme.darkTheme;
      expect(theme.scaffoldBackgroundColor, AppColors.background);
      expect(theme.colorScheme.background, AppColors.background);
    });

    test('darkTheme uses correct surface color', () {
      final theme = AppTheme.darkTheme;
      expect(theme.colorScheme.surface, AppColors.surface);
    });

    test('darkTheme applies AppTypography textTheme correctly', () {
      final theme = AppTheme.darkTheme;
      // Check key text styles match our custom typography
      expect(theme.textTheme.displayLarge?.fontSize, 28.0);
      expect(theme.textTheme.displayMedium?.fontSize, 22.0);
      expect(theme.textTheme.bodyLarge?.fontSize, 16.0);
      expect(theme.textTheme.bodyMedium?.fontSize, 14.0);
      expect(theme.textTheme.labelSmall?.letterSpacing, 0.3);
    });

    test('darkTheme card has 12dp border radius', () {
      final theme = AppTheme.darkTheme;
      final shape = theme.cardTheme.shape as RoundedRectangleBorder;
      final borderRadius = shape.borderRadius as BorderRadius;
      expect(borderRadius.topLeft.x, 12.0);
    });

    test('darkTheme elevated button has teal background', () {
      final theme = AppTheme.darkTheme;
      final buttonStyle = theme.elevatedButtonTheme.style!;
      final backgroundColor = buttonStyle.backgroundColor!.resolve({});
      expect(backgroundColor, AppColors.accentTeal500);
    });
  });

  testWidgets('MaterialApp with AppTheme.darkTheme renders correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.darkTheme,
        home: Scaffold(
          appBar: AppBar(title: const Text('Test')),
          body: const Center(child: Text('Theme Test')),
        ),
      ),
    );

    // Verify theme is applied
    final BuildContext context = tester.element(find.text('Theme Test'));
    final theme = Theme.of(context);

    expect(theme.scaffoldBackgroundColor, AppColors.background);
    expect(theme.colorScheme.primary, AppColors.accentTeal500);
  });
}
