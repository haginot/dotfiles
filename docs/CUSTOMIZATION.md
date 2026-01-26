# 🎨 Customization Guide

> このドキュメントでは、dotfilesのカスタマイズ方法を説明します。

## 目次

- [基本的なカスタマイズ](#基本的なカスタマイズ)
- [ローカル設定](#ローカル設定)
- [Brewfileのカスタマイズ](#brewfileのカスタマイズ)
- [シェルのカスタマイズ](#シェルのカスタマイズ)
- [Gitのカスタマイズ](#gitのカスタマイズ)
- [プロンプトのカスタマイズ](#プロンプトのカスタマイズ)
- [ターミナルのカスタマイズ](#ターミナルのカスタマイズ)
- [miseのカスタマイズ](#miseのカスタマイズ)
- [新しい設定の追加](#新しい設定の追加)
- [フォーク運用](#フォーク運用)

---

## 基本的なカスタマイズ

### 設定ファイルの場所

| 設定 | ファイル |
|------|----------|
| シェル環境変数 | `shell/zshenv` |
| シェルメイン | `shell/zshrc` |
| エイリアス | `shell/aliases.zsh` |
| 関数 | `shell/functions.zsh` |
| PATH | `shell/path.zsh` |
| Git | `config/git/config` |
| プロンプト | `config/starship/starship.toml` |
| ターミナル | `config/ghostty/config` |
| ランタイム | `config/mise/config.toml` |
| macOS | `macos/defaults.sh` |
| パッケージ | `Brewfile` |

### 変更後の反映

```bash
# シェル設定の再読み込み
exec zsh
# または
source ~/.zshrc

# シンボリックリンクの再作成
make link

# macOS設定の再適用
make macos
```

---

## ローカル設定

### ~/.zshrc.local

マシン固有の設定はこのファイルに記述します（gitで管理されない）：

```bash
# ~/.zshrc.local

# 仕事用の設定
export WORK_DIR="$HOME/work"
export COMPANY_API_KEY="your-api-key"

# このマシン専用のエイリアス
alias work="cd $WORK_DIR"
alias vpn="open '/Applications/Company VPN.app'"

# プロキシ設定
export HTTP_PROXY="http://proxy.company.com:8080"
export HTTPS_PROXY="$HTTP_PROXY"

# 追加のPATH
path_prepend "$HOME/company-tools/bin"
```

### なぜローカル設定を分けるか

```
利点:
  ✓ 機密情報（APIキー等）をgitにコミットしない
  ✓ マシンごとの差異を吸収
  ✓ 会社固有の設定を分離
  ✓ dotfilesの更新時にコンフリクトしない
```

---

## Brewfileのカスタマイズ

### パッケージの追加

1. 手動でインストール
   ```bash
   brew install new-package
   brew install --cask new-app
   mas install 123456789
   ```

2. Brewfileに反映
   ```bash
   make brew-dump
   ```

3. 差分を確認してコミット
   ```bash
   git diff Brewfile
   git add Brewfile
   git commit -m "Add new-package"
   ```

### パッケージの削除

1. Brewfileから該当行を削除

2. クリーンアップ
   ```bash
   brew bundle cleanup --file=Brewfile
   # 削除されるパッケージを確認

   brew bundle cleanup --file=Brewfile --force
   # 実際に削除
   ```

### カテゴリ分け

```ruby
# ==============================================================================
# My Custom Packages
# ==============================================================================

# ゲーム開発
brew "godot"
cask "unity-hub"
cask "blender"

# 音楽制作
cask "ableton-live-lite"
cask "audacity"
```

### 条件付きインストール

```ruby
# Intel Macのみ
if Hardware::CPU.intel?
  cask "parallels"
end

# Apple Siliconのみ
if Hardware::CPU.arm?
  cask "utm"
end
```

---

## シェルのカスタマイズ

### エイリアスの追加

`shell/aliases.zsh` に追加：

```bash
# カスタムエイリアス
alias myproject='cd ~/projects/my-project && code .'
alias deploy='./scripts/deploy.sh'
alias logs='tail -f /var/log/app.log'
```

### 関数の追加

`shell/functions.zsh` に追加：

```bash
# プロジェクト作成関数
create_project() {
    local name="$1"
    local template="${2:-default}"

    mkdir -p "$HOME/projects/$name"
    cd "$HOME/projects/$name"
    git init

    case "$template" in
        python)
            uv init
            ;;
        node)
            npm init -y
            ;;
        *)
            echo "# $name" > README.md
            ;;
    esac

    echo "Created project: $name"
}
```

### 新しいモジュールの追加

1. `shell/` にファイルを作成
   ```bash
   touch shell/work.zsh
   ```

2. `shell/zshrc` で読み込み
   ```bash
   source_if_exists "$DOTFILES/shell/work.zsh"
   ```

---

## Gitのカスタマイズ

### ユーザー情報の変更

`config/git/config`:

```ini
[user]
    email = your-email@example.com
    name = Your Name
```

### エイリアスの追加

```ini
[alias]
    # カスタムエイリアス
    wip = "!git add -A && git commit -m 'WIP [skip ci]'"
    undo = reset --soft HEAD~1
    graph = log --graph --all --oneline --decorate
```

### コミット署名の有効化

```ini
[user]
    signingkey = YOUR_GPG_KEY_ID

[commit]
    gpgsign = true

[gpg]
    program = gpg
```

### 複数アカウントの使い分け

`~/.config/git/config` にインクルードを追加：

```ini
# メインの設定
[user]
    email = personal@example.com
    name = Personal Name

# 仕事用ディレクトリ
[includeIf "gitdir:~/work/"]
    path = ~/.config/git/config-work
```

`~/.config/git/config-work`:

```ini
[user]
    email = work@company.com
    name = Work Name
```

---

## プロンプトのカスタマイズ

### Starship設定

`config/starship/starship.toml`:

```toml
# フォーマット変更
format = """
$username\
$hostname\
$directory\
$git_branch\
$git_status\
$line_break\
$character"""

# ディレクトリ表示の変更
[directory]
truncation_length = 5
style = "bold blue"

# 言語バージョンの無効化
[python]
disabled = true

[nodejs]
disabled = true

# カスタムモジュール
[custom.docker]
command = "docker ps -q | wc -l | tr -d ' '"
when = "docker ps -q"
format = "[$output containers]($style) "
style = "blue"
```

### プリセットの使用

```bash
# 利用可能なプリセット
starship preset --list

# プリセットを適用
starship preset nerd-font-symbols -o ~/.config/starship.toml
```

---

## ターミナルのカスタマイズ

### Ghostty設定

`config/ghostty/config`:

```ini
# フォント変更
font-family = "Fira Code"
font-size = 13

# テーマ変更
theme = dracula

# 背景透過
background-opacity = 0.95

# カーソルスタイル
cursor-style = underline
cursor-style-blink = true

# カスタムキーバインド
keybind = cmd+shift+t=new_tab
keybind = cmd+w=close_surface
```

### テーマの変更

利用可能なテーマ:
- `catppuccin-mocha` (デフォルト)
- `catppuccin-latte` (ライト)
- `dracula`
- `nord`
- `gruvbox-dark`
- `tokyo-night`

---

## miseのカスタマイズ

### グローバルバージョン

`config/mise/config.toml`:

```toml
[tools]
python = "3.12"
node = "20"
go = "1.22"
rust = "stable"
java = "temurin-21"
ruby = "3.3"
```

### プロジェクト固有バージョン

プロジェクトルートに `.mise.toml`:

```toml
[tools]
python = "3.11"
node = "18"

[env]
DATABASE_URL = "postgres://localhost/myapp"
```

### プラグインの追加

```bash
# 利用可能なプラグインを検索
mise plugins ls-remote

# プラグインをインストール
mise plugins install deno
mise plugins install terraform
```

---

## 新しい設定の追加

### 新しいアプリケーションの設定を追加

1. 設定ファイルを作成
   ```bash
   mkdir -p config/newapp
   touch config/newapp/config.yaml
   ```

2. `setup.sh` にシンボリックリンクを追加
   ```bash
   # setup.shのsetup_symlinks()に追加
   mkdir -p "$XDG_CONFIG_HOME/newapp"
   link_file "$DOTFILES/config/newapp/config.yaml" "$XDG_CONFIG_HOME/newapp/config.yaml"
   ```

3. テスト
   ```bash
   make link
   ls -la ~/.config/newapp/
   ```

### 新しいスクリプトの追加

1. `bin/` にスクリプトを作成
   ```bash
   touch bin/my-script
   chmod +x bin/my-script
   ```

2. スクリプトを編集
   ```bash
   #!/bin/bash
   # Description: My custom script

   echo "Hello from my-script!"
   ```

3. シンボリックリンクを再作成
   ```bash
   make link
   ```

4. 使用
   ```bash
   my-script
   ```

---

## フォーク運用

### 初期設定

1. リポジトリをフォーク

2. クローン
   ```bash
   git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
   ```

3. upstreamを設定
   ```bash
   cd ~/dotfiles
   git remote add upstream https://github.com/ORIGINAL_OWNER/dotfiles.git
   ```

### 更新の取り込み

```bash
# upstreamから取得
git fetch upstream

# mainブランチに切り替え
git checkout main

# マージ
git merge upstream/main

# コンフリクトがあれば解決
# ...

# プッシュ
git push origin main
```

### ブランチ戦略

```
main          ← 安定版（本番環境用）
├── develop   ← 開発版
└── feature/* ← 新機能
```

---

## ベストプラクティス

### 1. 小さなコミット

```bash
# 良い例
git commit -m "Add ripgrep to Brewfile"
git commit -m "Add search alias for ripgrep"

# 悪い例
git commit -m "Update dotfiles"
```

### 2. 機密情報を含めない

```bash
# .gitignoreに追加
*.local
.env
credentials.json
```

### 3. ドキュメントを更新

新しい機能を追加したら、対応するドキュメントも更新：

```bash
git commit -m "Add new-feature

- Add configuration in config/
- Update TOOLS.md with description
- Update README.md"
```

### 4. テストしてからコミット

```bash
# シェル構文チェック
make test

# 新しいマシンでのテスト（Docker等で）
docker run -it --rm -v $(pwd):/dotfiles ubuntu:latest /dotfiles/setup.sh
```

---

## トラブルシューティング

### シンボリックリンクが壊れている

```bash
# 確認
make doctor

# 再作成
make link
```

### 設定が反映されない

```bash
# シェルを再起動
exec zsh

# macOS設定を再適用
make macos
```

### パッケージの不整合

```bash
# Brewfileと実際のインストール状況を比較
brew bundle check --file=Brewfile

# 不要なパッケージを削除
brew bundle cleanup --file=Brewfile --force
```

---

## 関連ドキュメント

- [CLIツールガイド](./TOOLS.md)
- [アプリケーションガイド](./APPS.md)
- [シェル設定ガイド](./SHELL.md)
- [macOS設定ガイド](./MACOS.md)
