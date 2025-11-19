// FILO Widget Tests
// Basic smoke test for app startup

import 'package:flutter_test/flutter_test.dart';
import 'package:filo/main.dart';

void main() {
  testWidgets('App starts and loads home screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the home screen elements are present
    expect(find.text('FILO'), findsOneWidget);
    expect(find.text('Quick Actions'), findsOneWidget);
    expect(find.text('Recent Files'), findsOneWidget);

    // Verify quick action buttons are present
    expect(find.text('Add Files'), findsOneWidget);
    expect(find.text('Rules'), findsOneWidget);
    expect(find.text('Browse'), findsOneWidget);
    expect(find.text('Activity'), findsOneWidget);
  });
}
