# 📚 Dotfiles Documentation

> dotfilesの完全なドキュメント索引

## ドキュメント一覧

### 🤖 [AI Tools Guide](./AI-TOOLS.md)

AI開発ツール（Claude Code、Cursor、Codex CLI）の設定とベストプラクティス

- Claude Code settings.json & CLAUDE.md
- Cursor settings.json & .cursorrules
- OpenAI Codex CLI config.toml
- 共通ベストプラクティス
- ワークフロー例

### 🛠️ [CLI Tools Guide](./TOOLS.md)

Homebrewでインストールされる全CLIツールの解説

- Core CLI Tools (coreutils, ripgrep, fd, bat, eza, fzf, zoxide)
- Shell & Terminal (zsh, starship, tmux, direnv)
- Version Control (git, gh, lazygit, delta)
- Runtime Management (mise)
- Languages & Package Managers
- Cloud & Infrastructure
- Development Tools
- Networking & Security
- Utilities

### 📱 [Applications Guide](./APPS.md)

GUIアプリケーションとMac App Storeアプリの解説

- Development (Cursor, VS Code, Docker, OrbStack)
- Terminal (Ghostty, Warp)
- Productivity (Alfred, Raycast, Karabiner)
- Communication (Slack, Discord, Zoom)
- Browsers (Chrome, Firefox, Arc)
- Mac App Store apps
- VS Code Extensions

### 🐚 [Shell Configuration Guide](./SHELL.md)

Zshシェル設定の詳細解説

- File structure and loading order
- Environment variables (XDG compliance)
- PATH configuration
- Aliases (100+ defined)
- Functions (30+ defined)
- Plugins (autosuggestions, syntax-highlighting)
- Starship prompt
- Key bindings
- Performance optimization

### 🍎 [macOS Settings Guide](./MACOS.md)

macOS設定スクリプトの詳細解説

- General UI/UX
- Trackpad & Mouse (tap-to-click, three-finger drag)
- Keyboard (fast key repeat)
- Dock (position, auto-hide, hot corners)
- Finder (show extensions, path bar)
- Safari (developer tools, privacy)
- Screenshots
- Security settings

### 🎨 [Customization Guide](./CUSTOMIZATION.md)

dotfilesのカスタマイズ方法

- Local settings (~/.zshrc.local)
- Brewfile customization
- Shell customization
- Git configuration (multiple accounts)
- Starship prompt customization
- Adding new configurations
- Fork workflow
- Best practices

---

## クイックリファレンス

### コマンド

| コマンド | 説明 |
|----------|------|
| `make install` | フルインストール |
| `make link` | シンボリックリンク作成 |
| `make brew` | パッケージインストール |
| `make macos` | macOS設定適用 |
| `make update` | 全パッケージ更新 |
| `make doctor` | ヘルスチェック |
| `make help` | ヘルプ表示 |

### 主要エイリアス

| エイリアス | コマンド |
|------------|----------|
| `ll` | `eza -la --icons --git` |
| `gs` | `git status -sb` |
| `lg` | `lazygit` |
| `dc` | `docker compose` |
| `..` | `cd ..` |

### 主要関数

| 関数 | 説明 |
|------|------|
| `mkcd dir` | ディレクトリ作成＆移動 |
| `extract file` | アーカイブ展開 |
| `fe` | fzfでファイル検索＆編集 |
| `fcd` | fzfでディレクトリ検索＆移動 |
| `serve [port]` | HTTPサーバー起動 |

---

## 設計思想

### 1. モダンツール優先

従来のUnixコマンドをRust/Go製の高速な代替ツールに置き換え：

```
ls    → eza
cat   → bat
find  → fd
grep  → ripgrep
cd    → zoxide
rm    → trash
```

### 2. XDG Base Directory準拠

ホームディレクトリを整理：

```
~/.config/    ← 設定ファイル
~/.local/share ← データ
~/.local/state ← 状態（履歴等）
~/.cache/     ← キャッシュ
```

### 3. 冪等性

何度実行しても同じ結果になる設計：

```bash
./setup.sh  # 初回インストール
./setup.sh  # 2回目以降も安全
```

### 4. モジュラー設計

関心ごとにファイルを分離：

```
shell/
├── zshenv      ← 環境変数
├── zshrc       ← メイン設定
├── aliases.zsh ← エイリアス
├── functions.zsh ← 関数
└── path.zsh    ← PATH設定
```

### 5. ローカルカスタマイズ

マシン固有の設定は `.local` ファイルで分離：

```bash
~/.zshrc.local  # gitで管理しない
```

---

## ファイル構成

```
dotfiles/
├── bin/                    # カスタムスクリプト
├── config/                 # アプリケーション設定
│   ├── git/
│   ├── ghostty/
│   ├── karabiner/
│   ├── mise/
│   └── starship/
├── docs/                   # ドキュメント ★
│   ├── INDEX.md           # このファイル
│   ├── TOOLS.md           # CLIツールガイド
│   ├── APPS.md            # アプリケーションガイド
│   ├── SHELL.md           # シェル設定ガイド
│   ├── MACOS.md           # macOS設定ガイド
│   └── CUSTOMIZATION.md   # カスタマイズガイド
├── macos/
│   └── defaults.sh
├── shell/
│   ├── zshenv
│   ├── zshrc
│   ├── aliases.zsh
│   ├── functions.zsh
│   └── path.zsh
├── Brewfile
├── Makefile
├── README.md
└── setup.sh
```

---

## サポート

- 🐛 Issue: [GitHub Issues](https://github.com/YOUR_USERNAME/dotfiles/issues)
- 📝 PR: [Pull Requests](https://github.com/YOUR_USERNAME/dotfiles/pulls)
