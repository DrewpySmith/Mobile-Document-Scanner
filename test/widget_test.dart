import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scanmind/main.dart';

void main() {
  testWidgets('App splash screen render test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: ScanMindApp(),
      ),
    );

    // Verify that the title ScanMind exists in our splash screen
    expect(find.text('ScanMind'), findsOneWidget);
  });
}
