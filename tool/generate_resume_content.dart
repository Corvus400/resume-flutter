import 'dart:io';

import 'package:yaml/yaml.dart';

const _sourceDir = 'content/resume';
const _outputPath = 'lib/data/generated/resume_content.g.dart';

void main(List<String> args) {
  final checkOnly = args.contains('--check');
  final generated = _generate();
  final output = File(_outputPath);

  if (checkOnly) {
    if (!output.existsSync()) {
      stderr.writeln('Missing generated resume content: $_outputPath');
      exitCode = 1;
      return;
    }
    final current = output.readAsStringSync();
    if (current != generated) {
      stderr.writeln(
        'Generated resume content is stale. Run: dart run tool/generate_resume_content.dart',
      );
      exitCode = 1;
    }
    return;
  }

  output.parent.createSync(recursive: true);
  output.writeAsStringSync(generated);
}

String _generate() {
  final profile = _yamlMap('profile.yaml');
  final home = _yamlMap('home.yaml');
  final sections = _yamlMap('sections.yaml');
  final skills = _yamlMap('skills.yaml');
  final experiences = _yamlMap('experiences.yaml');
  final projects = _yamlMap('projects.yaml');
  final activities = _yamlMap('activities.yaml');

  final buffer = StringBuffer()
    ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND.')
    ..writeln(
      '// Run `dart run tool/generate_resume_content.dart` after editing content/resume/*.yaml.',
    )
    ..writeln()
    ..writeln("import '../models/experience.dart';")
    ..writeln("import '../models/home_content.dart';")
    ..writeln("import '../models/outside_activity.dart';")
    ..writeln("import '../models/personal_project.dart';")
    ..writeln("import '../models/section_content.dart';")
    ..writeln("import '../models/skill_entry.dart';")
    ..writeln()
    ..writeln('const profileName = ${_s(profile.string('name'))};')
    ..writeln('const profileRole = ${_s(profile.string('role'))};');

  final links = profile.childMap('links');
  buffer
    ..writeln(
      'const resumeRepositoryUrl = ${_s(links.string('resumeRepository'))};',
    )
    ..writeln('const githubProfileUrl = ${_s(links.string('githubProfile'))};')
    ..writeln('const xProfileUrl = ${_s(links.string('xProfile'))};')
    ..writeln('const zennProfileUrl = ${_s(links.string('zennProfile'))};');

  final stats = profile.childMap('stats');
  buffer
    ..writeln(
      'const totalExperienceCount = ${stats.integer('totalExperienceCount')};',
    )
    ..writeln(
      'const droidKaigiMergedPrCount = ${stats.integer('droidKaigiMergedPrCount')};',
    )
    ..writeln()
    ..writeln('const homeHeroEyebrow = ${_s(home.string('eyebrow'))};')
    ..writeln('const homeHeroHeadlineSegments = <HomeHeroSegment>[');
  for (final segment in home.list('headlineSegments').maps()) {
    buffer.writeln(
      '  HomeHeroSegment(text: ${_s(segment.string('text'))}, highlight: ${segment.boolean('highlight', defaultValue: false)}),',
    );
  }
  buffer
    ..writeln('];')
    ..writeln('const homeHeroSummary = ${_s(home.string('summary'))};')
    ..writeln('const homeHeroCtaLabel = ${_s(home.string('ctaLabel'))};')
    ..writeln('const homeHeroMetaItems = <HomeMetaItem>[');
  for (final item in home.list('meta').maps()) {
    buffer.writeln(
      '  HomeMetaItem(label: ${_s(item.string('label'))}, value: ${_s(item.string('value'))}),',
    );
  }
  final profileCard = home.childMap('profileCard');
  buffer
    ..writeln('];')
    ..writeln('const homeProfileCardYear = ${_s(profileCard.string('year'))};')
    ..writeln(
      'const homeProfileCardEyebrow = ${_s(profileCard.string('eyebrow'))};',
    )
    ..writeln(
      'const homeProfileAvatarAssetPath = ${_s(profileCard.string('avatarAssetPath'))};',
    )
    ..writeln('const homeProfileStats = <HomeStatItem>[');
  for (final stat in profileCard.list('stats').maps()) {
    buffer.writeln(
      '  HomeStatItem(value: ${_s(stat.string('value'))}, label: ${_s(stat.string('label'))}),',
    );
  }
  buffer
    ..writeln('];')
    ..writeln();

  for (final name in const ['experience', 'projects', 'activities', 'skills']) {
    final section = sections.childMap(name);
    buffer.writeln(
      'const ${name}Section = ResumeSectionContent(eyebrow: ${_s(section.string('eyebrow'))}, title: ${_s(section.string('title'))}, summary: ${_nullableS(section.optionalString('summary'))});',
    );
  }

  buffer
    ..writeln()
    ..writeln('const skillCategoryOrder = <SkillCategory>[');
  for (final category in skills.list('order').strings()) {
    buffer.writeln('  ${_skillCategory(category)},');
  }
  buffer
    ..writeln('];')
    ..writeln('const skillCategoryTitles = <SkillCategory, String>{');
  final skillTitles = skills.childMap('titles');
  for (final category in skills.list('order').strings()) {
    buffer.writeln(
      '  ${_skillCategory(category)}: ${_s(skillTitles.string(category))},',
    );
  }
  buffer
    ..writeln('};')
    ..writeln('const skills = <SkillCategory, List<SkillEntry>>{');
  final skillGroups = skills.childMap('groups');
  for (final category in const ['language', 'platform', 'ai']) {
    buffer.writeln('  ${_skillCategory(category)}: <SkillEntry>[');
    for (final item in skillGroups.list(category).maps()) {
      buffer.writeln(
        '    SkillEntry(name: ${_s(item.string('name'))}, experienceLabel: ${_s(item.string('experienceLabel'))}, experienceMonths: ${item.integer('experienceMonths')}),',
      );
    }
    buffer.writeln('  ],');
  }
  buffer
    ..writeln('};')
    ..writeln()
    ..writeln('const experiences = <Experience>[');
  for (final item in experiences.list('items').maps()) {
    _writeExperience(buffer, item);
  }
  buffer
    ..writeln('];')
    ..writeln()
    ..writeln('const personalProjects = <PersonalProject>[');
  for (final item in projects.list('items').maps()) {
    buffer
      ..writeln('  PersonalProject(')
      ..writeln('    name: ${_s(item.string('name'))},')
      ..writeln('    kind: ${_s(item.string('kind'))},')
      ..writeln('    summary: ${_s(item.string('summary'))},')
      ..writeln('    repoUrl: ${_s(item.string('repoUrl'))},')
      ..writeln(
        '    repoLinkEnabled: ${item.boolean('repoLinkEnabled', defaultValue: true)},',
      )
      ..writeln('    status: ${_s(item.string('status'))},')
      ..writeln(
        '    tags: <String>[${item.list('tags').strings().map(_s).join(', ')}],',
      );
    final imageAssetPath = item.optionalString('imageAssetPath');
    if (imageAssetPath != null) {
      buffer.writeln('    imageAssetPath: ${_s(imageAssetPath)},');
    }
    buffer.writeln('  ),');
  }
  buffer
    ..writeln('];')
    ..writeln()
    ..writeln('const outsideActivityGroups = <OutsideActivityGroup>[');
  for (final group in activities.list('groups').maps()) {
    buffer
      ..writeln('  OutsideActivityGroup(')
      ..writeln('    label: ${_s(group.string('label'))},')
      ..writeln('    title: ${_s(group.string('title'))},')
      ..writeln('    count: ${_s(group.string('count'))},')
      ..writeln('    items: <OutsideActivity>[');
    for (final item in group.list('items').maps()) {
      buffer
        ..writeln('      OutsideActivity(')
        ..writeln('        period: ${_s(item.string('period'))},')
        ..writeln('        title: ${_s(item.string('title'))},')
        ..writeln('        detail: ${_s(item.string('detail'))},');
      _writeLinks(buffer, item.optionalList('links'), indent: '        ');
      buffer.writeln('      ),');
    }
    buffer
      ..writeln('    ],')
      ..writeln('  ),');
  }
  buffer.writeln('];');

  return _formatDart(buffer.toString());
}

