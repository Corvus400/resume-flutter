import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:resume_flutter/app.dart';

var _fontsLoaded = false;

Future<void> _loadFonts() async {
  if (_fontsLoaded) {
    return;
  }
  final fontLoader = FontLoader('Noto Sans JP')
    ..addFont(rootBundle.load('assets/fonts/NotoSansJP-VariableFont_wght.ttf'));
  await fontLoader.load();
  _fontsLoaded = true;
}

Future<void> _pumpDesktopApp(WidgetTester tester) async {
  await _loadFonts();
  tester.view.physicalSize = const Size(1280, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(const ResumeFlutterApp());
  await tester.pumpAndSettle();
}

Future<void> _expectScaffoldGolden(
  WidgetTester tester,
  String goldenPath,
) async {
  await expectLater(find.byType(Scaffold), matchesGoldenFile(goldenPath));
}

void main() {
  testWidgets('desktop hero visual contract', (tester) async {
    await _pumpDesktopApp(tester);

    await _expectScaffoldGolden(tester, 'goldens/desktop_hero.png');
  }, tags: ['golden']);

  testWidgets('desktop experience list visual contract', (tester) async {
    await _pumpDesktopApp(tester);
    await tester.tap(find.text('職務経歴').first);
    await tester.pumpAndSettle();

    await _expectScaffoldGolden(tester, 'goldens/desktop_experience_list.png');
  }, tags: ['golden']);

  testWidgets('desktop experience detail visual contract', (tester) async {
    await _pumpDesktopApp(tester);
    await tester.tap(find.text('職務経歴').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('オイシックス・ラ・大地株式会社'));
    await tester.pumpAndSettle();

    await _expectScaffoldGolden(
      tester,
      'goldens/desktop_experience_detail.png',
    );
  }, tags: ['golden']);

  testWidgets('desktop skills visual contract', (tester) async {
    await _pumpDesktopApp(tester);
    await tester.tap(find.text('スキル').first);
    await tester.pumpAndSettle();

    await _expectScaffoldGolden(tester, 'goldens/desktop_skills.png');
  }, tags: ['golden']);
}
