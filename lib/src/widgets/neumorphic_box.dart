import 'package:flutter/material.dart';
import '../theme/neumorphic_theme.dart';

/// 뉴로모픽 박스(가장 기본 위젯)
///
/// - depth: 양수면 돌출(emboss), 음수면 눌림(pressed)
/// - lightSource: 광원 위치(기본 좌상단)
/// - color: 배경색(미지정 시 테마 기본)
class NeumorphicBox extends StatelessWidget {
  const NeumorphicBox({
    super.key,
    this.child,
    this.depth = NeumorphicTheme.defaultDepth,
    this.color,
    this.radius = NeumorphicTheme.defaultRadius,
    this.padding,
    this.margin,
    this.lightSource = NeumorphicTheme.defaultLightSource,
    this.darkShadowColor,
    this.lightShadowColor,
  });

  final Widget? child;
  final double depth;
  final Color? color;
  final BorderRadius radius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Alignment lightSource;
  final Color? darkShadowColor;
  final Color? lightShadowColor;

  @override
  Widget build(BuildContext context) {
    final bg = color ?? NeumorphicTheme.defaultBackground;

    if (depth >= 0) {
      // 돌출 효과: 두 겹 외곽 그림자
      return Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: radius,
          boxShadow: buildNeumorphicShadows(
            lightSource: lightSource,
            depth: depth,
            darkColor: darkShadowColor,
            lightColor: lightShadowColor,
          ),
        ),
        child: child,
      );
    } else {
      // 눌림 효과: 반대 방향 그림자 + 어두운 배경
      final darkerBg = Color.lerp(bg, Colors.black, 0.1) ?? bg;
      return Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: darkerBg,
          borderRadius: radius,
          boxShadow: buildNeumorphicShadows(
            lightSource: lightSource,
            depth: depth.abs(), // 음수를 양수로 변환하되 반대 방향으로
            darkColor: lightShadowColor ?? NeumorphicTheme.defaultShadowLight,
            lightColor: darkShadowColor ?? NeumorphicTheme.defaultShadowDark,
          ),
        ),
        child: child,
      );
    }
  }
}
