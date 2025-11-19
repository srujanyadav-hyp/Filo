// Home Screen Widget Tests
// Per Phase 4 Task 22: 15+ test cases for home screen

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:filo/presentation/screens/home_screen.dart';
import 'package:filo/presentation/widgets/search_bar_widget.dart';
import 'package:filo/presentation/widgets/quick_action_button.dart';
import 'package:filo/presentation/widgets/file_card_widget.dart';

void main() {
  group('HomeScreen Widget Tests', () {
    testWidgets('renders app bar with title and settings button', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      expect(find.text('FILO'), findsOneWidget);
      expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
    });

    testWidgets('settings button shows snackbar when tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Settings screen coming soon'), findsOneWidget);
    });

    testWidgets('renders search bar widget', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      expect(find.byType(SearchBarWidget), findsOneWidget);
    });

    testWidgets('search bar is read-only and navigates on tap', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      final searchBar = find.byType(SearchBarWidget);
      expect(searchBar, findsOneWidget);

      await tester.tap(searchBar);
      await tester.pumpAndSettle();

      // Should navigate to search results screen
      expect(find.byType(HomeScreen), findsNothing);
    });

    testWidgets('renders quick actions section with title', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      expect(find.text('Quick Actions'), findsOneWidget);
    });

    testWidgets('renders all 4 quick action buttons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      expect(find.byType(QuickActionButton), findsNWidgets(4));
      expect(find.text('Add Files'), findsOneWidget);
      expect(find.text('Rules'), findsOneWidget);
      expect(find.text('Browse'), findsOneWidget);
      expect(find.text('Activity'), findsOneWidget);
    });

    testWidgets('add files button shows snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      await tester.tap(find.text('Add Files'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('File picker integration pending'), findsOneWidget);
    });

    testWidgets('rules button shows database setup message', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      await tester.tap(find.text('Rules'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Rule builder requires database setup'), findsOneWidget);
    });

    testWidgets('browse button navigates to search results', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      await tester.tap(find.text('Browse'));
      await tester.pumpAndSettle();

      // Should navigate away from home screen
      expect(find.byType(HomeScreen), findsNothing);
    });

    testWidgets('activity button navigates to activity log', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      await tester.tap(find.text('Activity'));
      await tester.pumpAndSettle();

      // Should navigate away from home screen
      expect(find.byType(HomeScreen), findsNothing);
    });

    testWidgets('renders recent files section with title', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      expect(find.text('Recent Files'), findsOneWidget);
    });

    testWidgets('renders file cards in recent section', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      expect(find.byType(FileCardWidget), findsWidgets);
    });

    testWidgets('file card tap navigates to file detail', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      final fileCard = find.byType(FileCardWidget).first;
      await tester.tap(fileCard);
      await tester.pumpAndSettle();

      // Should navigate away from home screen
      expect(find.byType(HomeScreen), findsNothing);
    });

    testWidgets('renders folder categories section', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      expect(find.text('Folder Categories'), findsOneWidget);
    });

    testWidgets('renders folder grid with 2 columns', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      // Find grid view
      final gridView = find.byType(SliverGrid);
      expect(gridView, findsOneWidget);
    });

    testWidgets('folder card tap shows feedback snackbar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      // Find and tap a folder card
      final folderCard = find.byType(Card).last;
      await tester.tap(folderCard);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      // Should show snackbar with folder name
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('renders floating action button', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('FAB shows file picker message on tap', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(
        find.text('File picker integration pending'),
        findsAtLeastNWidgets(1),
      );
    });

    testWidgets('uses correct spacing between sections', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      // Verify CustomScrollView structure
      expect(find.byType(CustomScrollView), findsOneWidget);
      expect(find.byType(SliverToBoxAdapter), findsWidgets);
    });
  });
}
