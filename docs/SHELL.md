# 🐚 Shell Configuration Guide

> このドキュメントでは、Zshシェルの設定内容と設計思想を説明します。

## 目次

- [ファイル構成](#ファイル構成)
- [読み込み順序](#読み込み順序)
- [環境変数 (zshenv)](#環境変数-zshenv)
- [PATH設定 (path.zsh)](#path設定-pathzsh)
- [エイリアス (aliases.zsh)](#エイリアス-aliaseszsh)
- [関数 (functions.zsh)](#関数-functionszsh)
- [メイン設定 (zshrc)](#メイン設定-zshrc)
- [プラグイン](#プラグイン)
- [プロンプト (Starship)](#プロンプト-starship)
- [キーバインド](#キーバインド)

---

## ファイル構成

```
shell/
├── zshenv          # 環境変数（全シェルで読み込み）
├── zshrc           # メイン設定（インタラクティブシェルで読み込み）
├── path.zsh        # PATH設定
├── aliases.zsh     # エイリアス定義
└── functions.zsh   # シェル関数
```

### なぜ分割するか？

```
利点:
  ✓ 関心の分離（環境変数、パス、エイリアス、関数）
  ✓ メンテナンス性向上
  ✓ 部分的な更新が容易
  ✓ チーム共有時に必要な部分だけ共有可能

従来の問題:
  ✗ 巨大な.zshrcは読みにくい
  ✗ どこに何があるか分からなくなる
  ✗ 変更時の影響範囲が不明確
```

---

## 読み込み順序

```
1. /etc/zshenv      ← システム全体
2. ~/.zshenv        ← ユーザー環境変数 ★
3. /etc/zprofile    ← ログインシェル時
4. ~/.zprofile      ← ログインシェル時
5. /etc/zshrc       ← インタラクティブシェル時
6. ~/.zshrc         ← ユーザーメイン設定 ★
7. /etc/zlogin      ← ログインシェル時
8. ~/.zlogin        ← ログインシェル時
```

### 使い分け

| ファイル | タイミング | 用途 |
|----------|------------|------|
| `zshenv` | **常に** | 環境変数（EDITOR, LANG, XDG_*等） |
| `zprofile` | ログインシェル | GUI起動時の設定 |
| `zshrc` | インタラクティブ | エイリアス、プロンプト、補完 |
| `zlogin` | ログイン後 | 起動メッセージ |

---

## 環境変数 (zshenv)

### XDG Base Directory

```bash
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
```

**目的**: ホームディレクトリを整理し、設定ファイルを標準的な場所に配置

```
~/.config/     ← 設定ファイル
~/.local/share ← データファイル
~/.local/state ← 状態ファイル（履歴等）
~/.cache/      ← キャッシュ
```

### アプリケーション別設定

各アプリケーションをXDG準拠に:

```bash
# Git
# → ~/.config/git/config

# Node.js
export NODE_REPL_HISTORY="$XDG_STATE_HOME/node_repl_history"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"

# Python
export PYTHON_HISTORY="$XDG_STATE_HOME/python_history"

# Rust
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

# Go
export GOPATH="$XDG_DATA_HOME/go"
```

---

## PATH設定 (path.zsh)

### 優先順位

```
高 ← $HOME/.local/bin         # ユーザースクリプト
   ← $DOTFILES/bin            # dotfilesスクリプト
   ← $CARGO_HOME/bin          # Rustツール
   ← $GOPATH/bin              # Goツール
   ← $HOMEBREW_PREFIX/bin     # Homebrewバイナリ
   ← GNU coreutils            # GNU版コマンド
低 ← /usr/bin, /bin           # システムデフォルト
```

### ヘルパー関数

```bash
# 存在する場合のみPATHに追加
path_prepend() {
    [[ -d "$1" ]] && path=("$1" $path)
}

# 重複削除
typeset -U path
```

---

## エイリアス (aliases.zsh)

### 分類

#### 1. モダン代替

```bash
# eza (ls代替)
alias ls='eza --icons --group-directories-first'
alias ll='eza -la --icons --group-directories-first --git'
alias lt='eza -T --icons --level=2'  # ツリー表示

# bat (cat代替)
alias cat='bat --paging=never'

# trash (rm代替)
alias rm='trash'

# zoxide (cd代替)
alias cd='z'
```

#### 2. ナビゲーション

```bash
alias ..='cd ..'
alias ...='cd ../..'
alias dev='cd ~/dev'
alias dot='cd $DOTFILES'
```

#### 3. Git

```bash
alias g='git'
alias gs='git status -sb'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline -20'
alias lg='lazygit'
```

#### 4. Docker

```bash
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias dex='docker exec -it'
```

#### 5. 安全対策

```bash
alias cp='cp -iv'    # 確認＋詳細表示
alias mv='mv -iv'    # 確認＋詳細表示
alias mkdir='mkdir -pv'  # 親ディレクトリも作成
```

### エイリアス命名規則

| パターン | 例 | 意味 |
|----------|-----|------|
| コマンド頭文字 | `g` = git | 最頻出コマンド |
| コマンド+サブコマンド頭文字 | `gs` = git status | よく使うサブコマンド |
| 動詞+対象 | `killport` | 動作が明確 |

---

## 関数 (functions.zsh)

### ファイル操作

```bash
# ディレクトリ作成 & 移動
mkcd() {
    mkdir -p "$@" && cd "$_"
}

# アーカイブ展開（形式自動判別）
extract() {
    case "$1" in
        *.tar.gz)  tar xzf "$1" ;;
        *.zip)     unzip "$1" ;;
        *.7z)      7z x "$1" ;;
        # ...
    esac
}

# バックアップ作成
backup() {
    cp -v "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"
}
```

### Git

```bash
# クローン & 移動
gclone() {
    git clone "$1" && cd "$(basename "$1" .git)"
}

# fzfでブランチ選択＆チェックアウト
gch() {
    local branch
    branch=$(git branch --all | fzf | tr -d '[:space:]')
    [[ -n "$branch" ]] && git checkout "$branch"
}
```

### fzf統合

```bash
# ファイル検索 & 編集
fe() {
    local file
    file=$(fzf --preview 'bat --color=always {}')
    [[ -n "$file" ]] && ${EDITOR} "$file"
}

# ディレクトリ検索 & 移動
fcd() {
    local dir
    dir=$(fd --type d | fzf --preview 'eza -la {}')
    [[ -n "$dir" ]] && cd "$dir"
}

# プロセス検索 & kill
fkill() {
    local pid
    pid=$(ps -ef | fzf | awk '{print $2}')
    [[ -n "$pid" ]] && kill -9 "$pid"
}
```

### ユーティリティ

```bash
# HTTPサーバー起動
serve() {
    python3 -m http.server "${1:-8000}"
}

# 天気表示
wttr() {
    curl -s "wttr.in/${1:-Tokyo}?format=v2"
}

# チートシート
cheat() {
    curl -s "cheat.sh/$1"
}
```

---

## メイン設定 (zshrc)

### 履歴設定

```bash
HISTFILE="${XDG_STATE_HOME}/zsh/history"
HISTSIZE=50000
SAVEHIST=50000

setopt SHARE_HISTORY          # セッション間で共有
setopt HIST_IGNORE_DUPS       # 連続重複を無視
setopt HIST_IGNORE_SPACE      # スペース始まりを無視
setopt HIST_VERIFY            # 実行前に確認
```

### Zshオプション

```bash
setopt AUTO_CD                # ディレクトリ名だけでcd
setopt AUTO_PUSHD             # cdでスタックに積む
setopt CORRECT                # コマンド修正提案
setopt EXTENDED_GLOB          # 拡張グロブ
setopt NO_BEEP                # ビープ音無効
```

### 補完システム

```bash
# 補完の初期化（1日1回キャッシュ再生成）
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

# 補完スタイル
zstyle ':completion:*' menu select           # メニュー選択
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # 大小文字無視
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"  # 色付け
```

---

## プラグイン

### Homebrew管理プラグイン

| プラグイン | 効果 |
|------------|------|
| `zsh-autosuggestions` | 履歴から入力候補を薄いグレーで表示 |
| `zsh-syntax-highlighting` | コマンドの構文をリアルタイムで色付け |
| `zsh-completions` | 追加の補完定義 |

### なぜプラグインマネージャーを使わないか？

```
選択肢: Homebrew直接 vs Oh My Zsh vs zinit vs zplug

Homebrew直接:
  ✓ 依存関係が明確
  ✓ 起動時間への影響最小
  ✓ Brewfileで一元管理
  ✓ アップデートが brew upgrade で完結

Oh My Zsh:
  ✗ 大量の不要機能
  ✗ 起動が遅くなる

zinit/zplug:
  ✓ 遅延読み込み可能
  ✗ 追加の設定が必要
  ✗ Homebrewと管理が分散

→ Homebrewで必要最小限のプラグインを管理
```

---

## プロンプト (Starship)

### 設定ファイル

`~/.config/starship.toml`

### 表示内容

```
┌──────────────────────────────────────────────────────┐
│ ~/dev/myproject  main !2 +3   3.12  20   │
│ ❯                                              12:34 │
└──────────────────────────────────────────────────────┘

左側:
  - ディレクトリ（アイコン付き）
  - Gitブランチ + 状態
  - Python/Node.jsバージョン（自動検出）
  - AWS/GCPプロファイル

右側:
  - 時刻

2行目:
  - プロンプト文字（❯）
```

### カスタマイズポイント

```toml
# ディレクトリ短縮
[directory]
truncation_length = 4
truncate_to_repo = true

# Git状態のシンボル
[git_status]
ahead = "⇡${count}"
behind = "⇣${count}"
modified = "!${count}"

# コマンド実行時間（2秒以上で表示）
[cmd_duration]
min_time = 2_000
```

---

## キーバインド

### Emacsスタイル（デフォルト）

```bash
bindkey -e

# 履歴検索
bindkey '^[[A' history-search-backward  # ↑
bindkey '^[[B' history-search-forward   # ↓
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# 単語移動（Option+矢印）
bindkey '^[[1;3C' forward-word   # Option+→
bindkey '^[[1;3D' backward-word  # Option+←

# 行頭/行末
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
```

### fzfキーバインド

| キー | 動作 |
|------|------|
| `Ctrl+R` | 履歴をfzfで検索 |
| `Ctrl+T` | ファイルをfzfで検索 |
| `Alt+C` | ディレクトリをfzfで検索 & cd |

---

## パフォーマンス

### 起動時間計測

```bash
# プロファイリング有効化
# zshrcの先頭に追加
zmodload zsh/zprof

# 末尾に追加
zprof
```

### 最適化ポイント

1. **補完キャッシュ**: 1日1回だけ再生成
2. **プラグイン最小化**: 本当に必要なものだけ
3. **遅延読み込み**: 重いツールは使用時に初期化
4. **Starship**: Rust製で高速

### 目標起動時間

```
目標: < 100ms
実測: 約50-80ms（M1 Mac）
```

---

## ローカルカスタマイズ

### ~/.zshrc.local

マシン固有の設定（gitで管理しない）:

```bash
# 会社固有の設定
export COMPANY_API_KEY="xxx"
alias work="cd ~/work/company-project"

# このマシン専用エイリアス
alias myalias='my-command'
```

---

## 関連ドキュメント

- [CLIツールガイド](./TOOLS.md)
- [アプリケーションガイド](./APPS.md)
- [macOS設定ガイド](./MACOS.md)
- [カスタマイズガイド](./CUSTOMIZATION.md)
