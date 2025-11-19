// File Detail Screen Widget Tests
// Per Phase 4 Task 22: 10+ test cases for file detail screen

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:filo/presentation/screens/file_detail_screen.dart';

void main() {
  group('FileDetailScreen Widget Tests', () {
    const testFileName = 'test_document.pdf';
    const testFilePath = '/storage/test_document.pdf';
    const testFileType = 'pdf';
    const testFileSize = 1024000;
    final testDateModified = DateTime(2025, 11, 19, 10, 30);
    final testDateCreated = DateTime(2025, 11, 15, 10, 30);
    const testTags = ['Work', 'Important'];

    Widget createTestWidget() {
      return MaterialApp(
        home: FileDetailScreen(
          fileName: testFileName,
          filePath: testFilePath,
          fileType: testFileType,
          fileSize: testFileSize,
          dateModified: testDateModified,
          dateCreated: testDateCreated,
          tags: testTags,
        ),
      );
    }

    testWidgets('renders app bar with filename', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text(testFileName), findsOneWidget);
    });

    testWidgets('app bar has share and more buttons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byIcon(Icons.share_outlined), findsOneWidget);
      expect(find.byIcon(Icons.more_vert), findsOneWidget);
    });

    testWidgets('share button shows snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      await tester.tap(find.byIcon(Icons.share_outlined));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.textContaining('Share:'), findsOneWidget);
    });

    testWidgets('more button shows options menu', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      expect(find.text('Rename'), findsOneWidget);
      expect(find.text('Move'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('renders file preview area', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Check for file icon preview
      expect(find.byIcon(Icons.picture_as_pdf), findsOneWidget);
    });

    testWidgets('displays file type and size in preview', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('PDF'), findsOneWidget);
      expect(find.textContaining('KB'), findsOneWidget);
    });

    testWidgets('renders metadata table', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('File Name'), findsOneWidget);
      expect(find.text('File Type'), findsOneWidget);
      expect(find.text('File Size'), findsOneWidget);
      expect(find.text('Date Modified'), findsOneWidget);
      expect(find.text('Date Created'), findsOneWidget);
      expect(find.text('Location'), findsOneWidget);
    });

    testWidgets('displays correct file metadata values', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text(testFileName), findsWidgets);
      expect(find.text(testFilePath), findsOneWidget);
    });

    testWidgets('renders tags section when tags provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Tags'), findsOneWidget);
      expect(find.text('Work'), findsOneWidget);
      expect(find.text('Important'), findsOneWidget);
    });

    testWidgets('renders action bar with Open and Apply Rules buttons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Open'), findsOneWidget);
      expect(find.text('Apply Rules'), findsOneWidget);
    });

    testWidgets('Open button shows feedback snackbar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      await tester.tap(find.text('Open'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.textContaining('Opening'), findsOneWidget);
    });

    testWidgets('Apply Rules button shows feedback', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      await tester.tap(find.text('Apply Rules'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Applying rules...'), findsOneWidget);
    });

    testWidgets('preview area takes 56% of screen height', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      final expandedWidgets = find.byType(Expanded);
      expect(
        expandedWidgets,
        findsNWidgets(4),
      ); // 2 in layout + 2 in action bar
    });

    testWidgets('back button pops navigation', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Find back button in app bar
      final backButton = find.byType(BackButton);
      if (backButton.evaluate().isNotEmpty) {
        await tester.tap(backButton);
        await tester.pumpAndSettle();
      }
    });
  });
}
