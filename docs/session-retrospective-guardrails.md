# Session-Derived Guardrails

This repository keeps only distilled operating rules from prior sessions. Raw
session logs, local comparison images, temporary screenshots, and private runtime
state must stay outside the repository.

## Branch and CI

- This repository uses a protected `main` flow. Start from latest `origin/main`,
  create a feature branch, push the branch, and open a PR.
- PR titles and summaries should be written in Japanese for this repository.
- Verify `ci-gate` before reporting completion. Use `gh pr checks` or
  `gh run view --json` instead of an untracked background watcher.

## UI Regression Handling

- When a layout regression recurs, first identify the missing contract that let
  the previous fix pass.
- Add or strengthen a non-golden widget/source contract test for the failed
  state. Golden updates are useful visual evidence, but they are not the primary
  CI guard for layout regressions in this repository.
- Keep unrelated golden baseline changes out of the fix unless they are
  explicitly inspected and explained.

## Resume Content

- `content/resume/*.yaml` is the content source of truth.
- Generated Dart must be refreshed through `tool/generate_resume_content.dart`.
- Portfolio project descriptions must preserve their intended scope. In
  particular, `specification` and `design-blueprint` describe cross-repository
  project infrastructure.

## Setup and Secrets

- Verify required skills and setup from actual files or commands before assuming
  they are available.
- Never print secret values. It is enough to report whether a required secret is
  present.
