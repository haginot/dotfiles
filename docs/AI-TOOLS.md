# 🤖 AI Development Tools Guide

> Claude Code、Cursor、OpenAI Codex CLIの最適な設定とベストプラクティス

## 目次

- [概要](#概要)
- [Claude Code](#claude-code)
- [Cursor](#cursor)
- [OpenAI Codex CLI](#openai-codex-cli)
- [共通ベストプラクティス](#共通ベストプラクティス)
- [ワークフロー](#ワークフロー)

---

## 概要

### ツール比較

| ツール | 開発元 | モデル | 特徴 |
|--------|--------|--------|------|
| **Claude Code** | Anthropic | Claude 4 | ターミナルネイティブ、エージェント機能 |
| **Cursor** | Cursor Inc | 複数対応 | VS Code fork、IDE統合 |
| **Codex CLI** | OpenAI | GPT-5 | サンドボックス、承認フロー |

### 設定ファイルの場所

| ツール | グローバル設定 | プロジェクト設定 |
|--------|----------------|------------------|
| Claude Code | `~/.claude/settings.json` | `.claude/settings.json` |
| Cursor | `~/Library/Application Support/Cursor/User/settings.json` | `.cursor/rules/*.mdc` |
| Codex CLI | `~/.codex/config.toml` | `.codex/config.toml` |

---

## Claude Code

### 設定ファイル

#### ~/.claude/settings.json

```json
{
  "permissions": {
    "allow": [
      "Read",
      "Write",
      "Edit",
      "Bash(git *)",
      "Bash(npm *)",
      "Bash(make *)"
    ],
    "deny": [
      "Read(.env)",
      "Read(**/.env.*)",
      "Read(**/*secret*)",
      "Bash(rm -rf /)",
      "Bash(sudo *)"
    ]
  }
}
```

**重要な設定:**

| 設定 | 説明 | 推奨値 |
|------|------|--------|
| `permissions.allow` | 許可するツール | 開発に必要なコマンドを明示的に許可 |
| `permissions.deny` | 禁止するアクセス | 機密ファイル、危険なコマンドを禁止 |
| `model.default` | デフォルトモデル | `claude-sonnet-4-20250514` |

#### CLAUDE.md

プロジェクトルートまたは `~/.claude/CLAUDE.md` に配置:

```markdown
# Project Instructions

## Code Style
- Use TypeScript
- Follow ESLint rules
- Write tests for new features

## Commands
- `make dev` - Start development server
- `make test` - Run tests
```

**効果的なCLAUDE.mdの書き方:**

1. **具体的に**: 「良いコードを書け」より「TypeScriptを使い、ESLint規則に従え」
2. **強調**: 重要な指示には「IMPORTANT」「YOU MUST」を使用
3. **例示**: コードスタイルは具体例を示す
4. **更新**: 定期的に見直し、不要な指示を削除

### カスタムコマンド

`.claude/commands/` にMarkdownファイルを配置:

```
.claude/commands/
├── review.md      # /review でコードレビュー
├── test.md        # /test でテスト作成
├── refactor.md    # /refactor でリファクタリング
└── debug.md       # /debug でデバッグ支援
```

コマンド内で `$ARGUMENTS` を使用してパラメータを受け取る。

### ベストプラクティス

1. **Explore → Plan → Code → Commit**
   ```
   1. 関連ファイルを読む（まだコーディングしない）
   2. 計画を立てる（"think"で深い推論を促す）
   3. 実装
   4. テスト & コミット
   ```

2. **Visual Iteration**: スクリーンショットを提供し、2-3回イテレーション

3. **MCP統合**: `.mcp.json`をリポジトリにコミットしてチーム共有

**参考リンク:**
- [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)
- [Claude Code Settings](https://code.claude.com/docs/en/settings)

---

## Cursor

### 設定ファイル

#### settings.json

```json
{
  "editor.fontFamily": "JetBrainsMono Nerd Font",
  "editor.fontSize": 14,
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "cursor.cpp.enablePartialAccepts": true,
  "cursor.general.enableShadowWorkspace": true
}
```

**重要な設定:**

| 設定 | 説明 | 推奨値 |
|------|------|--------|
| `cursor.cpp.enablePartialAccepts` | 部分的なコード補完を許可 | `true` |
| `cursor.general.enableShadowWorkspace` | シャドウワークスペース | `true` |
| `editor.formatOnSave` | 保存時フォーマット | `true` |

### ルールファイル

#### .cursor/rules/*.mdc

```markdown
---
description: TypeScript project rules
globs: ["**/*.ts", "**/*.tsx"]
---

# TypeScript Rules

- Use strict TypeScript
- Prefer interfaces over types
- Use async/await over promises
```

**ルールの階層:**

1. **User Rules**: グローバル設定（全プロジェクトに適用）
2. **Project Rules**: `.cursor/rules/*.mdc`（バージョン管理）
3. **Legacy .cursorrules**: 後方互換（非推奨）

### environment.json

クラウド環境設定（チームで共有）:

```json
{
  "image": "node:20",
  "commands": {
    "install": "npm install",
    "dev": "npm run dev"
  }
}
```

### ベストプラクティス

1. **プロジェクト別ルール**: フレームワーク/言語ごとに `.mdc` ファイルを作成

2. **JSON Schema for Hooks**: IntelliSenseを有効化
   ```json
   "json.schemas": [{
     "fileMatch": [".cursor/**/hooks.json"],
     "url": "https://cursor.com/schemas/hooks.json"
   }]
   ```

3. **設定の同期**: dotfilesでシンボリックリンク管理

**参考リンク:**
- [Cursor Docs](https://cursor.com/docs)
- [awesome-cursorrules](https://github.com/PatrickJS/awesome-cursorrules)

---

## OpenAI Codex CLI

### 設定ファイル

#### ~/.codex/config.toml

```toml
# モデル設定
model = "gpt-5-codex"
model_reasoning_effort = "medium"

# セキュリティ
sandbox_mode = "workspace-write"
approval_policy = "on-request"

# 機能
[features]
shell_tool = true
web_search_request = true
```

**重要な設定:**

| 設定 | 説明 | 推奨値 |
|------|------|--------|
| `sandbox_mode` | サンドボックスレベル | `workspace-write` |
| `approval_policy` | 承認ポリシー | `on-request` |
| `model_reasoning_effort` | 推論の深さ | `medium` |

### 承認ポリシー

| ポリシー | 説明 | 用途 |
|----------|------|------|
| `untrusted` | すべてのアクションを確認 | 初めてのプロジェクト |
| `on-failure` | 失敗時のみ確認 | 開発作業 |
| `on-request` | モデルが要求時に確認 | 日常作業（推奨） |
| `never` | 確認なし | CI/CD（危険） |

### プロファイル

用途別のプロファイルを定義:

```toml
[profiles.dev]
approval_policy = "on-failure"
model_reasoning_effort = "high"

[profiles.ci]
approval_policy = "never"
sandbox_mode = "danger-full-access"

[profiles.review]
sandbox_mode = "read-only"
model_reasoning_effort = "xhigh"
```

使用: `codex --profile dev`

### カスタムスラッシュコマンド

Codex CLIは `~/.codex/prompts/*.md` を `/コマンド名` として読み込みます。

例:
- `~/.codex/prompts/commit.md` → `/commit`
- `~/.codex/prompts/review.md` → `/review`
- `~/.codex/prompts/pr.md` → `/pr`

各ファイルは先頭にYAML frontmatterを持たせます。

```markdown
---
description: Short command description
---

Prompt body...
Use $ARGUMENTS for user-supplied arguments.
```

### MCP統合

```toml
[mcp_servers.github]
command = "npx"
args = ["-y", "@anthropic-ai/mcp-server-github"]
env = { GITHUB_TOKEN = "${GITHUB_TOKEN}" }
```

### ベストプラクティス

1. **開発時**: `--profile dev` で効率優先
2. **レビュー時**: `--profile review` で慎重に
3. **CI時のみ**: `--dangerously-bypass-approvals-and-sandbox`

### Codexへの指示テンプレート（推奨）

公式ガイドに合わせ、以下の順で依頼すると精度が安定します。

1. **Goal**: 目的を1文で明示
2. **Scope**: 変更対象ファイルと対象外を明示
3. **Constraints**: 安全性・互換性・スタイル制約を明示
4. **Acceptance Criteria**: 完了条件をテスト可能な形で列挙
5. **Validation**: 実行してほしい検証コマンドを指定

依頼例:

```text
Goal:
- Brewfileに新しいCLIツールを追加し、セットアップフローに反映する。

Scope:
- Brewfile
- docs/TOOLS.md
- setup.sh（必要なら）

Constraints:
- 既存のカテゴリ順を維持
- 既存環境を壊さない（idempotent）

Acceptance Criteria:
- `brew bundle check` が通る
- 追加したツールが docs/TOOLS.md に用途付きで記載される

Validation:
- make doctor
```

補足:
- 大きな要求は1時間程度で終わる単位に分割すると成功率が上がる。
- 継続的に守るルールはリポジトリ直下の `AGENTS.md` に記述して永続化する。

**参考リンク:**
- [Codex CLI Documentation](https://developers.openai.com/codex/cli/)
- [Configuration Reference](https://developers.openai.com/codex/config-reference/)
- [Codex Prompting Guide](https://developers.openai.com/cookbook/examples/gpt-5/codex_prompting_guide)
- [Using AGENTS.md](https://developers.openai.com/codex/guides/agents-md)

---

## 共通ベストプラクティス

### セキュリティ

```
✓ 機密ファイルへのアクセスを禁止
  - .env, .env.*, secrets.*, *.pem, *.key

✓ 危険なコマンドを禁止
  - rm -rf /, sudo *, curl | bash

✓ APIキーをコミットしない
  - .gitignore に含める
```

### 効果的なプロンプト

```
❌ 悪い例: "テストを書いて"
✓ 良い例: "foo.py のログアウト時のエッジケースをカバーするテストを書いて"

❌ 悪い例: "コードを改善して"
✓ 良い例: "この関数をリファクタリングして、純粋関数に分割して"
```

### コンテキスト管理

1. **ファイル参照**: Tab補完で具体的なファイルを指定
2. **URL共有**: ドキュメントURLを直接渡す
3. **スクリーンショット**: デザインの実装時に画像を提供
4. **計画確認**: 複雑なタスクは計画を立ててから実装

---

## ワークフロー

### 日常開発

```bash
# Claude Code
claude
> Read src/api/users.ts and explain the authentication flow
> Implement a new endpoint for password reset
> Write tests for the password reset endpoint

# Cursor
# IDE内でCmd+K → 指示を入力

# Codex
codex "Add error handling to the API endpoints"
```

### コードレビュー

```bash
# Claude Code
claude
> /review PR #123
> Check for security vulnerabilities in the changes

# Codex (read-only profile)
codex --profile review "Review the changes in the last commit"
```

### デバッグ

```bash
# Claude Code
claude
> /debug TypeError: Cannot read property 'id' of undefined
> Check the user authentication middleware

# Cursor
# エラーを選択 → Cmd+K → "Fix this error"
```

### リファクタリング

```bash
# Claude Code
claude
> /refactor src/utils/helpers.ts
> Extract the validation logic into a separate module

# Cursor
# コードを選択 → Cmd+K → "Refactor to use hooks"
```

---

## 設定ファイルの同期

dotfilesでの管理:

```
dotfiles/
└── config/
    ├── claude/
    │   ├── settings.json
    │   ├── CLAUDE.md
    │   └── commands/
    ├── cursor/
    │   ├── settings.json
    │   └── rules/
    └── codex/
        ├── config.toml
        ├── instructions.md
        └── prompts/
            ├── commit.md
            ├── review.md
            └── pr.md
```

シンボリックリンク:
```bash
ln -sf ~/dotfiles/config/claude ~/.claude
ln -sf ~/dotfiles/config/codex ~/.codex
```

---

## 関連ドキュメント

- [CLIツールガイド](./TOOLS.md)
- [アプリケーションガイド](./APPS.md)
- [シェル設定ガイド](./SHELL.md)
- [カスタマイズガイド](./CUSTOMIZATION.md)
