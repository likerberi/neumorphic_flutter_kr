import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:neumorphic_flutter_kr/neumorphic_flutter_kr.dart';

void main() {
  testWidgets('NeumorphicBox renders with child and depth', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: NeumorphicBox(
              depth: 8,
              padding: EdgeInsets.all(12),
              child: Text('hello'),
            ),
          ),
        ),
      ),
    );

    expect(find.text('hello'), findsOneWidget);
  });
}