void _writeExperience(StringBuffer buffer, Map<String, Object?> item) {
  buffer
    ..writeln('  Experience(')
    ..writeln('    id: ${_s(item.string('id'))},')
    ..writeln(
      '    employmentType: ${_employmentType(item.string('employmentType'))},',
    )
    ..writeln('    period: ${_s(item.string('period'))},')
    ..writeln('    duration: ${_s(item.string('duration'))},')
    ..writeln('    bizType: ${_s(item.string('bizType'))},')
    ..writeln('    companyName: ${_s(item.string('companyName'))},')
    ..writeln('    projectName: ${_s(item.string('projectName'))},')
    ..writeln('    role: ${_s(item.string('role'))},');
  final team = item.optionalString('team');
  final collaboration = item.optionalString('collaboration');
  if (team != null) {
    buffer.writeln('    team: ${_s(team)},');
  }
  if (collaboration != null) {
    buffer.writeln('    collaboration: ${_s(collaboration)},');
  }
  buffer.writeln(
    '    techStack: <String>[${item.list('techStack').strings().map(_s).join(', ')}],',
  );
  _writeTextItems(buffer, 'overview', item.list('overview'));
  _writeTextItems(buffer, 'responsibility', item.list('responsibility'));
  _writeTextItems(buffer, 'challenges', item.list('challenges'));
  buffer.writeln('    approach: <TakumiSection>[');
  for (final section in item.list('approach').maps()) {
    buffer
      ..writeln('      TakumiSection(')
      ..writeln('        title: ${_s(section.string('title'))},')
      ..writeln('        body:');
    _writeTextItem(buffer, section.childMap('body'), indent: '          ');
    buffer.writeln('      ),');
  }
  buffer.writeln('    ],');
  _writeTextItems(buffer, 'ingenuity', item.list('ingenuity'));
  buffer.writeln('  ),');
}

