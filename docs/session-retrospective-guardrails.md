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

## Session Inventory

These durable rules were distilled from session summaries and repository state,
not from raw session logs. Keep the original logs, local paths, screenshots, and
private runtime state out of git.

- Flutter Web planning: keep this as a separate Flutter Web portfolio, use the
  existing GitHub Pages/WASM direction, and remove unresolved Open Questions
  from handoff plans before implementation.
- Skill and setup checks: verify required Codex-visible skills and
  `setup.sh --check` from actual files or command output. Context7 credentials
  must be reported as present or absent only.
- Publication hardening: before public or security-sensitive changes, inspect
  local files, git history, GitHub settings, Actions, Pages, and leak scans from
  primary evidence.
- Protected workflow: after the default-branch ruleset was enabled, repository
  code changes must use a feature branch, Japanese PR title/summary, and
  `ci-gate` verification.
- Deployment maintenance: deploy from the latest `main`, not a stale checkout or
  feature branch, and clean merged branches only after confirming merge state.
- Resume content: edit `content/resume/*.yaml`, regenerate Dart output, and keep
  generated files out of manual-edit workflows.
- UI and golden regressions: reproduce recurring layout issues with
  non-golden contract tests first, then use goldens as scoped visual evidence.
- Repository boundary: keep `resume-flutter`-specific guardrails in this repo.
  Promote only cross-repository guidance to user-level Codex dotfiles.
