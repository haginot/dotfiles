# 🛠️ CLI Tools Guide

> このドキュメントでは、Brewfileでインストールされる全CLIツールの役割と選定理由を説明します。

## 目次

- [Core CLI Tools](#core-cli-tools)
- [Shell & Terminal](#shell--terminal)
- [Version Control](#version-control)
- [Runtime Management](#runtime-management)
- [Languages & Package Managers](#languages--package-managers)
- [Cloud & Infrastructure](#cloud--infrastructure)
- [Database](#database)
- [AI & ML Tools](#ai--ml-tools)
- [Data Processing & Media](#data-processing--media)
- [Development Tools](#development-tools)
- [Networking & Security](#networking--security)
- [Utilities](#utilities)

---

## Core CLI Tools

### GNU Coreutils

| Tool | 説明 | 選定理由 |
|------|------|----------|
| `coreutils` | GNU版の基本コマンド（ls, cat, cp等） | macOSのBSD版より機能が豊富。`--color`オプションなどLinuxと同じ使用感を実現 |
| `moreutils` | 追加UNIXユーティリティ | `sponge`（パイプ出力を同一ファイルに書き込み）、`parallel`など便利ツール集 |
| `findutils` | GNU find, xargs | macOS版より高機能。`-print0`などの安全なオプションが使いやすい |
| `gnu-sed` | GNU sed | macOSのsedは`-i`オプションの挙動が異なる。GNU版で一貫性確保 |
| `gnu-tar` | GNU tar | 圧縮形式の自動判別など、より使いやすいオプション |
| `gawk` | GNU awk | 拡張正規表現やネットワーク機能などmacOS版にない機能 |
| `grep` | GNU grep | `--color`、`-P`（Perl正規表現）など拡張機能 |

### モダン代替ツール

| Tool | 代替対象 | 説明 | 選定理由 |
|------|----------|------|----------|
| `ripgrep` (rg) | grep | 超高速なテキスト検索 | gitignore自動対応、マルチスレッド、10-100倍高速 |
| `fd` | find | モダンなファイル検索 | 直感的な構文、gitignore対応、カラー出力 |
| `sd` | sed | モダンな置換ツール | 正規表現がシンプル、プレビュー機能 |
| `eza` | ls | モダンなls | アイコン表示、Git状態表示、ツリー表示 |
| `bat` | cat | シンタックスハイライト付きcat | 行番号、Git差分表示、ページャー統合 |
| `fzf` | - | ファジーファインダー | インタラクティブな絞り込み、シェル統合 |
| `zoxide` | cd | スマートなcd | 使用頻度を学習して最適なディレクトリにジャンプ |

### その他基本ツール

| Tool | 説明 | 選定理由 |
|------|------|----------|
| `tree` | ディレクトリツリー表示 | プロジェクト構造の可視化に必須 |
| `wget` | ファイルダウンローダー | 再帰ダウンロード、レジューム対応 |
| `curl` | HTTPクライアント | API開発・テストの定番ツール |
| `htop` | プロセスビューア | topより見やすく、操作しやすい |
| `jq` | JSONプロセッサ | APIレスポンスの整形・加工に必須 |
| `yq` | YAMLプロセッサ | Kubernetes/Docker設定の編集に便利 |

---

## Shell & Terminal

| Tool | 説明 | 選定理由 |
|------|------|----------|
| `zsh` | Zshシェル | macOSデフォルト。Bashより高機能な補完・履歴機能 |
| `zsh-autosuggestions` | コマンド自動補完 | 履歴からリアルタイムでコマンド候補を表示 |
| `zsh-syntax-highlighting` | シンタックスハイライト | コマンドの構文エラーを入力時に視覚化 |
| `zsh-completions` | 追加補完定義 | 多数のコマンドに対する補完ルール集 |
| `starship` | プロンプト | 高速・カスタマイズ性が高い。Git/言語/クラウド状態を表示 |
| `tmux` | ターミナルマルチプレクサ | セッション管理、画面分割、リモート作業時の継続性確保 |
| `direnv` | ディレクトリ別環境変数 | プロジェクトごとの環境変数を自動切り替え |

### なぜStarshipか？

```
選択肢: Starship vs Powerlevel10k vs Pure vs Oh My Zsh

Starship:
  ✓ Rust製で高速（起動時間 < 10ms）
  ✓ クロスシェル（zsh, bash, fish対応）
  ✓ TOML設定で可読性が高い
  ✓ プリセット豊富

Powerlevel10k:
  ✓ 超高速（インスタントプロンプト）
  ✗ zsh専用
  ✗ 設定が複雑

→ Starshipを採用：速度と設定のシンプルさのバランスが最良
```

---

## Version Control

| Tool | 説明 | 選定理由 |
|------|------|----------|
| `git` | バージョン管理 | 言わずもがな必須ツール |
| `git-lfs` | 大容量ファイル管理 | バイナリ、画像、動画をGitで効率的に管理 |
| `git-delta` | 差分ビューア | シンタックスハイライト、行内差分表示 |
| `gh` | GitHub CLI | PR作成、Issue管理、Actions操作をターミナルから |
| `lazygit` | Git TUI | ステージング、コミット、リベースをインタラクティブに |
| `bfg` | Git履歴クリーナー | 誤コミットした機密情報の完全削除 |

### なぜgit-deltaか？

```
選択肢: delta vs diff-so-fancy vs difftastic

delta:
  ✓ Rust製で高速
  ✓ シンタックスハイライト
  ✓ 行内差分（単語レベル）
  ✓ サイドバイサイド表示
  ✓ git blame統合

diff-so-fancy:
  ✓ シンプル
  ✗ シンタックスハイライトなし

→ deltaを採用：機能と見やすさが最も優れている
```

---

## Runtime Management

| Tool | 説明 | 選定理由 |
|------|------|----------|
| `mise` | ポリグロットランタイムマネージャ | Python, Node.js, Go, Rust等を統一管理 |

### なぜmiseか？

```
選択肢: mise vs asdf vs 個別ツール（pyenv, nodenv, etc.）

mise:
  ✓ Rust製で高速（asdfの10倍以上）
  ✓ asdf互換（既存の.tool-versionsをそのまま使用可能）
  ✓ 単一バイナリ（依存関係なし）
  ✓ 並列インストール
  ✓ タスクランナー機能内蔵
  ✓ direnv統合

asdf:
  ✓ プラグインが豊富
  ✗ Bash製で遅い
  ✗ シェル初期化に時間がかかる

個別ツール:
  ✗ 管理が煩雑
  ✗ 設定ファイルが分散

→ miseを採用：速度、機能、使いやすさすべてで優位
```

---

## Languages & Package Managers

| Tool | 説明 | 選定理由 |
|------|------|----------|
| `node` | Node.js | JavaScript/TypeScript実行環境 |
| `yarn` | パッケージマネージャ | npmより高速、ワークスペース機能 |
| `uv` | Pythonパッケージマネージャ | pip/pipxの10-100倍高速 |
| `poetry` | Python依存関係管理 | pyproject.toml、仮想環境自動管理 |
| `openjdk` | Java | JVM言語の実行環境 |
| `jbang` | Javaスクリプト実行 | 単一ファイルJavaの即時実行 |

### なぜuvか？

```
選択肢: uv vs pip vs pipx vs poetry

uv:
  ✓ Rust製で超高速（pipの10-100倍）
  ✓ pip互換コマンド
  ✓ 仮想環境管理
  ✓ プロジェクト管理（pyproject.toml）
  ✓ Pythonバージョン管理

→ uvを採用：速度が圧倒的。poetryと併用で完璧
```

---

## Cloud & Infrastructure

| Tool | 説明 | 選定理由 |
|------|------|----------|
| `awscli` | AWS CLI | AWSリソースの管理に必須 |
| `terraform` | Infrastructure as Code | マルチクラウド対応のIaCツール |
| `railway` | Railway CLI | モダンなPaaS。Herokuの代替 |
| `render` | Render CLI | シンプルなクラウドプラットフォーム |
| `aws-nuke` | AWSリソース一括削除 | 開発環境のクリーンアップに便利 |

---

## Database

| Tool | 説明 | 選定理由 |
|------|------|----------|
| `mysql@8.0` | MySQL | 最も普及したRDBMS |
| `postgresql@14` | PostgreSQL | 高度な機能を持つオープンソースRDBMS |

---

## AI & ML Tools

| Tool | 説明 | 選定理由 |
|------|------|----------|
| `claude-squad` | Claude管理ツール | 複数Claude Codeインスタンスの管理 |
| `gemini-cli` | Gemini CLI | Google AIとのターミナル対話 |

---

## Data Processing & Media

| Tool | 説明 | 選定理由 |
|------|------|----------|
| `ffmpeg` | メディア処理 | 動画/音声の変換、編集、ストリーミング |
| `imagemagick` | 画像処理 | 画像の変換、リサイズ、加工 |
| `graphicsmagick` | 画像処理 | ImageMagickより高速な代替 |
| `graphviz` | グラフ描画 | DOT言語でダイアグラム生成 |
| `pandoc` | ドキュメント変換 | Markdown→PDF/DOCX/HTML等 |
| `poppler` | PDF処理 | PDF→テキスト/画像抽出 |
| `tesseract` | OCR | 画像からテキスト抽出 |
| `tesseract-lang` | OCR言語パック | 日本語含む多言語対応 |
| `nkf` | 文字コード変換 | 日本語エンコーディング処理 |

---

## Development Tools

| Tool | 説明 | 選定理由 |
|------|------|----------|
| `act` | ローカルGitHub Actions | CIをローカルでテスト |
| `just` | コマンドランナー | Makefileよりシンプルな構文 |
| `watchexec` | ファイル監視 | ファイル変更時にコマンド自動実行 |
| `hyperfine` | ベンチマークツール | コマンドの実行時間を統計的に計測 |
| `tokei` | コード統計 | 言語別のコード行数カウント |
| `shellcheck` | シェルスクリプトリンター | Bashスクリプトの静的解析 |

### なぜjustか？

```
選択肢: just vs make vs task vs npm scripts

just:
  ✓ シンプルで直感的な構文
  ✓ クロスプラットフォーム
  ✓ 引数、変数、条件分岐サポート
  ✓ レシピの依存関係
  ✓ コメントがヘルプになる

make:
  ✓ どこでも使える
  ✗ 構文が古い（タブ必須等）
  ✗ ファイルベースの依存関係前提

→ justを採用：モダンなタスクランナーとして最適
```

---

## Networking & Security

| Tool | 説明 | 選定理由 |
|------|------|----------|
| `openssh` | SSHクライアント/サーバー | リモート接続の基本 |
| `gnupg` | 暗号化ツール | ファイル暗号化、Git署名 |
| `pinentry-mac` | GPGピン入力 | macOSでのGPGパスフレーズ入力UI |
| `mtr` | ネットワーク診断 | traceroute + ping の組み合わせ |
| `nmap` | ポートスキャナ | ネットワーク調査・セキュリティ監査 |
| `inetutils` | ネットワークユーティリティ | ftp, telnet, ping等 |

---

## Utilities

| Tool | 説明 | 選定理由 |
|------|------|----------|
| `mas` | Mac App Store CLI | App Storeアプリをコマンドラインからインストール |
| `blueutil` | Bluetooth CLI | Bluetoothのオン/オフ、デバイス管理 |
| `sleepwatcher` | スリープ監視 | スリープ/復帰時にスクリプト実行 |
| `duti` | デフォルトアプリ管理 | ファイルタイプごとのデフォルトアプリ設定 |
| `switchaudio-osx` | オーディオ切替 | 音声出力デバイスをCLIで切り替え |
| `trash` | 安全な削除 | rmの代わりにゴミ箱に移動 |

---

## ツール選定の原則

1. **速度優先**: Rust/Go製のモダンツールを優先（ripgrep, fd, bat, eza, delta, mise, uv）

2. **Unix哲学**: 一つのことを上手くやるツールを組み合わせる

3. **互換性**: 既存のワークフローを壊さない（GNU coreutils）

4. **保守性**: アクティブにメンテナンスされているプロジェクト

5. **学習曲線**: 直感的に使えるもの、ドキュメントが充実しているもの

---

## 関連ドキュメント

- [アプリケーションガイド](./APPS.md)
- [シェル設定ガイド](./SHELL.md)
- [macOS設定ガイド](./MACOS.md)
- [カスタマイズガイド](./CUSTOMIZATION.md)
