## 뉴로모픽 한국어 샘플 앱 (neumorphic_flutter_kr/example)

간단한 UI의 대표 중 하나인 뉴로모픽 디자인의 한글 샘플 앱입니다.
조정하시고, 코드를 긁어가시고, 인사이트도 얻어가세요!

### 무엇을 할 수 있나요?
- 실시간으로 깊이(depth), 곡률(radius), 광원(lightSource), 배경색을 조정
- 눌림(pressed) 상태를 터치로 확인
- 현재 설정 값으로 Flutter 위젯 코드 자동 생성 및 복사
- 다양한 스타일 샘플(깊이/곡률/색상) 갤러리 제공
 - 다크모드 토글 및 텍스트 크기(접근성) 조절

### 실행 방법
이 리포지토리를 클론한 뒤 예제 폴더에서 실행합니다.

```bash
cd example
flutter run -d chrome   # 웹(크롬)
# 또는
flutter run -d ios      # iOS 시뮬레이터
flutter run -d android  # Android 에뮬레이터
```

### 스크린샷/미리보기
- 반응형 레이아웃: 모바일에서는 세로 스택, 데스크톱/웹에서는 3열
- 코드 생성 다이얼로그에서 즉시 복사 가능
 - 상단 패널에서 다크모드 전환, 텍스트 스케일 조정 가능

### 참고
- 라이브러리 패키지: `neumorphic_flutter_kr`
- 데모 진입점: `example/lib/main.dart`
- 인터랙티브 화면: `example/lib/interactive_demo.dart`

피드백과 PR 환영합니다!
