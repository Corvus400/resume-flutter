import json
import os
import subprocess
import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
HOOK = ROOT / ".codex" / "hooks" / "resume_flutter_guard.py"


def run_hook(event: str, payload: dict[str, object], branch: str = "feature/test") -> dict[str, object]:
    env = os.environ.copy()
    env["RESUME_FLUTTER_GUARD_BRANCH"] = branch
    result = subprocess.run(
        [sys.executable, str(HOOK), event],
        input=json.dumps(payload),
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        check=True,
        env=env,
    )
    if not result.stdout.strip():
        return {}
    return json.loads(result.stdout)


class ResumeFlutterGuardTest(unittest.TestCase):
    def test_prompt_warns_for_pr_workflow(self) -> None:
        output = run_hook(
            "user-prompt-submit",
            {"user_prompt": "このリポジトリのrulesetに沿ってPRを作成してください。"},
        )

        self.assertIn("systemMessage", output)
        self.assertIn("feature branch", str(output["systemMessage"]))
        self.assertIn("Japanese PR", str(output["systemMessage"]))
        self.assertIn("ci-gate", str(output["systemMessage"]))

    def test_prompt_warns_for_ui_regression(self) -> None:
        output = run_hook(
            "user-prompt-submit",
            {"user_prompt": "projectsカードがまた縦長に再発しています。goldenも確認してください。"},
        )

        self.assertIn("systemMessage", output)
        self.assertIn("non-golden contract test", str(output["systemMessage"]))
        self.assertIn("unrelated baseline changes", str(output["systemMessage"]))

    def test_denies_direct_main_commit(self) -> None:
        output = run_hook(
            "pre-tool-use-bash",
            {"tool_input": {"command": "git commit -m 'test'"}},
            branch="main",
        )

        hook_output = output["hookSpecificOutput"]
        self.assertEqual(hook_output["permissionDecision"], "deny")
        self.assertIn("protected main workflow", hook_output["permissionDecisionReason"])

    def test_allows_feature_branch_commit(self) -> None:
        output = run_hook(
            "pre-tool-use-bash",
            {"tool_input": {"command": "git commit -m 'test'"}},
            branch="codex/session-guardrails",
        )

        self.assertEqual(output, {})


if __name__ == "__main__":
    unittest.main()
