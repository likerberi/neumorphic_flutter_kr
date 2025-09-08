import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neumorphic_flutter_kr/neumorphic_flutter_kr.dart';

class InteractiveDemo extends StatefulWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  const InteractiveDemo({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  @override
  State<InteractiveDemo> createState() => _InteractiveDemoState();
}

class _InteractiveDemoState extends State<InteractiveDemo> {
  double _depth = 8.0;
  double _radius = 12.0;
  bool _isPressed = false;
  double _textScale = 1.0;
  Alignment _lightSource = NeumorphicTheme.defaultLightSource;
  Color _backgroundColor = NeumorphicTheme.defaultBackground;

  // 광원 위치 옵션
  final Map<String, Alignment> _lightSources = {
    '좌상': Alignment.topLeft,
    '상단': Alignment.topCenter,
    '우상': Alignment.topRight,
    '좌측': Alignment.centerLeft,
    '중앙': Alignment.center,
    '우측': Alignment.centerRight,
    '좌하': Alignment.bottomLeft,
    '하단': Alignment.bottomCenter,
    '우하': Alignment.bottomRight,
  };

  // 배경색 옵션
  final Map<String, Color> _backgroundColors = {
    '기본': NeumorphicTheme.defaultBackground,
    '블루': const Color(0xFFE3F2FD),
    '그린': const Color(0xFFE8F5E9),
    '핑크': const Color(0xFFFCE4EC),
    '퍼플': const Color(0xFFF3E5F5),
  };

  // 현재 설정으로 코드 생성
  String _generateCode() {
    final lightSourceName = _lightSources.entries
        .firstWhere((e) => e.value == _lightSource)
        .key;
    final backgroundColorName = _backgroundColors.entries
        .firstWhere((e) => e.value == _backgroundColor)
        .key;

    return '''import 'package:flutter/material.dart';
import 'package:neumorphic_flutter_kr/neumorphic_flutter_kr.dart';

class MyNeumorphicWidget extends StatefulWidget {
  @override
  _MyNeumorphicWidgetState createState() => _MyNeumorphicWidgetState();
}

class _MyNeumorphicWidgetState extends State<MyNeumorphicWidget> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ${_getColorCode(_backgroundColor)}, // $backgroundColorName
      body: Center(
        child: GestureDetector(
          onTapDown: (_) => setState(() => isPressed = true),
          onTapUp: (_) => setState(() => isPressed = false),
          onTapCancel: () => setState(() => isPressed = false),
          child: NeumorphicBox(
            depth: isPressed ? ${-_depth.abs()} : ${_depth}, // 깊이
            color: ${_getColorCode(_backgroundColor)}, // 배경색
            radius: BorderRadius.all(Radius.circular(${_radius})), // 곡률
            lightSource: ${_getAlignmentCode(_lightSource)}, // 광원 위치: $lightSourceName
            padding: const EdgeInsets.all(40),
            child: Icon(
              isPressed ? Icons.touch_app : Icons.pan_tool,
              size: 60,
              color: Colors.blueGrey[700],
            ),
          ),
        ),
      ),
    );
  }
}''';
  }

  String _getColorCode(Color color) {
    if (color == NeumorphicTheme.defaultBackground) {
      return 'NeumorphicTheme.defaultBackground';
    }
    return 'Color(0x${color.value.toRadixString(16).toUpperCase()})';
  }

  String _getAlignmentCode(Alignment alignment) {
    if (alignment == Alignment.topLeft) return 'Alignment.topLeft';
    if (alignment == Alignment.topCenter) return 'Alignment.topCenter';
    if (alignment == Alignment.topRight) return 'Alignment.topRight';
    if (alignment == Alignment.centerLeft) return 'Alignment.centerLeft';
    if (alignment == Alignment.center) return 'Alignment.center';
    if (alignment == Alignment.centerRight) return 'Alignment.centerRight';
    if (alignment == Alignment.bottomLeft) return 'Alignment.bottomLeft';
    if (alignment == Alignment.bottomCenter) return 'Alignment.bottomCenter';
    if (alignment == Alignment.bottomRight) return 'Alignment.bottomRight';
    return 'NeumorphicTheme.defaultLightSource';
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _generateCode()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('코드가 클립보드에 복사되었습니다!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showCodePreview() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '생성된 Flutter 코드',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: _generateCode()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('코드가 클립보드에 복사되었습니다!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: const Icon(Icons.copy),
                        tooltip: '복사',
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: SingleChildScrollView(
                    child: SelectableText(
                      _generateCode(),
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '💡 이 코드를 복사해서 새 Flutter 프로젝트에 붙여넣기 하세요!',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text('뉴로모픽 인터랙티브 데모'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: _textScale),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isNarrow = constraints.maxWidth < 720;
            if (isNarrow) {
              // 모바일/좁은 화면: 세로 스택
              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildPreviewSection(),
                      const SizedBox(height: 16),
                      _buildControlsPanel(),
                      const SizedBox(height: 16),
                      _buildRightPanel(isScrollable: false),
                    ],
                  ),
                ),
              );
            }

            // 데스크톱/넓은 화면: 3열 레이아웃 유지
            return Row(
              children: [
                Expanded(flex: 1, child: _buildControlsPanel()),
                Expanded(flex: 2, child: _buildPreviewSection()),
                Expanded(flex: 1, child: _buildRightPanel()),
              ],
            );
          },
        ),
      ),
    );
  }

  // 좌: 컨트롤 패널
  Widget _buildControlsPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[100],
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 표시/접근성
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '표시/접근성',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Row(
                  children: [
                    const Icon(Icons.dark_mode, size: 18),
                    Switch(
                      value: widget.themeMode == ThemeMode.dark,
                      onChanged: (v) => widget.onThemeModeChanged(
                        v ? ThemeMode.dark : ThemeMode.light,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text('텍스트 크기 (접근성)'),
            Slider(
              value: _textScale,
              min: 0.8,
              max: 1.6,
              divisions: 8,
              label: _textScale.toStringAsFixed(1),
              onChanged: (v) => setState(() => _textScale = v),
            ),
            const Divider(height: 24),

            const Text(
              '설정',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // 깊이 조절
            const Text(
              '깊이 (depth)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Slider(
              value: _depth,
              min: -20.0,
              max: 20.0,
              divisions: 40,
              label: _depth.round().toString(),
              onChanged: (value) => setState(() => _depth = value),
            ),
            Text('현재: ${_depth.round()}', style: const TextStyle(fontSize: 12)),

            const SizedBox(height: 20),

            // 곡률 조절
            const Text(
              '곡률 (radius)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Slider(
              value: _radius,
              min: 0.0,
              max: 50.0,
              divisions: 50,
              label: _radius.round().toString(),
              onChanged: (value) => setState(() => _radius = value),
            ),
            Text(
              '현재: ${_radius.round()}px',
              style: const TextStyle(fontSize: 12),
            ),

            const SizedBox(height: 20),

            // 광원 위치
            const Text(
              '광원 위치',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: _lightSources.entries.map((entry) {
                final isSelected = _lightSource == entry.value;
                return GestureDetector(
                  onTap: () => setState(() => _lightSource = entry.value),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      entry.key,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // 배경색
            const Text(
              '배경색',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Column(
              children: _backgroundColors.entries.map((entry) {
                final isSelected = _backgroundColor == entry.value;
                return ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: entry.value,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  title: Text(entry.key, style: const TextStyle(fontSize: 14)),
                  trailing: isSelected
                      ? const Icon(Icons.check, size: 16)
                      : null,
                  onTap: () => setState(() => _backgroundColor = entry.value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // 중: 미리보기 섹션
  Widget _buildPreviewSection() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTapDown: (_) => setState(() => _isPressed = true),
              onTapUp: (_) => setState(() => _isPressed = false),
              onTapCancel: () => setState(() => _isPressed = false),
              child: NeumorphicBox(
                depth: _isPressed ? -_depth.abs() : _depth,
                color: _backgroundColor,
                radius: BorderRadius.all(Radius.circular(_radius)),
                lightSource: _lightSource,
                padding: const EdgeInsets.all(40),
                child: Icon(
                  _isPressed ? Icons.touch_app : Icons.pan_tool,
                  size: 60,
                  color: Colors.blueGrey[700],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _isPressed ? '눌린 상태' : '기본 상태',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'depth: ${_isPressed ? -_depth.abs() : _depth} | radius: $_radius',
              style: TextStyle(fontSize: 14, color: Colors.blueGrey[600]),
            ),
          ],
        ),
      ),
    );
  }

  // 우: 코드 생성 + 샘플 패널
  Widget _buildRightPanel({bool isScrollable = true}) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 코드 생성 섹션
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '소스 코드 생성',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                '현재 설정으로 Flutter 코드를 생성합니다',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _copyToClipboard,
                      icon: const Icon(Icons.copy, size: 16),
                      label: const Text('클립보드 복사'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _showCodePreview,
                      icon: const Icon(Icons.code, size: 16),
                      label: const Text('코드 보기'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // 샘플 갤러리
        const Text(
          '샘플들',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),

        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildSampleSection('깊이 변화', [
              _buildSample('얕음', depth: 2),
              _buildSample('보통', depth: 8),
              _buildSample('깊음', depth: 15),
            ]),
            const SizedBox(height: 20),
            _buildSampleSection('곡률 변화', [
              _buildSample('각짐', radius: 0),
              _buildSample('둥글', radius: 12),
              _buildSample('매우 둥글', radius: 25),
            ]),
            const SizedBox(height: 20),
            _buildSampleSection('색상 변화', [
              _buildSample('블루', color: const Color(0xFFE3F2FD)),
              _buildSample('그린', color: const Color(0xFFE8F5E9)),
              _buildSample('핑크', color: const Color(0xFFFCE4EC)),
            ]),
          ],
        ),
      ],
    );

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[50],
      child: isScrollable ? SingleChildScrollView(child: content) : content,
    );
  }

  Widget _buildSampleSection(String title, List<Widget> samples) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: samples,
        ),
      ],
    );
  }

  Widget _buildSample(
    String label, {
    double? depth,
    double? radius,
    Color? color,
  }) {
    return Column(
      children: [
        NeumorphicBox(
          depth: depth ?? 6,
          radius: BorderRadius.all(Radius.circular(radius ?? 12)),
          color: color ?? _backgroundColor,
          lightSource: _lightSource,
          padding: const EdgeInsets.all(12),
          child: Container(width: 20, height: 20),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}
