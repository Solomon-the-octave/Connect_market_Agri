import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:client/main.dart'; // adjust the import path if needed

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build the widget tree with your app widget
    await tester.pumpWidget(const FamCare());

    // Verify the counter starts at 0
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Confirm the '+' icon is present before tapping
    final Finder addIcon = find.byIcon(Icons.add);
    expect(addIcon, findsOneWidget);

    // Tap the '+' icon and rebuild the widget
    await tester.tap(addIcon);
    await tester.pump(); // trigger a frame to rebuild UI

    // Verify the counter increments to 1
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
