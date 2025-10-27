import 'package:aurora_auth/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders login and register tabs', (tester) async {
    await tester.pumpWidget(const AuroraAuthApp());
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();
    expect(find.text('Create Account'), findsOneWidget);
  });
}
