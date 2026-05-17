# resume-flutter Instructions

## Branch and PR Workflow

- Do not commit or push directly to `main` in this repository.
- Start implementation work from the latest `origin/main`, then create a feature branch.
- Use a Japanese PR title and summary when opening pull requests for this repository.
- After opening or updating a PR, verify the required `ci-gate` check before reporting completion.
- Use `gh pr checks` or `gh run view --json` for CI polling. Do not rely on untracked background watchers.

## Resume Content Source of Truth

- Treat `content/resume/*.yaml` as the source of truth for resume content.
- Do not edit generated resume Dart by hand.
- After changing resume YAML, run `dart run tool/generate_resume_content.dart` and verify with `dart run tool/generate_resume_content.dart --check`.
- Keep public project descriptions source-backed. `specification` and `design-blueprint` are cross-repository projects, not single-repository implementation details.

## UI and Golden Discipline

- UI regressions must be fixed with a contract test that reproduces the failed state before or alongside the production change.
- Do not claim a UI fix is complete from golden updates alone. Prefer non-golden widget/source contract tests for layout regressions that CI can run reliably.
- Scope golden updates to the affected screen only. If an unrelated golden baseline changes, treat it as a separate finding and explain it before including it.
- For repeated layout regressions, inspect the current implementation, reproduce the failing state, and add a guard that would have caught the previous miss.

## Repository Hygiene

- Do not commit raw Codex session logs, local screenshots, temporary comparison artifacts, auth files, caches, or generated runtime state.
- Do not write secret values into files, logs, PR bodies, or chat. Report only whether a required secret is present.
- Keep repo-specific permanent guardrails in this repository first: `AGENTS.md`, `.codex/hooks.json`, tests, and deterministic verification tools.
- Escalate only general, cross-repository lessons to user-level Codex dotfiles.
