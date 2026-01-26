# 🍎 macOS Settings Guide

> このドキュメントでは、`macos/defaults.sh`で設定されるmacOSの各種設定の詳細を説明します。

## 目次

- [設定の仕組み](#設定の仕組み)
- [General UI/UX](#general-uiux)
- [トラックパッド & マウス](#トラックパッド--マウス)
- [キーボード](#キーボード)
- [Dock](#dock)
- [Finder](#finder)
- [Safari](#safari)
- [スクリーンショット](#スクリーンショット)
- [Activity Monitor](#activity-monitor)
- [省エネルギー](#省エネルギー)
- [セキュリティ](#セキュリティ)
- [その他](#その他)
- [ホットコーナー](#ホットコーナー)

---

## 設定の仕組み

### defaultsコマンド

macOSの設定は`defaults`コマンドで変更できます：

```bash
# 読み取り
defaults read com.apple.dock autohide

# 書き込み
defaults write com.apple.dock autohide -bool true

# 削除（デフォルトに戻す）
defaults delete com.apple.dock autohide
```

### 設定の反映

多くの設定は即座に反映されますが、一部はアプリの再起動やログアウトが必要：

```bash
# Dock/Finderを再起動
killall Dock
killall Finder

# ログアウト/再起動が必要な設定もある
```

---

## General UI/UX

### 起動音

```bash
# 起動時の「ジャーン」音を無効化
sudo nvram SystemAudioVolume=" "
```

**理由**: オフィスや公共の場で起動時に音が鳴ると困る

### ダイアログ

```bash
# 保存ダイアログを展開状態で表示
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# 印刷ダイアログを展開状態で表示
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
```

**理由**: 毎回展開する手間を省く

### iCloud

```bash
# 新規ドキュメントをiCloudではなくローカルに保存
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
```

**理由**: 意図せずiCloudに保存されるのを防ぐ

### 自動修正・置換の無効化

```bash
# 自動大文字化
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# スマートダッシュ（--を—に変換）
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# 自動ピリオド（スペース2回で.）
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# スマートクォート（"を"に変換）
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# 自動スペルチェック
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
```

**理由**: プログラミングやターミナル使用時に邪魔になる

---

## トラックパッド & マウス

### タップでクリック

```bash
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
```

**理由**: 物理クリックより軽い操作でクリック可能

### 三本指ドラッグ

```bash
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
```

**理由**: ウィンドウ移動やテキスト選択が片手で可能に

| ジェスチャー | 動作 |
|--------------|------|
| 1本指タップ | クリック |
| 2本指タップ | 右クリック |
| 3本指ドラッグ | ウィンドウ移動/選択 |

### トラッキング速度

```bash
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.5
```

**理由**: デフォルトより速くすることで作業効率向上

---

## キーボード

### キーリピート

```bash
# キーリピート速度（小さいほど速い、最小1）
defaults write NSGlobalDomain KeyRepeat -int 2

# キーリピート開始までの時間（小さいほど速い、最小10）
defaults write NSGlobalDomain InitialKeyRepeat -int 15
```

**理由**: ターミナルやVimでの高速移動に必須

| 設定 | デフォルト | 推奨値 |
|------|------------|--------|
| KeyRepeat | 6 | 2 |
| InitialKeyRepeat | 25 | 15 |

### プレス&ホールド無効化

```bash
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
```

**理由**: 長押しでアクセント文字を選ぶポップアップが出るのを防ぐ。キーリピートを有効にするために必要

### フルキーボードアクセス

```bash
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
```

**理由**: Tabキーでダイアログのすべてのコントロールにフォーカス移動可能に

---

## Dock

### 位置とサイズ

```bash
# 右側に配置
defaults write com.apple.dock orientation -string "right"

# アイコンサイズ（ピクセル）
defaults write com.apple.dock tilesize -int 36

# 拡大有効、拡大時サイズ
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 64
```

**理由**:
- 右配置: 縦長のディスプレイを有効活用
- 小さいサイズ: 画面領域を最大化

### 自動非表示

```bash
# 自動非表示
defaults write com.apple.dock autohide -bool true

# 非表示までの遅延（0秒）
defaults write com.apple.dock autohide-delay -float 0

# アニメーション速度
defaults write com.apple.dock autohide-time-modifier -float 0.3
```

**理由**: 画面を広く使いつつ、必要な時はすぐアクセス

### その他

```bash
# 最近使ったアプリを表示しない
defaults write com.apple.dock show-recents -bool false

# アプリ起動アニメーション無効
defaults write com.apple.dock launchanim -bool false

# Mission Controlアニメーション高速化
defaults write com.apple.dock expose-animation-duration -float 0.1

# Spacesの自動並び替え無効
defaults write com.apple.dock mru-spaces -bool false
```

**理由**: 余計なアニメーションを減らし、予測可能な動作に

---

## Finder

### デフォルト表示

```bash
# 新規ウィンドウでホームフォルダを表示
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# リスト表示をデフォルトに
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
```

### 表示オプション

```bash
# 拡張子を常に表示
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# ステータスバー表示
defaults write com.apple.finder ShowStatusBar -bool true

# パスバー表示
defaults write com.apple.finder ShowPathbar -bool true

# フルパスをタイトルバーに表示
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# フォルダを先に表示
defaults write com.apple.finder _FXSortFoldersFirst -bool true
```

**理由**: ファイル情報を最大限表示し、ナビゲーションを効率化

### 検索

```bash
# 検索時に現在のフォルダをデフォルトに
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
```

### 警告の抑制

```bash
# 拡張子変更時の警告を無効
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# ゴミ箱を空にする時の警告を無効
defaults write com.apple.finder WarnOnEmptyTrash -bool false
```

**理由**: 確認済みの操作で毎回警告されるのを防ぐ

### .DS_Store

```bash
# ネットワークドライブに.DS_Storeを作成しない
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# USBドライブに.DS_Storeを作成しない
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
```

**理由**: 共有フォルダやUSBを汚さない

### 隠しフォルダの表示

```bash
# ~/Libraryを表示
chflags nohidden ~/Library

# /Volumesを表示
sudo chflags nohidden /Volumes
```

---

## Safari

### 開発者向け設定

```bash
# Developメニューを有効化
defaults write com.apple.Safari IncludeDevelopMenu -bool true

# Web Inspectorを有効化
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true

# デバッグメニューを有効化
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
```

### プライバシー

```bash
# 検索クエリをAppleに送信しない
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Do Not Trackヘッダーを送信
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true
```

### セキュリティ

```bash
# 安全でないファイルの自動オープンを無効
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# フィッシング警告を有効
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# ポップアップブロック
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
```

---

## スクリーンショット

```bash
# 保存場所をDownloadsに
defaults write com.apple.screencapture location -string "${HOME}/Downloads"

# PNG形式で保存
defaults write com.apple.screencapture type -string "png"

# ウィンドウの影を無効
defaults write com.apple.screencapture disable-shadow -bool true
```

**理由**:
- デスクトップが散らからない
- PNGは可逆圧縮で品質維持
- 影なしでクリーンな画像

### スクリーンショットのショートカット

| ショートカット | 動作 |
|----------------|------|
| `Cmd+Shift+3` | 画面全体 |
| `Cmd+Shift+4` | 選択範囲 |
| `Cmd+Shift+4+Space` | ウィンドウ |
| `Cmd+Shift+5` | スクリーンショットツール |

---

## Activity Monitor

```bash
# すべてのプロセスを表示
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# CPU使用率でソート
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# DockアイコンでCPU使用率を表示
defaults write com.apple.ActivityMonitor IconType -int 5
```

---

## 省エネルギー

```bash
# バッテリー使用時: 15分でディスプレイスリープ
sudo pmset -b displaysleep 15

# 電源接続時: 30分でディスプレイスリープ
sudo pmset -c displaysleep 30

# バッテリー使用時: 30分でスリープ
sudo pmset -b sleep 30

# 電源接続時: スリープしない
sudo pmset -c sleep 0
```

---

## セキュリティ

```bash
# スクリーンセーバー後、即座にパスワード要求
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
```

---

## その他

### ターミナル

```bash
# UTF-8のみ使用
defaults write com.apple.terminal StringEncodings -array 4

# セキュアキーボード入力を有効
defaults write com.apple.terminal SecureKeyboardEntry -bool true
```

### TextEdit

```bash
# プレーンテキストをデフォルトに
defaults write com.apple.TextEdit RichText -int 0

# UTF-8で開く/保存
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4
```

### Time Machine

```bash
# 新しいディスクをバックアップ先として提案しない
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
```

### Photos

```bash
# デバイス接続時にPhotosを自動起動しない
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
```

---

## ホットコーナー

画面の四隅にマウスを移動した時のアクション：

```bash
# 左上: Mission Control
defaults write com.apple.dock wvous-tl-corner -int 2

# 右上: 通知センター
defaults write com.apple.dock wvous-tr-corner -int 12

# 左下: デスクトップを表示
defaults write com.apple.dock wvous-bl-corner -int 4

# 右下: ロック画面
defaults write com.apple.dock wvous-br-corner -int 13
```

### 利用可能なアクション

| 値 | アクション |
|----|------------|
| 0 | なし |
| 2 | Mission Control |
| 3 | アプリケーションウィンドウ |
| 4 | デスクトップ |
| 5 | スクリーンセーバー開始 |
| 6 | スクリーンセーバー無効 |
| 10 | ディスプレイをスリープ |
| 11 | Launchpad |
| 12 | 通知センター |
| 13 | ロック画面 |

---

## 設定のリセット

特定の設定をデフォルトに戻す：

```bash
# 単一の設定を削除
defaults delete com.apple.dock autohide

# アプリの全設定をリセット
defaults delete com.apple.dock

# 反映
killall Dock
```

---

## トラブルシューティング

### 設定が反映されない場合

1. アプリを再起動
   ```bash
   killall Finder
   killall Dock
   ```

2. ログアウト/ログイン

3. 再起動

### 設定を確認

```bash
# 現在の値を確認
defaults read com.apple.dock

# 特定の値を確認
defaults read com.apple.dock autohide
```

---

## 関連ドキュメント

- [CLIツールガイド](./TOOLS.md)
- [アプリケーションガイド](./APPS.md)
- [シェル設定ガイド](./SHELL.md)
- [カスタマイズガイド](./CUSTOMIZATION.md)
