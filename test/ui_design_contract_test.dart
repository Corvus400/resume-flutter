import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:resume_flutter/app.dart';
import 'package:resume_flutter/data/resume_data.dart';
import 'package:resume_flutter/router.dart';
import 'package:resume_flutter/theme/app_colors.dart';

Future<void> _pumpDesktopApp(WidgetTester tester) async {
  appRouter.go('/');
  tester.view.physicalSize = const Size(1280, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(const ResumeFlutterApp());
  await tester.pumpAndSettle();
}

Future<void> _pumpMobileApp(WidgetTester tester) async {
  appRouter.go('/');
  tester.view.physicalSize = const Size(430, 932);
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
  group('Mobile navigation contract', () {
    testWidgets('phone portrait uses a right-edge icon navigation rail', (
      tester,
    ) async {
      await _pumpMobileApp(tester);

      for (final section in [
        'home',
        'experience',
        'projects',
        'activities',
        'skills',
      ]) {
        final item = find.byKey(Key('phone-nav-$section'));
        expect(item, findsOneWidget);

        final rect = tester.getRect(item);
        expect(rect.left, greaterThanOrEqualTo(370));
        expect(rect.right, lessThanOrEqualTo(430));
      }

      expect(find.text('個人開発'), findsNothing);
      expect(find.byKey(const Key('phone-nav-rail')), findsOneWidget);
    });

    testWidgets('phone portrait rail opens every top-level section', (
      tester,
    ) async {
      await _pumpMobileApp(tester);

      for (final entry in const [
        ('projects', 'Personal Projects'),
        ('activities', 'Outside Activities'),
        ('skills', 'Skills'),
      ]) {
        await tester.tap(find.byKey(Key('phone-nav-${entry.$1}')));
        await tester.pumpAndSettle();

        expect(find.text(entry.$2.toUpperCase()), findsOneWidget);
      }
    });

    testWidgets('phone landscape and non-phone layouts do not show the rail', (
      tester,
    ) async {
      for (final size in const [
        Size(844, 390),
        Size(600, 900),
        Size(1280, 900),
      ]) {
        appRouter.go('/');
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;
        await tester.pumpWidget(const ResumeFlutterApp());
        await tester.pumpAndSettle();

        expect(find.byKey(const Key('phone-nav-rail')), findsNothing);
      }
    });
  });

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

    testWidgets('phone portrait profile avatar remains circular inside rail', (
      tester,
    ) async {
      await _pumpMobileApp(tester);

      final card = find.byKey(const Key('profile-card'));
      final frame = find.byKey(const Key('profile-avatar-frame'));
      final image = find.descendant(of: frame, matching: find.byType(Image));
      expect(card, findsOneWidget);
      expect(frame, findsOneWidget);
      expect(image, findsOneWidget);

      final cardRect = tester.getRect(card);
      final frameRect = tester.getRect(frame);
      final imageRect = tester.getRect(image);
      expect(frameRect.width, closeTo(frameRect.height, 0.1));
      expect(imageRect.width, closeTo(imageRect.height, 0.1));
      expect(frameRect.left, greaterThanOrEqualTo(cardRect.left + 28));
      expect(frameRect.right, lessThanOrEqualTo(cardRect.right - 28));
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
    testWidgets('phone title stays on one line and clear of the count label', (
      tester,
    ) async {
      await _pumpMobileApp(tester);
      await tester.tap(find.byKey(const Key('phone-nav-experience')));
      await tester.pumpAndSettle();

      final title = find.byKey(const Key('section-header-title'));
      final count = find.text('最新 4 件 / 全 24 件');
      expect(title, findsOneWidget);
      expect(count, findsOneWidget);

      final titleRect = tester.getRect(title);
      final countRect = tester.getRect(count);
      expect(titleRect.height, lessThanOrEqualTo(56));
      expect(titleRect.right, lessThanOrEqualTo(countRect.left - 8));
    });

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
        const Key('skill-block-ai'),
        const Key('skill-block-language'),
        const Key('skill-block-platform'),
      ]) {
        final decoration =
            tester.widget<DecoratedBox>(find.byKey(key)).decoration
                as BoxDecoration;
        expect(decoration.border, isNotNull);
      }

      final aiTop = tester
          .getTopLeft(find.byKey(const Key('skill-block-ai')))
          .dy;
      final languageTop = tester
          .getTopLeft(find.byKey(const Key('skill-block-language')))
          .dy;
      final platformTop = tester
          .getTopLeft(find.byKey(const Key('skill-block-platform')))
          .dy;
      expect(aiTop, lessThan(languageTop));
      expect(languageTop, lessThan(platformTop));
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
    });

    testWidgets('every desktop link-bearing row keeps its right-edge link column', (
      tester,
    ) async {
      // Regression guard for e9b8963 (fix: prevent outside activity layout
      // collapse). On a wide desktop viewport every activity row that has links
      // must lay out horizontally (period | body | links), which is the only
      // branch that builds the keyed link column
      // ('outside-activity-link-column-<period>-<title>', see
      // outside_activities_view.dart). When the row collapses to the stacked
      // (mobile-style) layout that key is not emitted at all. Iterating over
      // every group/item — instead of asserting a whole-page footer Y position —
      // covers newly added articles automatically and needs no threshold bump
      // when the list grows, which is what made the old footerTop guard drift
      // upward (1800 -> 2000 -> ...) with each added entry.
      await _pumpDesktopApp(tester);

      await tester.tap(find.text('その他活動').first);
      await tester.pumpAndSettle();

      for (final group in outsideActivityGroups) {
        for (final item in group.items) {
          if (item.links.isEmpty) continue;

          final rowKey = Key('outside-activity-row-${item.period}-${item.title}');
          final columnKey = Key(
            'outside-activity-link-column-${item.period}-${item.title}',
          );

          await tester.ensureVisible(find.byKey(rowKey, skipOffstage: false));
          await tester.pumpAndSettle();

          final rowFinder = find.byKey(rowKey);
          final columnFinder = find.byKey(columnKey);
          expect(
            rowFinder,
            findsOneWidget,
            reason: 'missing row for ${item.period} ${item.title}',
          );
          expect(
            columnFinder,
            findsOneWidget,
            reason:
                'desktop row collapsed to a stacked layout (no right-edge link '
                'column): ${item.period} ${item.title}',
          );

          // The link column hugs the right edge of the row.
          final rowRect = tester.getRect(rowFinder);
          final columnRect = tester.getRect(columnFinder);
          expect(
            (rowRect.right - columnRect.right).abs(),
            lessThanOrEqualTo(1),
            reason:
                'link column is not flush with the row right edge: '
                '${item.period} ${item.title}',
          );
        }
      }
    });

    testWidgets('desktop activity links stay in a right-edge column', (
      tester,
    ) async {
      await _pumpDesktopApp(tester);

      await tester.tap(find.text('その他活動').first);
      await tester.pumpAndSettle();

      final row = find.byKey(
        const Key(
          'outside-activity-row-2024.08 – 2024.09-DroidKaigi2024 コントリビュート',
        ),
      );
      final linkColumn = find.byKey(
        const Key(
          'outside-activity-link-column-2024.08 – 2024.09-DroidKaigi2024 コントリビュート',
        ),
      );
      final detail = find.text('31日間コントリビュート · Zenn記事 · Welcome Talk · 貢献順位');
      final zennLink = find.byKey(
        const Key(
          'outside-activity-link-https://zenn.dev/todayama_r/articles/55ddcb366cbc50',
        ),
      );
      final zennLinkInColumn = find.descendant(
        of: linkColumn,
        matching: zennLink,
      );

      expect(row, findsOneWidget);
      expect(linkColumn, findsOneWidget);
      expect(detail, findsOneWidget);
      expect(zennLinkInColumn, findsOneWidget);

      final rowRect = tester.getRect(row);
      final detailRect = tester.getRect(detail);
      final linkColumnRect = tester.getRect(linkColumn);
      final zennLinkRect = tester.getRect(zennLinkInColumn);

      expect(detailRect.right, lessThanOrEqualTo(linkColumnRect.left - 16));
      expect(
        (rowRect.right - linkColumnRect.right).abs(),
        lessThanOrEqualTo(1),
      );
      expect(
        (linkColumnRect.right - zennLinkRect.right).abs(),
        lessThanOrEqualTo(1),
      );
    });

    testWidgets('all desktop activity link columns avoid detail overlap', (
      tester,
    ) async {
      await _pumpDesktopApp(tester);

      await tester.tap(find.text('その他活動').first);
      await tester.pumpAndSettle();

      final activityContracts = const [
        (
          'outside-activity-row-2024.08 – 2024.09-DroidKaigi2024 コントリビュート',
          'outside-activity-link-column-2024.08 – 2024.09-DroidKaigi2024 コントリビュート',
          '31日間コントリビュート · Zenn記事 · Welcome Talk · 貢献順位',
        ),
        (
          'outside-activity-row-2023.08 – 2023.09-DroidKaigi2023 コントリビュート',
          'outside-activity-link-column-2023.08 – 2023.09-DroidKaigi2023 コントリビュート',
          '30日間コントリビュート · Zenn記事 · Welcome Talk · 貢献順位',
        ),
        (
          'outside-activity-row-2022.09 – 2022.10-DroidKaigi2022 コントリビュート',
          'outside-activity-link-column-2022.09 – 2022.10-DroidKaigi2022 コントリビュート',
          '26日間でPRを38個作成 · Issue 16個消化 · Welcome Talk',
        ),
      ];

      for (final contract in activityContracts) {
        final row = find.byKey(Key(contract.$1), skipOffstage: false);
        await tester.ensureVisible(row);
        await tester.pumpAndSettle();

        final visibleRow = find.byKey(Key(contract.$1));
        final linkColumn = find.byKey(Key(contract.$2));
        final detail = find.text(contract.$3);

        expect(visibleRow, findsOneWidget);
        expect(linkColumn, findsOneWidget);
        expect(detail, findsOneWidget);

        final rowRect = tester.getRect(visibleRow);
        final linkColumnRect = tester.getRect(linkColumn);
        final detailRect = tester.getRect(detail);
        expect(detailRect.right, lessThanOrEqualTo(linkColumnRect.left - 16));
        expect(
          (rowRect.right - linkColumnRect.right).abs(),
          lessThanOrEqualTo(1),
        );
      }
    });
  });

  group('Personal projects responsive contract', () {
    testWidgets('phone project cards are content-sized instead of stretched', (
      tester,
    ) async {
      await _pumpMobileApp(tester);
      await tester.tap(find.byKey(const Key('phone-nav-projects')));
      await tester.pumpAndSettle();

      final firstCard = find.byKey(const Key('project-card-0'));
      final footer = find.byKey(const Key('project-card-footer-0'));
      expect(firstCard, findsOneWidget);
      expect(footer, findsOneWidget);

      final cardRect = tester.getRect(firstCard);
      final footerRect = tester.getRect(footer);
      expect(cardRect.height, lessThan(560));
      expect(footerRect.bottom, lessThanOrEqualTo(cardRect.bottom));
    });

    testWidgets('tablet and desktop project cards keep the grid contract', (
      tester,
    ) async {
      for (final size in const [Size(768, 1024), Size(1280, 900)]) {
        appRouter.go('/');
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;
        await tester.pumpWidget(const ResumeFlutterApp());
        await tester.pumpAndSettle();

        if (size.width < 600) {
          await tester.tap(find.byKey(const Key('phone-nav-projects')));
        } else {
          await tester.tap(find.text('個人開発').first);
        }
        await tester.pumpAndSettle();

        expect(find.byKey(const Key('phone-nav-rail')), findsNothing);
        expect(find.byKey(const Key('project-grid')), findsOneWidget);
        final firstCard = find.byKey(const Key('project-card-0'));
        final footer = find.byKey(const Key('project-card-footer-0'));
        expect(firstCard, findsOneWidget);
        expect(footer, findsOneWidget);

        final cardRect = tester.getRect(firstCard);
        final footerRect = tester.getRect(footer);
        expect(cardRect.height, lessThan(size.width >= 1280 ? 580 : 520));
        expect(footerRect.bottom, lessThanOrEqualTo(cardRect.bottom));
        expect(footerRect.top, greaterThan(cardRect.top));
      }
    });

    testWidgets('desktop project cards match heights within each row', (
      tester,
    ) async {
      await _pumpDesktopApp(tester);
      await tester.tap(find.text('個人開発').first);
      await tester.pumpAndSettle();

      for (final pair in const [(0, 1), (2, 3), (4, 5), (6, 7)]) {
        final leftCard = find.byKey(Key('project-card-${pair.$1}'));
        final rightCard = find.byKey(Key('project-card-${pair.$2}'));
        final leftFooter = find.byKey(Key('project-card-footer-${pair.$1}'));
        final rightFooter = find.byKey(Key('project-card-footer-${pair.$2}'));

        expect(leftCard, findsOneWidget);
        expect(rightCard, findsOneWidget);

        final leftRect = tester.getRect(leftCard);
        final rightRect = tester.getRect(rightCard);
        expect(leftRect.top, closeTo(rightRect.top, 0.1));
        expect(leftRect.height, closeTo(rightRect.height, 0.1));

        expect(
          tester.getRect(leftFooter).bottom,
          closeTo(leftRect.bottom, 1.1),
        );
        expect(
          tester.getRect(rightFooter).bottom,
          closeTo(rightRect.bottom, 1.1),
        );
      }
    });

    testWidgets('draft project cards are visible but not tappable links', (
      tester,
    ) async {
      await _pumpDesktopApp(tester);
      await tester.tap(find.text('個人開発').first);
      await tester.pumpAndSettle();

      final draftCard = find
          .ancestor(
            of: find.text('fictional-drug-and-disease-ref-ios(メディマスタ)'),
            matching: find.byType(InkWell),
          )
          .first;
      expect(draftCard, findsOneWidget);
      expect(
        find.descendant(of: draftCard, matching: find.text('作成中')),
        findsWidgets,
      );
      expect(
        find.descendant(of: draftCard, matching: find.text('準備中')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: draftCard, matching: find.text('GitHub ↗')),
        findsNothing,
      );

      final inkWell = tester.widget<InkWell>(draftCard);
      expect(inkWell.onTap, isNull);
    });
  });
}
