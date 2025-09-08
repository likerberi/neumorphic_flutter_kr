import 'package:flutter/material.dart';
import 'package:neumorphic_flutter_kr/neumorphic_flutter_kr.dart';

/// NeumorphicBox를 래핑하여 버튼 동작을 추가한 클래스
class NeumorphicButton extends StatefulWidget {
  const NeumorphicButton({
    super.key,
    required this.child,
    this.onPressed,
    this.depth = 8.0,
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque, // 중요: 투명 영역도 터치 감지
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onPressed?.call();
        },
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
