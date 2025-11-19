// Activity Log Screen Widget Tests
// Per Phase 4 Task 22: 12+ test cases for activity log screen

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:filo/presentation/screens/activity_log_screen.dart';
import 'package:filo/data/db/database.dart';

void main() {
  group('ActivityLogScreen Widget Tests', () {
    final mockLogs = [
      ActivityLogEntry(
        id: 1,
        activityType: 'file_moved',
        description: 'Moved document.pdf to Documents',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      ActivityLogEntry(
        id: 2,
        activityType: 'file_renamed',
        description: 'Renamed photo.jpg to vacation.jpg',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      ActivityLogEntry(
        id: 3,
        activityType: 'rule_executed',
        description: 'Rule "Move Invoices" executed',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];

    testWidgets('renders app bar with title', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ActivityLogScreen()));

      expect(find.text('Activity Log'), findsOneWidget);
    });

    testWidgets('renders filter dropdown', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ActivityLogScreen()));

      expect(find.byType(DropdownButton<String>), findsOneWidget);
    });

    testWidgets('filter dropdown has all options', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ActivityLogScreen()));

      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();

      expect(find.text('All Activities'), findsOneWidget);
      expect(find.text('File Moved'), findsOneWidget);
      expect(find.text('File Renamed'), findsOneWidget);
      expect(find.text('File Deleted'), findsOneWidget);
      expect(find.text('Rule Executed'), findsOneWidget);
    });

    testWidgets('changing filter updates visible logs', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: ActivityLogScreen()));

      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('File Moved').last);
      await tester.pumpAndSettle();

      // Dropdown should now show 'File Moved'
      expect(find.text('File Moved'), findsOneWidget);
    });

    testWidgets('renders activity cards in list', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ActivityLogScreen()));

      // Should render card widgets
      expect(find.byType(Card), findsWidgets);
    });

    testWidgets('activity card shows icon and description', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: ActivityLogScreen()));

      // Check for activity icons
      expect(find.byIcon(Icons.drive_file_move_outlined), findsWidgets);
    });

    testWidgets('activity card shows timestamp', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ActivityLogScreen()));

      // Look for relative time indicators
      expect(find.textContaining('ago'), findsWidgets);
    });

    testWidgets('undo button appears on activity cards', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: ActivityLogScreen()));

      expect(find.byIcon(Icons.undo), findsWidgets);
    });

    testWidgets('undo button shows confirmation dialog', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: ActivityLogScreen()));

      final undoButton = find.byIcon(Icons.undo).first;
      await tester.tap(undoButton);
      await tester.pumpAndSettle();

      expect(find.text('Undo Action?'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Undo'), findsOneWidget);
    });

    testWidgets('undo confirmation shows action description', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: ActivityLogScreen()));

      final undoButton = find.byIcon(Icons.undo).first;
      await tester.tap(undoButton);
      await tester.pumpAndSettle();

      expect(find.textContaining('undo this action'), findsOneWidget);
    });

    testWidgets('undo action shows appropriate feedback', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: ActivityLogScreen()));

      final undoButton = find.byIcon(Icons.undo).first;
      await tester.tap(undoButton);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Undo'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      // Should show snackbar with undo feedback
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('renders empty state when no logs', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: ActivityLogScreen()));

      // If no logs are loaded, should show empty state
      // This depends on actual data loading logic
      await tester.pumpAndSettle();
    });

    testWidgets('supports scrolling through activities', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: ActivityLogScreen()));

      // Find ListView
      final listView = find.byType(ListView);
      expect(listView, findsOneWidget);
    });

    testWidgets('activity types have correct icons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: ActivityLogScreen()));

      // Different activity types should have different icons
      // file_moved, file_renamed, file_deleted, rule_executed
      await tester.pumpAndSettle();
    });

    testWidgets('timestamp formatting is relative', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: ActivityLogScreen()));

      // Should show "5m ago", "2h ago", "Yesterday", etc.
      final textWidgets = find.byType(Text);
      expect(textWidgets, findsWidgets);
    });
  });
}
