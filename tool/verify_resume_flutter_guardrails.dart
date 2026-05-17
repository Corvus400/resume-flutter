import 'dart:io';

void main() {
  final failures = <String>[];
  final trackedFiles = _gitLsFiles();

  _verifyNoTrackedGeneratedState(trackedFiles, failures);
  _verifyWorkflow(failures);
  _verifyRepoLocalHooks(failures);
  _verifySessionInventory(failures);
  _verifyPublicTextFiles(trackedFiles, failures);

  if (failures.isNotEmpty) {
    stderr.writeln('resume-flutter guardrail verification failed:');
    for (final failure in failures) {
      stderr.writeln('- $failure');
    }
    exitCode = 1;
    return;
  }

  stdout.writeln('resume-flutter guardrail verification passed.');
}

List<String> _gitLsFiles() {
  final result = Process.runSync('git', ['ls-files']);
  if (result.exitCode != 0) {
    stderr.write(result.stderr);
    exit(result.exitCode);
  }
  return (result.stdout as String)
      .split('\n')
      .where((line) => line.trim().isNotEmpty)
      .toList();
}

void _verifyNoTrackedGeneratedState(List<String> files, List<String> failures) {
  final forbiddenFragments = <String>[
    '.codex/auth.json',
    '.codex/history.jsonl',
    '.codex/sessions/',
    '.codex/cache/',
    '.codex/plugins/',
    '.agents/.skill-lock.json',
  ];
  final forbiddenPatterns = <RegExp>[
    RegExp(r'(^|/)logs_[^/]*\.sqlite'),
    RegExp(r'(^|/)state_[^/]*\.sqlite'),
  ];

  for (final file in files) {
    if (forbiddenFragments.any(file.contains) ||
        forbiddenPatterns.any((pattern) => pattern.hasMatch(file))) {
      failures.add('forbidden runtime state is tracked: $file');
    }
  }
}

void _verifyWorkflow(List<String> failures) {
  final ci = File('.github/workflows/ci.yml');
  if (!ci.existsSync()) {
    failures.add('missing .github/workflows/ci.yml');
    return;
  }
  final text = ci.readAsStringSync();
  final requiredFragments = <String>[
    'python3 .codex/hooks/test_resume_flutter_guard.py',
    'dart run tool/verify_resume_flutter_guardrails.dart',
    'dart run tool/generate_resume_content.dart --check',
    'flutter analyze',
    'flutter test --exclude-tags golden',
    'flutter build web --wasm --release --base-href "/\${REPO_NAME}/"',
    'ci-gate',
  ];

  for (final fragment in requiredFragments) {
    if (!text.contains(fragment)) {
      failures.add('CI workflow is missing required fragment: $fragment');
    }
  }
}

void _verifyRepoLocalHooks(List<String> failures) {
  final hooks = File('.codex/hooks.json');
  if (!hooks.existsSync()) {
    failures.add('missing .codex/hooks.json');
    return;
  }
  final text = hooks.readAsStringSync();
  final requiredFragments = <String>[
    '.codex/hooks/resume_flutter_guard.py',
    'user-prompt-submit',
    'pre-tool-use-bash',
  ];

  for (final fragment in requiredFragments) {
    if (!text.contains(fragment)) {
      failures.add('repo-local hooks are missing required fragment: $fragment');
    }
  }
}

void _verifySessionInventory(List<String> failures) {
  final docs = File('docs/session-retrospective-guardrails.md');
  if (!docs.existsSync()) {
    failures.add('missing docs/session-retrospective-guardrails.md');
    return;
  }
  final text = docs.readAsStringSync();
  final requiredFragments = <String>[
    '## Session Inventory',
    'Flutter Web planning',
    'Skill and setup checks',
    'Publication hardening',
    'Protected workflow',
    'UI and golden regressions',
    'Repository boundary',
    'user-level Codex dotfiles',
  ];

  for (final fragment in requiredFragments) {
    if (!text.contains(fragment)) {
      failures.add(
        'session guardrail docs are missing required fragment: $fragment',
      );
    }
  }
}

void _verifyPublicTextFiles(List<String> files, List<String> failures) {
  final textFilePattern = RegExp(
    r'\.(md|yml|yaml|json|toml|txt|arb|dart|html|css|js|py|sh)$',
  );
  final publicFiles = files.where((file) {
    if (!textFilePattern.hasMatch(file)) {
      return false;
    }
    if (file == 'tool/verify_resume_flutter_guardrails.dart') {
      return false;
    }
    return !file.startsWith('lib/data/generated/');
  });

  final localPathPattern = RegExp(r'/(Users|home)/[^/\s]+/');
  for (final file in publicFiles) {
    final text = File(file).readAsStringSync();
    if (localPathPattern.hasMatch(text)) {
      failures.add('public text file contains a local absolute path: $file');
    }
  }
}