void _writeTextItems(StringBuffer buffer, String name, List<Object?> items) {
  buffer.writeln('    $name: <ResumeTextItem>[');
  for (final item in items.maps()) {
    _writeTextItem(buffer, item, indent: '      ');
  }
  buffer.writeln('    ],');
}

void _writeTextItem(
  StringBuffer buffer,
  Map<String, Object?> item, {
  required String indent,
}) {
  buffer
    ..writeln('${indent}ResumeTextItem(')
    ..writeln('$indent  ${_s(item.string('text'))},');
  _writeLinks(buffer, item.optionalList('links'), indent: '$indent  ');
  buffer.writeln('$indent),');
}

void _writeLinks(
  StringBuffer buffer,
  List<Object?>? links, {
  required String indent,
}) {
  if (links == null || links.isEmpty) {
    return;
  }
  buffer.writeln('${indent}links: <ResumeLink>[');
  for (final link in links.maps()) {
    buffer.writeln(
      '$indent  ResumeLink(label: ${_s(link.string('label'))}, url: ${_s(link.string('url'))}),',
    );
  }
  buffer.writeln('$indent],');
}

Map<String, Object?> _yamlMap(String fileName) {
  final file = File('$_sourceDir/$fileName');
  if (!file.existsSync()) {
    throw StateError('Missing resume content file: ${file.path}');
  }
  final loaded = loadYaml(file.readAsStringSync());
  return _deepConvert(loaded) as Map<String, Object?>;
}

Object? _deepConvert(Object? value) {
  if (value is YamlMap) {
    return <String, Object?>{
      for (final entry in value.entries)
        if (entry.key is String) entry.key as String: _deepConvert(entry.value),
    };
  }
  if (value is YamlList) {
    return <Object?>[for (final item in value) _deepConvert(item)];
  }
  return value;
}

String _s(String value) {
  final escaped = value
      .replaceAll(r'\', r'\\')
      .replaceAll("'", r"\'")
      .replaceAll(r'$', r'\$')
      .replaceAll('\n', r'\n')
      .replaceAll('\r', r'\r')
      .replaceAll('\t', r'\t');
  return "'$escaped'";
}

String _nullableS(String? value) => value == null ? 'null' : _s(value);

String _employmentType(String value) => switch (value) {
  'fullTime' => 'EmploymentType.fullTime',
  'contract' => 'EmploymentType.contract',
  _ => throw StateError('Unknown employmentType: $value'),
};

String _skillCategory(String value) => switch (value) {
  'language' => 'SkillCategory.language',
  'platform' => 'SkillCategory.platform',
  'ai' => 'SkillCategory.ai',
  _ => throw StateError('Unknown skill category: $value'),
};

String _formatDart(String source) {
  final tempDir = Directory.systemTemp.createTempSync('resume_content_');
  try {
    final tempFile = File('${tempDir.path}/resume_content.g.dart')
      ..writeAsStringSync(source);
    final result = Process.runSync('dart', <String>[
      'format',
      tempFile.path,
    ], workingDirectory: Directory.current.path);
    if (result.exitCode != 0) {
      throw StateError('dart format failed: ${result.stderr}');
    }
    return tempFile.readAsStringSync();
  } finally {
    tempDir.deleteSync(recursive: true);
  }
}

extension _YamlMapReader on Map<String, Object?> {
  Map<String, Object?> childMap(String key) {
    final value = this[key];
    if (value is Map<String, Object?>) {
      return value;
    }
    throw StateError('Expected map at $key');
  }

  List<Object?> list(String key) {
    final value = this[key];
    if (value is List<Object?>) {
      return value;
    }
    throw StateError('Expected list at $key');
  }

  List<Object?>? optionalList(String key) {
    final value = this[key];
    if (value == null) {
      return null;
    }
    if (value is List<Object?>) {
      return value;
    }
    throw StateError('Expected list at $key');
  }

  String string(String key) {
    final value = this[key];
    if (value is String) {
      return value;
    }
    throw StateError('Expected string at $key');
  }

  String? optionalString(String key) {
    final value = this[key];
    if (value == null) {
      return null;
    }
    if (value is String) {
      return value;
    }
    throw StateError('Expected string at $key');
  }

  int integer(String key) {
    final value = this[key];
    if (value is int) {
      return value;
    }
    throw StateError('Expected int at $key');
  }

  bool boolean(String key, {required bool defaultValue}) {
    final value = this[key];
    if (value == null) {
      return defaultValue;
    }
    if (value is bool) {
      return value;
    }
    throw StateError('Expected bool at $key');
  }
}

extension _YamlListReader on List<Object?> {
  Iterable<Map<String, Object?>> maps() sync* {
    for (final item in this) {
      if (item is Map<String, Object?>) {
        yield item;
      } else {
        throw StateError('Expected map list item');
      }
    }
  }

  Iterable<String> strings() sync* {
    for (final item in this) {
      if (item is String) {
        yield item;
      } else {
        throw StateError('Expected string list item');
      }
    }
  }
}
