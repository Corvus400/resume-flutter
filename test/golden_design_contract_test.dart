import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:resume_flutter/app.dart';
import 'package:resume_flutter/data/resume_data.dart';
import 'package:resume_flutter/router.dart';

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

Future<void> _precacheGoldenImages(WidgetTester tester) async {
  final context = tester.element(find.byType(ResumeFlutterApp));
  await tester.runAsync(() async {
    await Future.wait([
      precacheImage(const AssetImage('assets/images/Insights.png'), context),
      precacheImage(
        const AssetImage('assets/images/profile/avatar.png'),
        context,
      ),
      for (final project in personalProjects)
        if (project.imageAssetPath != null)
          precacheImage(AssetImage(project.imageAssetPath!), context),
    ]);
  });
  await tester.pumpAndSettle();
}

Future<void> _pumpDesktopApp(WidgetTester tester) async {
  await _loadFonts();
  appRouter.go('/');
  tester.view.physicalSize = const Size(1280, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(const ResumeFlutterApp());
  await _precacheGoldenImages(tester);
  await tester.pumpAndSettle();
}

Future<void> _pumpPhoneApp(WidgetTester tester) async {
  await _loadFonts();
  appRouter.go('/');
  tester.view.physicalSize = const Size(430, 932);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(const ResumeFlutterApp());
  await _precacheGoldenImages(tester);
  await tester.pumpAndSettle();
}

Future<void> _expectScaffoldGolden(
  WidgetTester tester,
  String goldenPath,
) async {
  await expectLater(find.byType(Scaffold), matchesGoldenFile(goldenPath));
}

void main() {
  testWidgets('phone hero navigation rail visual contract', (tester) async {
    await _pumpPhoneApp(tester);

    await _expectScaffoldGolden(
      tester,
      'goldens/phone_home_navigation_rail.png',
    );
  }, tags: ['golden']);

  testWidgets('phone profile card avatar visual contract', (tester) async {
    await _pumpPhoneApp(tester);
    await tester.ensureVisible(find.byKey(const Key('profile-card')));
    await tester.pumpAndSettle();

    await expectLater(
      find.byKey(const Key('profile-card')),
      matchesGoldenFile('goldens/phone_profile_card.png'),
    );
  }, tags: ['golden']);

  testWidgets('phone experience list visual contract', (tester) async {
    await _pumpPhoneApp(tester);
    await tester.tap(find.byKey(const Key('phone-nav-experience')));
    await tester.pumpAndSettle();

    await _expectScaffoldGolden(tester, 'goldens/phone_experience_list.png');
  }, tags: ['golden']);

  testWidgets('phone projects visual contract', (tester) async {
    await _pumpPhoneApp(tester);
    await tester.tap(find.byKey(const Key('phone-nav-projects')));
    await tester.pumpAndSettle();

    await _expectScaffoldGolden(tester, 'goldens/phone_projects.png');
  }, tags: ['golden']);

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

  testWidgets('desktop projects visual contract', (tester) async {
    await _pumpDesktopApp(tester);
    await tester.tap(find.text('個人開発').first);
    await tester.pumpAndSettle();

    await _expectScaffoldGolden(tester, 'goldens/desktop_projects.png');
  }, tags: ['golden']);
}
