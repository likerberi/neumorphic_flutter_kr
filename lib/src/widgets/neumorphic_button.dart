import 'package:flutter/material.dart';
import '../theme/neumorphic_theme.dart';
import 'neumorphic_box.dart';

/// 뉴로모픽 버튼(자동 눌림 효과)
///
/// - onPressed: 버튼 동작 콜백
/// - depth: 양수면 돌출(emboss), 눌렀을 때 자동으로 반전됨
/// - lightSource: 광원 위치(기본 좌상단)
/// - color: 배경색(미지정 시 테마 기본)
class NeumorphicButton extends StatefulWidget {
  const NeumorphicButton({
    super.key,
    required this.child,
    this.onPressed,
    this.depth = NeumorphicTheme.defaultDepth,
    this.color,
    this.radius,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    this.margin,
    this.lightSource,
    this.darkShadowColor,
    this.lightShadowColor,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final double depth;
  final Color? color;
  final BorderRadius? radius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Alignment? lightSource;
  final Color? darkShadowColor;
  final Color? lightShadowColor;

  @override
  State<NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: widget.radius ?? NeumorphicTheme.defaultRadius,
        onTap: widget.onPressed,
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: NeumorphicBox(
          depth: _isPressed ? -widget.depth : widget.depth,
          color: widget.color,
          radius: widget.radius ?? NeumorphicTheme.defaultRadius,
          padding: widget.padding,
          margin: widget.margin,
          lightSource: widget.lightSource ?? NeumorphicTheme.defaultLightSource,
          darkShadowColor: widget.darkShadowColor,
          lightShadowColor: widget.lightShadowColor,
          child: widget.child,
        ),
      ),
    );
  }
}
