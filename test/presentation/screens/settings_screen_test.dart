// FILO Settings Screen Widget Tests
// Per Phase 5 Task 1: Complete test coverage for settings

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:filo/presentation/screens/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    // Initialize SharedPreferences with empty values
    SharedPreferences.setMockInitialValues({});
  });

  group('SettingsScreen Widget Tests', () {
    testWidgets('renders all 7 section headers', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Account'), findsOneWidget);
      expect(find.text('Indexing'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Appearance'), findsOneWidget);
      expect(find.text('Storage'), findsOneWidget);
      expect(find.text('Notifications'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);
    });

    testWidgets('renders AppBar with correct title', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(AppBar, 'Settings'), findsOneWidget);
      expect(find.byType(BackButton), findsOneWidget);
    });

    testWidgets('shows loading indicator initially', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Account section shows placeholder', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Sign in to sync'), findsOneWidget);
      expect(find.text('Coming soon'), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('tapping account placeholder shows snackbar', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Sign in to sync'));
      await tester.pumpAndSettle();

      expect(find.text('Account sync coming in future update'), findsOneWidget);
    });

    testWidgets('auto-index toggle works', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      // Find the auto-index switch
      final switchFinder = find.widgetWithText(
        SwitchListTile,
        'Auto-index files',
      );
      expect(switchFinder, findsOneWidget);

      // Initial state should be true (default)
      SwitchListTile switchTile = tester.widget(switchFinder);
      expect(switchTile.value, isTrue);

      // Tap to toggle
      await tester.tap(switchFinder);
      await tester.pumpAndSettle();

      // State should change
      switchTile = tester.widget(switchFinder);
      expect(switchTile.value, isFalse);
    });

    testWidgets('index schedule picker shows all options', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      // Tap schedule tile
      await tester.tap(find.text('Index schedule'));
      await tester.pumpAndSettle();

      // Check all options appear
      expect(find.text('Manual only'), findsWidgets);
      expect(find.text('Daily at midnight'), findsOneWidget);
      expect(find.text('Weekly on Sunday'), findsOneWidget);
    });

    testWidgets('selecting index schedule updates display', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      // Tap schedule tile
      await tester.tap(find.text('Index schedule'));
      await tester.pumpAndSettle();

      // Select daily
      await tester.tap(find.text('Daily at midnight'));
      await tester.pumpAndSettle();

      // Check subtitle updated
      expect(find.text('Daily at midnight'), findsOneWidget);
    });

    testWidgets('re-index button shows confirmation dialog', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      // Tap re-index button
      await tester.tap(find.text('Re-index all files'));
      await tester.pumpAndSettle();

      // Check dialog appears
      expect(find.text('Re-index All Files?'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Re-index'), findsOneWidget);
    });

    testWidgets('confirming re-index shows snackbar', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Re-index all files'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Re-index'));
      await tester.pumpAndSettle();

      expect(find.text('Re-indexing started...'), findsOneWidget);
    });

    testWidgets('search mode picker shows all 3 modes', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Default search mode'));
      await tester.pumpAndSettle();

      expect(find.text('Text search'), findsWidgets);
      expect(find.text('Fastest, keyword-based'), findsOneWidget);
      expect(find.text('Visual search'), findsOneWidget);
      expect(find.text('AI-powered image recognition'), findsOneWidget);
      expect(find.text('Semantic search'), findsOneWidget);
      expect(find.text('Natural language understanding'), findsOneWidget);
    });

    testWidgets('selecting search mode updates display', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Default search mode'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Semantic search'));
      await tester.pumpAndSettle();

      expect(find.text('Semantic search (most accurate)'), findsOneWidget);
    });

    testWidgets('clear search history shows snackbar', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Clear search history'));
      await tester.pumpAndSettle();

      expect(find.text('Search history cleared'), findsOneWidget);
    });

    testWidgets('theme picker shows all 3 modes', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(ListTile, 'Theme'));
      await tester.pumpAndSettle();

      expect(find.text('Light'), findsOneWidget);
      expect(find.text('Dark'), findsOneWidget);
      expect(find.text('System default'), findsWidgets);
    });

    testWidgets('selecting theme updates display', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(ListTile, 'Theme'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Dark'));
      await tester.pumpAndSettle();

      expect(find.text('Dark'), findsWidgets);
    });

    testWidgets('storage info displays cache and file count', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Cache size'), findsOneWidget);
      expect(find.text('Indexed files'), findsOneWidget);
      expect(find.textContaining('MB'), findsOneWidget);
      expect(find.textContaining('files'), findsAtLeastNWidgets(1));
    });

    testWidgets('clear cache shows confirmation dialog', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Clear cache'));
      await tester.pumpAndSettle();

      expect(find.text('Clear Cache?'), findsOneWidget);
      expect(find.text('This will free up storage space.'), findsOneWidget);
    });

    testWidgets('confirming clear cache shows snackbar', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Clear cache'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(ElevatedButton, 'Clear'));
      await tester.pumpAndSettle();

      expect(find.text('Cache cleared'), findsOneWidget);
    });

    testWidgets('clear index shows strong warning', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Clear index'));
      await tester.pumpAndSettle();

      expect(find.text('Clear Index?'), findsOneWidget);
      expect(find.textContaining('re-index'), findsOneWidget);
    });

    testWidgets('notifications toggle works', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      // Scroll to make widget visible
      final listView = find.byType(ListView);
      await tester.drag(listView, const Offset(0, -2000));
      await tester.pumpAndSettle();

      final switchFinder = find.widgetWithText(
        SwitchListTile,
        'Enable notifications',
      );
      expect(switchFinder, findsOneWidget);

      // Toggle off
      await tester.tap(switchFinder);
      await tester.pumpAndSettle();

      SwitchListTile switchTile = tester.widget(switchFinder);
      expect(switchTile.value, isFalse);
    });

    testWidgets('rule alerts toggle works', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      // Scroll to make widget visible
      final listView = find.byType(ListView);
      await tester.drag(listView, const Offset(0, -2000));
      await tester.pumpAndSettle();

      final switchFinder = find.widgetWithText(
        SwitchListTile,
        'Rule execution alerts',
      );
      expect(switchFinder, findsOneWidget);

      await tester.tap(switchFinder);
      await tester.pumpAndSettle();

      SwitchListTile switchTile = tester.widget(switchFinder);
      expect(switchTile.value, isFalse);
    });

    testWidgets('app version displays correctly', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      // Scroll to make widget visible
      final listView = find.byType(ListView);
      await tester.drag(listView, const Offset(0, -2500));
      await tester.pumpAndSettle();

      expect(find.text('App version'), findsOneWidget);
      // Version should load after pump
      expect(find.textContaining('+'), findsWidgets);
    });

    testWidgets('long-pressing version copies to clipboard', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      // Scroll to make widget visible
      final listView = find.byType(ListView);
      await tester.drag(listView, const Offset(0, -2500));
      await tester.pumpAndSettle();

      await tester.longPress(find.text('App version'));
      await tester.pumpAndSettle();

      expect(find.text('Version copied to clipboard'), findsOneWidget);
    });

    testWidgets('licenses button opens license page', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      // Scroll to make widget visible
      final listView = find.byType(ListView);
      await tester.drag(listView, const Offset(0, -2500));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open source licenses'));
      await tester.pumpAndSettle();

      // License page should appear
      expect(find.text('FILO'), findsWidgets);
    });

    testWidgets('privacy policy shows coming soon', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      // Scroll to make widget visible
      final listView = find.byType(ListView);
      await tester.drag(listView, const Offset(0, -2500));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Privacy policy'));
      await tester.pumpAndSettle();

      expect(find.text('Privacy policy coming soon'), findsOneWidget);
    });

    testWidgets('terms of service shows coming soon', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      // Scroll to make widget visible
      final listView = find.byType(ListView);
      await tester.drag(listView, const Offset(0, -2500));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Terms of service'));
      await tester.pumpAndSettle();

      expect(find.text('Terms of service coming soon'), findsOneWidget);
    });

    testWidgets('settings persist across rebuilds', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      // Toggle auto-index
      await tester.tap(find.widgetWithText(SwitchListTile, 'Auto-index files'));
      await tester.pumpAndSettle();

      // Rebuild widget
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      // Setting should persist
      final switchTile = tester.widget<SwitchListTile>(
        find.widgetWithText(SwitchListTile, 'Auto-index files'),
      );
      expect(switchTile.value, isFalse);
    });

    testWidgets('all section icons are present', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      // Check visible icons initially
      // Account
      expect(find.byIcon(Icons.person), findsOneWidget);
      // Indexing
      expect(find.byIcon(Icons.auto_awesome), findsOneWidget);
      expect(find.byIcon(Icons.schedule), findsOneWidget);
      expect(find.byIcon(Icons.refresh), findsOneWidget);
      // Search
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.history), findsOneWidget);
      // Appearance
      expect(find.byIcon(Icons.palette), findsOneWidget);

      // Scroll to middle sections
      final listView = find.byType(ListView);
      await tester.drag(listView, const Offset(0, -1500));
      await tester.pumpAndSettle();

      // Storage
      expect(find.byIcon(Icons.storage), findsOneWidget);
      expect(find.byIcon(Icons.folder), findsOneWidget);
      expect(find.byIcon(Icons.cleaning_services), findsOneWidget);
      expect(find.byIcon(Icons.delete_forever), findsOneWidget);

      // Scroll to bottom sections
      await tester.drag(listView, const Offset(0, -1000));
      await tester.pumpAndSettle();

      // Notifications
      expect(find.byIcon(Icons.notifications), findsOneWidget);
      expect(find.byIcon(Icons.rule), findsOneWidget);
      // About
      expect(find.byIcon(Icons.info), findsOneWidget);
      expect(find.byIcon(Icons.article), findsOneWidget);
      expect(find.byIcon(Icons.privacy_tip), findsOneWidget);
      expect(find.byIcon(Icons.description), findsOneWidget);
    });

    testWidgets('cancelling dialogs closes them without action', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();

      // Test re-index cancel
      await tester.tap(find.text('Re-index all files'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(find.text('Re-indexing started...'), findsNothing);

      // Scroll to storage section for cache test
      final listView = find.byType(ListView);
      await tester.drag(listView, const Offset(0, -1500));
      await tester.pumpAndSettle();

      // Test clear cache cancel
      await tester.tap(find.text('Clear cache'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(find.text('Cache cleared'), findsNothing);
    });
  });
}
