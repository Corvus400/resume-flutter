# Security Policy

このリポジトリは静的配信の Flutter Web ポートフォリオ履歴書です。

脆弱性の疑いがある内容は、このリポジトリの GitHub Security Advisories から非公開で報告してください。非公開で扱うべき詳細を public Issue、Pull Request、コメント、ログ、スクリーンショットに投稿しないでください。

報告には、不要な秘密情報、認証情報、アクセストークン、private URL、ローカルマシンの絶対パス、個人メールアドレス、非公開の個人情報を含めないでください。

## Scope

対象:

- Flutter Web アプリケーション
- GitHub Pages deploy workflow
- GitHub Actions / dependency update configuration
- `content/resume/` から生成される公開履歴書コンテンツ

対象外:

- 一般的なサポート依頼
- 表示文言の改善提案
- 外部サービスや GitHub 自体の脆弱性

## Repository Operation

このリポジトリはポートフォリオ用途です。外部 PR、一般的なサポート依頼、機能要望、通常のバグ報告は受け付けません。

Issue は、依存更新や公開リポジトリ運用上の衛生報告のために限定的に有効化しています。公開 Issue では、秘密情報、認証情報、アクセストークン、private URL、ローカルマシンの絶対パス、個人メールアドレス、非公開の個人情報、脆弱性の詳細を扱いません。

依存更新とセキュリティ通知のために Dependabot / Renovate / GitHub Security 機能を利用します。GitHub Actions と workflow 依存の更新は、selected actions と SHA pinning を維持したまま確認します。
