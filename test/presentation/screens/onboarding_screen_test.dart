// FILO Onboarding Screen Widget Tests
// Per Phase 5 Task 2: Complete test coverage for onboarding

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:filo/presentation/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('OnboardingScreen Widget Tests', () {
    testWidgets('renders 3 onboarding pages', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
      await tester.pumpAndSettle();

      // Should start on page 1
      expect(find.text('Welcome to FILO'), findsOneWidget);
      expect(find.text('Your intelligent file organizer'), findsOneWidget);
    });

    testWidgets('shows skip button on first page', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Skip'), findsOneWidget);
      expect(find.text('Next'), findsOneWidget);
    });

    testWidgets('swipe navigation works left to right', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
      await tester.pumpAndSettle();

      // Start on page 1
      expect(find.text('Welcome to FILO'), findsOneWidget);

      // Swipe left to page 2
      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();

      expect(find.text('Powerful Features'), findsOneWidget);
      expect(find.text('Smart Search'), findsOneWidget);
    });

    testWidgets('next button navigates to second page', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      expect(find.text('Powerful Features'), findsOneWidget);
      expect(find.text('Auto-organize'), findsOneWidget);
    });

    testWidgets('page indicators update correctly', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
      await tester.pumpAndSettle();

      // Find all indicator containers
      final indicators = find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration != null &&
            (widget.decoration as BoxDecoration?)?.shape == BoxShape.circle,
      );

      expect(indicators, findsAtLeastNWidgets(3));

      // Navigate to page 2
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      // Indicators should still be present
      expect(indicators, findsAtLeastNWidgets(3));
    });

    testWidgets('features page shows all 3 feature cards', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
      await tester.pumpAndSettle();

      // Navigate to features page
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      expect(find.text('Smart Search'), findsOneWidget);
      expect(find.text('Auto-organize'), findsOneWidget);
      expect(find.text('Rule Automation'), findsOneWidget);
    });

    testWidgets('permissions page shows correct content', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
      await tester.pumpAndSettle();

      // Navigate to permissions page
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      expect(find.text('Allow Storage Access'), findsOneWidget);
      expect(find.text('Grant Permission'), findsOneWidget);
      expect(find.text('Skip for now'), findsOneWidget);
    });

    testWidgets('skip button not shown on permissions page', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
      await tester.pumpAndSettle();

      // Navigate to permissions page
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      // Skip button in top-right should not be shown
      expect(find.widgetWithText(TextButton, 'Skip'), findsNothing);

      // But "Skip for now" button at bottom should be shown
      expect(find.text('Skip for now'), findsOneWidget);
    });

    testWidgets('all pages have illustrations', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
      await tester.pumpAndSettle();

      // Page 1
      expect(find.byIcon(Icons.folder_special), findsOneWidget);

      // Page 2
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.auto_awesome), findsOneWidget);

      // Page 3
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.folder_open), findsOneWidget);
    });

    testWidgets('can swipe back from second page', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
      await tester.pumpAndSettle();

      // Go to page 2
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      expect(find.text('Powerful Features'), findsOneWidget);

      // Swipe right to go back
      await tester.drag(find.byType(PageView), const Offset(400, 0));
      await tester.pumpAndSettle();

      expect(find.text('Welcome to FILO'), findsOneWidget);
    });

    testWidgets('page indicators have correct count', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
      await tester.pumpAndSettle();

      // Find all circular indicator containers
      final indicators = find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).shape == BoxShape.circle &&
            widget.constraints?.maxWidth == 8,
      );

      expect(indicators, findsNWidgets(3));
    });

    testWidgets('feature cards have icons', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
      await tester.pumpAndSettle();

      // Go to features page
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.auto_fix_high), findsOneWidget);
      expect(find.byIcon(Icons.rule), findsOneWidget);
    });

    testWidgets('buttons have correct heights (48dp)', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
      await tester.pumpAndSettle();

      final button = tester.widget<SizedBox>(
        find
            .ancestor(
              of: find.widgetWithText(ElevatedButton, 'Next'),
              matching: find.byType(SizedBox),
            )
            .first,
      );

      expect(button.height, equals(48));
    });

    testWidgets('privacy message shown on permissions page', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
      await tester.pumpAndSettle();

      // Navigate to permissions page
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      expect(find.textContaining('never upload your data'), findsOneWidget);
    });

    testWidgets('page titles use correct typography', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
      await tester.pumpAndSettle();

      final titleText = tester.widget<Text>(find.text('Welcome to FILO'));

      expect(titleText.style?.fontWeight, equals(FontWeight.bold));
    });

    testWidgets('illustrations are circular', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
      await tester.pumpAndSettle();

      final illustration = tester.widget<Container>(
        find
            .ancestor(
              of: find.byIcon(Icons.folder_special),
              matching: find.byType(Container),
            )
            .first,
      );

      final decoration = illustration.decoration as BoxDecoration;
      expect(decoration.shape, equals(BoxShape.circle));
    });

    testWidgets('illustrations have correct size (224dp)', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
      await tester.pumpAndSettle();

      final sizedBox = tester.widget<SizedBox>(
        find
            .ancestor(
              of: find.byIcon(Icons.folder_special),
              matching: find.byType(SizedBox),
            )
            .first,
      );

      expect(sizedBox.width, equals(224));
      expect(sizedBox.height, equals(224));
    });

    testWidgets('button text changes on last page', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
      await tester.pumpAndSettle();

      // Page 1
      expect(find.text('Next'), findsOneWidget);

      // Page 2
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      expect(find.text('Next'), findsOneWidget);

      // Page 3
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      expect(find.text('Grant Permission'), findsOneWidget);
      expect(find.text('Next'), findsNothing);
    });
  });
}
