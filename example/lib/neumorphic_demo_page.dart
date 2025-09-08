import 'package:flutter/material.dart';
import 'package:neumorphic_flutter_kr/neumorphic_flutter_kr.dart';
import 'neumorphic_button.dart';

class NeumorphicDemoPage extends StatefulWidget {
  const NeumorphicDemoPage({super.key, required this.title});

  final String title;

  @override
  State<NeumorphicDemoPage> createState() => _NeumorphicDemoPageState();
}

class _NeumorphicDemoPageState extends State<NeumorphicDemoPage> {
  double _depth = 8.0;
  bool _isPressed = false;
  Alignment _lightSource = NeumorphicTheme.defaultLightSource;
  double _radius = 12.0;
  Color _boxColor = NeumorphicTheme.defaultBackground;

  // 광원 위치 선택지
  final List<MapEntry<String, Alignment>> _lightSources = [
    MapEntry('좌상단', Alignment.topLeft),
    MapEntry('상단', Alignment.topCenter),
    MapEntry('우상단', Alignment.topRight),
    MapEntry('좌측', Alignment.centerLeft),
    MapEntry('중앙', Alignment.center),
    MapEntry('우측', Alignment.centerRight),
    MapEntry('좌하단', Alignment.bottomLeft),
    MapEntry('하단', Alignment.bottomCenter),
    MapEntry('우하단', Alignment.bottomRight),
  ];

  // 색상 선택지
  final List<MapEntry<String, Color>> _colors = [
    MapEntry('기본', NeumorphicTheme.defaultBackground),
    MapEntry('블루', const Color(0xFFE3F2FD)),
    MapEntry('그린', const Color(0xFFE8F5E9)),
    MapEntry('핑크', const Color(0xFFFCE4EC)),
    MapEntry('퍼플', const Color(0xFFF3E5F5)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. 뉴모픽 프리뷰 영역
              Expanded(
                flex: 3,
                child: Center(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(_radius),
                      onTap: () {},
                      onTapDown: (_) => setState(() => _isPressed = true),
                      onTapUp: (_) => setState(() => _isPressed = false),
                      onTapCancel: () => setState(() => _isPressed = false),
                      child: NeumorphicBox(
                        depth: _isPressed ? -_depth : _depth,
                        color: _boxColor,
                        radius: BorderRadius.all(Radius.circular(_radius)),
                        lightSource: _lightSource,
                        padding: const EdgeInsets.all(30),
                        child: Icon(
                          _isPressed ? Icons.thumb_down : Icons.thumb_up,
                          size: 40,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 2. 옵션 컨트롤 영역
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '뉴모픽 설정',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // 깊이(depth) 슬라이더
                      NeumorphicBox(
                        depth: 4,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '깊이(depth): ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Slider(
                                    value: _depth,
                                    min: 1.0,
                                    max: 20.0,
                                    divisions: 19,
                                    label: _depth.round().toString(),
                                    onChanged: (value) {
                                      setState(() {
                                        _depth = value;
                                      });
                                    },
                                  ),
                                ),
                                Text('${_depth.round()}'),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // 곡률(radius) 슬라이더
                      NeumorphicBox(
                        depth: 4,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '곡률(radius): ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Slider(
                                    value: _radius,
                                    min: 0.0,
                                    max: 50.0,
                                    divisions: 50,
                                    label: _radius.round().toString(),
                                    onChanged: (value) {
                                      setState(() {
                                        _radius = value;
                                      });
                                    },
                                  ),
                                ),
                                Text('${_radius.round()}'),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // 광원 위치 선택
                      NeumorphicBox(
                        depth: 4,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '광원 위치(lightSource): ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: _lightSources.map((source) {
                                final isSelected = _lightSource == source.value;
                                return Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(8),
                                    onTap: () {
                                      setState(() {
                                        _lightSource = source.value;
                                      });
                                    },
                                    child: NeumorphicBox(
                                      depth: isSelected ? -4 : 4,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      child: Text(source.key),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // 색상 선택
                      NeumorphicBox(
                        depth: 4,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '배경 색상: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: _colors.map((colorOption) {
                                final isSelected =
                                    _boxColor == colorOption.value;
                                return Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(8),
                                    onTap: () {
                                      setState(() {
                                        _boxColor = colorOption.value;
                                      });
                                    },
                                    child: NeumorphicBox(
                                      depth: isSelected ? -4 : 4,
                                      color: colorOption.value,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      child: Text(colorOption.key),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // 눌림 테스트 버튼
                      Center(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {},
                            onTapDown: (_) => setState(() => _isPressed = true),
                            onTapUp: (_) => setState(() => _isPressed = false),
                            onTapCancel: () =>
                                setState(() => _isPressed = false),
                            child: NeumorphicBox(
                              depth: _isPressed ? -8 : 8,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              child: const Text('눌러서 효과 확인'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
