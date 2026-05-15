# Resume Flutter Requirements

## Scope

- Platform: Flutter Web only.
- Deployment target: GitHub Pages under `/resume-flutter/`.
- URL strategy: Hash strategy. Do not call `usePathUrlStrategy`.
- Renderer: WASM release build with CanvasKit fallback.
- Locale: Japanese only for the initial version.
- Data source: Dart `const` data, derived from the sibling `resume` repository README.
- No API, persistence, authentication, camera, location, notifications, photos, or contacts.

## Screens

1. Hero
2. Work experience list
3. Work experience detail
4. Personal project list
5. Outside activities
6. Skills

## Theme Constraints For Claude Design

- Seed color candidates: deep green and ink neutral.
- Typography family hint: Noto Sans JP.
- Responsive breakpoint: 600 px.
- Claude Design owns concrete color, typography, and spacing tokens.
- Flutter mirrors concrete tokens only after the design-blueprint HTML is committed.

## Accessibility And Tests

- Minimum contrast should satisfy WCAG AA for body text.
- Layout must support browser text scaling and keyboard navigation.
- Widget tests are required before UI implementation expands.
- Golden tests use the current host as the single generation host.
- Golden update command: `flutter test --update-goldens`.
