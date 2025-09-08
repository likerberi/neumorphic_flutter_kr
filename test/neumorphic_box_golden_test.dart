import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:neumorphic_flutter_kr/neumorphic_flutter_kr.dart';

void main() {
  testWidgets('NeumorphicBox emboss(돌출) golden', (tester) async {
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(240, 200);
    addTearDown(() {
      tester.view.resetDevicePixelRatio();
      tester.view.resetPhysicalSize();
    });

    await tester.pumpWidget(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ColoredBox(
          color: NeumorphicTheme.defaultBackground,
          child: Center(
            child: NeumorphicBox(
              depth: 8,
              padding: EdgeInsets.all(24),
              radius: BorderRadius.all(Radius.circular(16)),
              child: Text('돌출', textDirection: ui.TextDirection.ltr),
            ),
          ),
        ),
      ),
    );

    await expectLater(
      find.byType(NeumorphicBox),
      matchesGoldenFile('test/goldens/neumorphic_box.emboss.png'),
    );
  });

  testWidgets('NeumorphicBox pressed(눌림) golden', (tester) async {
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(240, 200);
    addTearDown(() {
      tester.view.resetDevicePixelRatio();
      tester.view.resetPhysicalSize();
    });

    await tester.pumpWidget(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ColoredBox(
          color: NeumorphicTheme.defaultBackground,
          child: Center(
            child: NeumorphicBox(
              depth: -6,
              padding: EdgeInsets.all(24),
              radius: BorderRadius.all(Radius.circular(16)),
              child: Text('눌림', textDirection: ui.TextDirection.ltr),
            ),
          ),
        ),
      ),
    );

    await expectLater(
      find.byType(NeumorphicBox),
      matchesGoldenFile('test/goldens/neumorphic_box.pressed.png'),
    );
  });
}
