import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:resume_flutter/app.dart';
import 'package:resume_flutter/theme/app_colors.dart';

Future<void> _pumpDesktopApp(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1280, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(const ResumeFlutterApp());
  await tester.pumpAndSettle();
}

Future<void> _openExperienceList(WidgetTester tester) async {
  await tester.tap(find.text('職務経歴').first);
  await tester.pumpAndSettle();
}

void main() {
  group('Hero design contract', () {
    testWidgets('profile avatar has a framed circular image', (tester) async {
      await _pumpDesktopApp(tester);

      final frame = find.byKey(const Key('profile-avatar-frame'));
      expect(frame, findsOneWidget);

      final decoration =
          tester.widget<DecoratedBox>(frame).decoration as BoxDecoration;
      expect(decoration.shape, BoxShape.circle);
      expect(decoration.border, isNotNull);
      expect(decoration.boxShadow, isNotEmpty);
    });

    testWidgets('profile link values are aligned to the right edge', (
      tester,
    ) async {
      await _pumpDesktopApp(tester);

      final cardRight = tester
          .getTopRight(find.byKey(const Key('profile-card')))
          .dx;
      for (final key in [
        const Key('profile-link-value-github'),
        const Key('profile-link-value-x'),
        const Key('profile-link-value-resume'),
      ]) {
        final valueRight = tester.getTopRight(find.byKey(key)).dx;
        expect((cardRight - valueRight).abs(), lessThanOrEqualTo(30));
      }
    });
  });

  group('Experience list design and interaction contract', () {
    testWidgets('uses the full resume count as denominator', (tester) async {
      await _pumpDesktopApp(tester);
      await _openExperienceList(tester);

      expect(find.text('最新 4 件 / 全 24 件'), findsOneWidget);
    });

    testWidgets('filter chips update the visible list', (tester) async {
      await _pumpDesktopApp(tester);
      await _openExperienceList(tester);

      await tester.tap(find.text('正社員'));
      await tester.pumpAndSettle();

      expect(find.text('該当する職務経歴はありません。'), findsOneWidget);
      expect(find.text('オイシックス・ラ・大地株式会社'), findsNothing);

      await tester.tap(find.text('業務委託'));
      await tester.pumpAndSettle();

      expect(find.text('該当する職務経歴はありません。'), findsNothing);
      expect(find.text('オイシックス・ラ・大地株式会社'), findsOneWidget);
      expect(find.text('newmo株式会社'), findsOneWidget);
      expect(find.text('株式会社ドワンゴ（KADOKAWAグループ）'), findsOneWidget);
      expect(find.text('株式会社ギフトモール（LUCHE GROUP）'), findsOneWidget);
    });

    testWidgets('all latest experience rows open their detail pages', (
      tester,
    ) async {
      for (final entry in const [
        ('オイシックス・ラ・大地株式会社', 'Oisix ECアプリ開発'),
        ('newmo株式会社', 'newmoタクシー車載タブレットアプリ&乗客用スマートフォンアプリ開発・保守'),
        ('株式会社ドワンゴ（KADOKAWAグループ）', 'Zen Studyアプリ開発・保守'),
        ('株式会社ギフトモール（LUCHE GROUP）', 'Giftmallアプリ開発・保守'),
      ]) {
        await _pumpDesktopApp(tester);
        await _openExperienceList(tester);

        await tester.ensureVisible(find.text(entry.$1));
        await tester.pumpAndSettle();
        await tester.tap(find.text(entry.$1));
        await tester.pumpAndSettle();

        expect(find.text(entry.$1), findsOneWidget);
        expect(find.textContaining(entry.$2), findsOneWidget);
      }
    });

    testWidgets('hover and focus state remains visually restrained', (
      tester,
    ) async {
      await _pumpDesktopApp(tester);
      await _openExperienceList(tester);

      final row = find.byKey(const Key('experience-row-oisix'));
      expect(row, findsOneWidget);

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer();
      await gesture.moveTo(tester.getCenter(row));
      await tester.pumpAndSettle();

      final decoration =
          tester.widget<AnimatedContainer>(row).decoration as BoxDecoration;
      expect(decoration.color, anyOf(isNull, equals(Colors.transparent)));
      expect(decoration.border, isNotNull);

      final hoveredArrow = tester.widget<CircleAvatar>(
        find.byKey(const Key('experience-row-arrow-oisix')),
      );
      expect(hoveredArrow.backgroundColor, equals(AppColors.primary));
    });

    testWidgets('keyboard focus does not use bright filled focus colors', (
      tester,
    ) async {
      await _pumpDesktopApp(tester);
      await _openExperienceList(tester);

      final row = find.byKey(const Key('experience-row-oisix'));
      final inkWell = tester.widget<InkWell>(
        find.ancestor(of: row, matching: find.byType(InkWell)).first,
      );
      expect(inkWell.focusColor, anyOf(isNull, equals(Colors.transparent)));
      expect(inkWell.hoverColor, isNot(const Color(0xFF9F4014)));
      expect(inkWell.hoverColor, isNot(const Color(0xFFDCE4EE)));
    });

    testWidgets('resume repository link matches the design layout contract', (
      tester,
    ) async {
      await _pumpDesktopApp(tester);
      await _openExperienceList(tester);

      final link = find.byKey(const Key('experience-resume-link'));
      expect(link, findsOneWidget);

      final linkWidth = tester.getSize(link).width;
      final rowWidth = tester
          .getSize(find.byKey(const Key('experience-row-oisix')))
          .width;
      expect(linkWidth, greaterThanOrEqualTo(rowWidth - 1));

      final left = tester.getTopLeft(find.text('全24件の職務経歴を見る')).dx;
      final right = tester.getTopRight(find.text('resume repository ↗')).dx;
      expect(left, lessThan(120));
      expect(right, greaterThan(1100));
    });
  });

  group('Experience detail contract', () {
    testWidgets('back link returns to the experience list', (tester) async {
      await _pumpDesktopApp(tester);
      await _openExperienceList(tester);

      await tester.tap(find.text('オイシックス・ラ・大地株式会社'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('experience-detail-back-link')));
      await tester.pumpAndSettle();

      expect(find.text('最新 4 件 / 全 24 件'), findsOneWidget);
      expect(find.text('newmo株式会社'), findsOneWidget);
    });
  });

  group('Skills design contract', () {
    testWidgets('skill groups are separated by design divider lines', (
      tester,
    ) async {
      await _pumpDesktopApp(tester);

      await tester.tap(find.text('スキル').first);
      await tester.pumpAndSettle();

      for (final key in [
        const Key('skill-block-language'),
        const Key('skill-block-platform'),
        const Key('skill-block-ai'),
      ]) {
        final decoration =
            tester.widget<DecoratedBox>(find.byKey(key)).decoration
                as BoxDecoration;
        expect(decoration.border, isNotNull);
      }
    });
  });

  group('Outside activities design contract', () {
    testWidgets('activity titles keep readable width on desktop', (
      tester,
    ) async {
      await _pumpDesktopApp(tester);

      await tester.tap(find.text('その他活動').first);
      await tester.pumpAndSettle();

      final droidKaigi2024 = find.text('DroidKaigi2024 コントリビュート');
      expect(droidKaigi2024, findsOneWidget);
      expect(tester.getSize(droidKaigi2024).width, greaterThan(180));

      final footerTop = tester
          .getTopLeft(find.text('FLUTTER WEB · HASH ROUTING'))
          .dy;
      expect(footerTop, lessThan(1800));
    });
  });
}
