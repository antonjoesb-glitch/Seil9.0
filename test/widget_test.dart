// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:newapp/presentation/screens/home/home_page.dart';



void main() {
  testWidgets('Conference home screen widgets render', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ConferenceHomePage()));
    await tester.pumpAndSettle();

    expect(find.text('IPS Conference 2026'), findsWidgets);
    expect(find.text('Core Conference Modules'), findsOneWidget);
  });
}
