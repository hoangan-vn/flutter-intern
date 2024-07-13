import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safebump/widget/avatar/avatar.dart';
import 'package:safebump/widget/button/fill_button.dart';

void main() {
  testWidgets('test Avatar', (tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: XAvatar(
      name: 'Hoang An',
    )));

    final iconFinder = find.text('LD');
    expect(iconFinder, findsOneWidget);
  });

  testWidgets('test fill button', (tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: XFillButton(label: Text("Design"))));

    final textFinder = find.text("Design");
    expect(textFinder, findsOneWidget);
  });
}
