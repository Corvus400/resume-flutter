import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:resume_flutter/data/resume_data.dart';

void main() {
  late String readme;

  setUpAll(() {
    final path =
        Platform.environment['RESUME_SOURCE_README'] ?? '../resume/README.md';
    final file = File(path);
    if (!file.existsSync()) {
      fail('Resume SSOT README is required: $path');
    }
    readme = file.readAsStringSync();
  });

  group('resume README source contract', () {
    test('latest four experience summaries keep source-backed content', () {
      for (final expected in const [
        'GraphQL(Federation)',
        'GoogleMapsAPI',
        'Datadog',
        'MagicPod',
        'Robolectric',
        'OAuth2.0',
        'OIDC',
        'firebase',
      ]) {
        expect(readme, contains(expected));
      }

      final newmo = experiences.singleWhere((e) => e.id == 'newmo');
      expect(
        newmo.techStack,
        containsAll([
          'GraphQL(Federation)',
          'GoogleMapsAPI',
          'Datadog',
          'MagicPod',
        ]),
      );
      expect(
        newmo.overview.map((item) => item.text),
        contains('モノリポジトリのため、Android/iOS/Web/BE全てが単一のリポジトリにて開発されている。'),
      );
      expect(
        newmo.overview.expand((item) => item.links).map((link) => link.url),
        contains('https://graphql.org/learn/federation/'),
      );

      final dwango = experiences.singleWhere((e) => e.id == 'dwango');
      expect(
        dwango.techStack,
        containsAll(['RESTAPI', 'Robolectric', 'firebase', 'OAuth2.0', 'OIDC']),
      );
      expect(
        dwango.overview.expand((item) => item.links).map((link) => link.url),
        contains(
          'https://play.google.com/store/apps/details?id=nico.ed.nnn.zane',
        ),
      );

      final giftmall = experiences.singleWhere((e) => e.id == 'giftmall');
      expect(giftmall.techStack, contains('firebase'));
      expect(
        giftmall.overview.expand((item) => item.links).map((link) => link.url),
        contains(
          'https://play.google.com/store/apps/details?id=jp.co.giftmall',
        ),
      );
    });

    test('outside activity links point to README URLs, not profile fallbacks', () {
      final urls = outsideActivityGroups
          .expand((group) => group.items)
          .expand((item) => item.links)
          .map((link) => link.url)
          .toSet();

      for (final url in const [
        'https://zenn.dev/todayama_r/articles/6a4f24033ba7be',
        'https://zenn.dev/todayama_r/articles/55ddcb366cbc50',
        'https://x.com/Todayama_R/status/1834398835327861168',
        'https://x.com/Todayama_R/status/1834398443361763519',
        'https://zenn.dev/todayama_r/articles/404e358eaac1f1',
        'https://x.com/Todayama_R/status/1702496851340193816?s=20',
        'https://twitter.com/Todayama_R/status/1702496604190847010',
        'https://github.com/DroidKaigi/conference-app-2022/pulls?q=is%3Apr+author%3ACorvus400+',
        'https://github.com/DroidKaigi/conference-app-2022/issues?q=is%3Aissue+assignee%3ACorvus400',
        'https://www.youtube.com/watch?v=P8BZw_yCokc&t=5327s',
        'https://zenn.dev/todayama_r',
      ]) {
        expect(readme, contains(url));
        expect(urls, contains(url));
      }

      expect(urls, isNot(contains(githubProfileUrl)));
      expect(urls, isNot(contains(xProfileUrl)));
    });

    test(
      'personal project tags are source-backed and do not include labels posing as skills',
      () {
        final mockServer = personalProjects.singleWhere(
          (project) => project.name.contains('mock-server'),
        );
        expect(mockServer.tags, ['Kotlin', 'Ktor 3.x', 'ktor-openapi-tools']);
        expect(mockServer.tags, isNot(contains('Scenario')));

        final resumeFlutter = personalProjects.singleWhere(
          (project) => project.name == 'resume-flutter',
        );
        expect(resumeFlutter.tags, ['Flutter', 'Dart', 'go_router']);
        expect(resumeFlutter.tags, isNot(contains('Design Spec')));
        expect(resumeFlutter.status, '公開中');
        expect(resumeFlutter.imageAssetPath, 'assets/readme/header.png');

        final specification = personalProjects.singleWhere(
          (project) => project.name == 'specification',
        );
        expect(
          specification.repoUrl,
          'https://github.com/Corvus400/specification',
        );
        expect(specification.summary, contains('複数リポジトリ'));
        expect(specification.summary, contains('横断'));
        expect(specification.tags, ['OpenAPI', 'Shell', 'Markdown']);
        expect(
          specification.imageAssetPath,
          'assets/images/readme/specification_header.png',
        );

        final designBlueprint = personalProjects.singleWhere(
          (project) => project.name == 'design-blueprint',
        );
        expect(
          designBlueprint.repoUrl,
          'https://github.com/Corvus400/design-blueprint',
        );
        expect(designBlueprint.summary, contains('複数リポジトリ'));
        expect(designBlueprint.summary, contains('UI実装'));
        expect(designBlueprint.tags, ['HTML', 'Playwright', 'VRT']);
        expect(
          designBlueprint.imageAssetPath,
          'assets/images/readme/design_blueprint_header.png',
        );
      },
    );
  });
}
