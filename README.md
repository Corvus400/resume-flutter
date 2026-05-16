# Resume Flutter

Flutter Web portfolio app for a structured resume experience.

## Content Source

Resume content is maintained as structured YAML under `content/resume/`.
The Flutter UI reads typed Dart constants generated from those files.

After editing content, regenerate and verify:

```bash
dart run tool/generate_resume_content.dart
dart run tool/generate_resume_content.dart --check
```

## Development

```bash
flutter pub get
dart run tool/generate_resume_content.dart --check
flutter analyze
flutter test
flutter build web --wasm --release --base-href /resume-flutter/
```

## Design Workflow

Concrete color, typography, and spacing tokens are intentionally deferred to
the design-blueprint HTML produced from Claude Design. See `REQUIREMENTS.md`
for the Phase 3 design input constraints.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
