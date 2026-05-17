#!/usr/bin/env python3
"""Repo-local Codex hook guardrails for resume-flutter."""

from __future__ import annotations

import json
import os
import subprocess
import sys
from typing import Any


def _read_payload() -> dict[str, Any]:
    raw = sys.stdin.read()
    if not raw.strip():
        return {}
    try:
        payload = json.loads(raw)
    except json.JSONDecodeError:
        return {}
    return payload if isinstance(payload, dict) else {}


def _flatten_scalars(value: Any) -> list[str]:
    if isinstance(value, dict):
        values: list[str] = []
        for nested in value.values():
            values.extend(_flatten_scalars(nested))
        return values
    if isinstance(value, list):
        values = []
        for nested in value:
            values.extend(_flatten_scalars(nested))
        return values
    if isinstance(value, (str, int, float, bool)):
        return [str(value)]
    return []


def _payload_text(payload: dict[str, Any]) -> str:
    return " ".join(_flatten_scalars(payload))


def _command_text(payload: dict[str, Any]) -> str:
    tool_input = payload.get("tool_input")
    if isinstance(tool_input, dict):
        for key in ("command", "cmd", "script"):
            value = tool_input.get(key)
            if isinstance(value, str):
                return value
    for key in ("command", "cmd", "script"):
        value = payload.get(key)
        if isinstance(value, str):
            return value
    return _payload_text(payload)


def _system_message(message: str) -> None:
    print(json.dumps({"systemMessage": message}, ensure_ascii=False))


def _deny_pre_tool_use(reason: str) -> None:
    print(
        json.dumps(
            {
                "hookSpecificOutput": {
                    "hookEventName": "PreToolUse",
                    "permissionDecision": "deny",
                    "permissionDecisionReason": reason,
                }
            },
            ensure_ascii=False,
        )
    )


def _current_branch() -> str:
    override = os.environ.get("RESUME_FLUTTER_GUARD_BRANCH")
    if override is not None:
        return override
    result = subprocess.run(
        ["git", "branch", "--show-current"],
        check=False,
        stdout=subprocess.PIPE,
        stderr=subprocess.DEVNULL,
        text=True,
    )
    return result.stdout.strip()


def _contains_any(text: str, needles: tuple[str, ...]) -> bool:
    lower = text.lower()
    return any(needle.lower() in lower for needle in needles)


def _handle_user_prompt(payload: dict[str, Any]) -> None:
    text = _payload_text(payload)
    messages: list[str] = []

    if _contains_any(text, ("pr", "pull request", "プルリク", "push", "commit", "ruleset", "ci-gate")):
        messages.append(
            "resume-flutter workflow: start from latest origin/main, create a feature branch, do not commit or push directly to main, use a Japanese PR title/summary, and verify ci-gate before completion."
        )

    if _contains_any(text, ("ui", "画面", "デザイン", "golden", "projects", "activities", "overlap", "重な", "縦長", "再発")):
        messages.append(
            "resume-flutter UI guardrail: reproduce the affected layout state with a non-golden contract test, scope golden updates to the affected screen, and do not mix unrelated baseline changes without explanation."
        )

    if _contains_any(text, ("context7", "setup.sh", "skill availability", "スキル", "secret", "api_key")):
        messages.append(
            "resume-flutter setup guardrail: verify required skills/setup from evidence and never print secret values; report only presence or absence."
        )

    if messages:
        _system_message("\n".join(messages))


def _handle_bash(payload: dict[str, Any]) -> None:
    command = _command_text(payload)
    branch = _current_branch()
    if branch != "main":
        return

    direct_main_write = (
        "git commit" in command
        or "git push origin main" in command
        or "git push --set-upstream origin main" in command
        or "git push -u origin main" in command
    )
    if direct_main_write:
        _deny_pre_tool_use(
            "resume-flutter has a protected main workflow. Create a feature branch from latest origin/main and use a Japanese PR instead of committing or pushing directly to main."
        )


def main() -> int:
    event = sys.argv[1] if len(sys.argv) > 1 else ""
    payload = _read_payload()
    if event == "user-prompt-submit":
        _handle_user_prompt(payload)
    elif event == "pre-tool-use-bash":
        _handle_bash(payload)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
