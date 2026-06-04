import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:spend_summary_assignment/main.dart';

void main() {
  testWidgets('Spend summary screen renders key content',
      (WidgetTester tester) async {
    await tester.pumpWidget(const SpendSummaryApp());
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.text('Spend Summary'), findsOneWidget);
    expect(find.text('Categories'), findsOneWidget);
    expect(find.text('Monthly spend'), findsOneWidget);
    expect(find.text('Top category'), findsOneWidget);
    expect(find.text('Add'), findsOneWidget);

    await tester.drag(find.byType(CustomScrollView), const Offset(0, -500));
    await tester.pumpAndSettle();

    expect(find.text('Recent Transactions'), findsOneWidget);
    expect(find.text('Zomato'), findsOneWidget);
  });
}
