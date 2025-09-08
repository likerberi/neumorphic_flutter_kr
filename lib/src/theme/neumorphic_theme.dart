import 'package:flutter/material.dart';

/// 뉴로모픽 테마 기본값과 계산 유틸리티
class NeumorphicTheme {
  NeumorphicTheme._();

  /// 기본 배경색(라이트)
  static const Color defaultBackground = Color(0xFFE9EDF3);

  /// 기본 그림자 색상 범위
  static const Color defaultShadowDark = Color(0xFFA3B1C6);
  static const Color defaultShadowLight = Colors.white;

  /// 깊이(양수=돌출, 음수=눌림)
  static const double defaultDepth = 6.0;

  /// 곡률 반경
  static const BorderRadius defaultRadius =
      BorderRadius.all(Radius.circular(12));

  /// 광원 방향(왼쪽 위가 기본)
  static const Alignment defaultLightSource = Alignment.topLeft;
}

/// 광원 기준으로 그림자 오프셋 계산
Offset computeShadowOffset({
  required Alignment lightSource,
  required double depth,
}) {
  // Alignment(-1..1, -1..1)를 픽셀 오프셋으로 매핑
  final factor = depth.clamp(-20.0, 20.0);
  // light 방향 반대편에 어두운 그림자, 같은 편에 밝은 하이라이트
  return Offset(-lightSource.x * factor, -lightSource.y * factor);
}

/// 두 겹(BoxShadow)으로 뉴로모픽 효과 만들기
List<BoxShadow> buildNeumorphicShadows({
  required Alignment lightSource,
  required double depth,
  Color? darkColor,
  Color? lightColor,
  double? blur,
  double? spread,
}) {
  final offset =
      computeShadowOffset(lightSource: lightSource, depth: depth.abs());
  final blurRadius = blur ?? (depth.abs() * 2.5 + 6);
  final spreadRadius = spread ?? (depth.sign * 0.0); // 기본 0

  // 양수=돌출(outer shadow), 음수=눌림(inset 유사 표현은 InnerDecoration으로 대체 필요)
  return <BoxShadow>[
    BoxShadow(
      color: (darkColor ?? NeumorphicTheme.defaultShadowDark).withOpacity(0.6),
      offset: Offset(offset.dx, offset.dy),
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
    ),
    BoxShadow(
      color:
          (lightColor ?? NeumorphicTheme.defaultShadowLight).withOpacity(0.9),
      offset: Offset(-offset.dx, -offset.dy),
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
    ),
  ];
}
