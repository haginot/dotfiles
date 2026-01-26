# 🏠 Dotfiles

> Modern, opinionated dotfiles for macOS - built for productivity and developer happiness.

![macOS](https://img.shields.io/badge/macOS-Sonoma%2B-blue?logo=apple)
![Shell](https://img.shields.io/badge/Shell-Zsh-green?logo=gnu-bash)
![License](https://img.shields.io/badge/License-MIT-yellow)

## ✨ Features

- **🚀 One-command setup** - Get your Mac configured in minutes
- **📦 Complete package management** - Homebrew, Mac App Store, and VS Code extensions
- **🐚 Modern shell experience** - Zsh with syntax highlighting, autosuggestions, and Starship prompt
- **🔧 Unified runtime management** - mise for Python, Node.js, Go, Rust, and more
- **⌨️ Keyboard optimization** - Karabiner for Emacs-style keybindings
- **🎨 Beautiful terminal** - Ghostty with Catppuccin theme and Nerd Fonts
- **📁 XDG Base Directory compliant** - Clean home directory
- **🔄 Idempotent** - Run setup multiple times safely

## 📚 Documentation

完全なドキュメントは [docs/](./docs/) ディレクトリにあります：

| ドキュメント | 内容 |
|--------------|------|
| [📚 Index](./docs/INDEX.md) | ドキュメント索引 |
| [🤖 AI Tools Guide](./docs/AI-TOOLS.md) | Claude Code, Cursor, Codexの設定 |
| [🛠️ Tools Guide](./docs/TOOLS.md) | 全CLIツールの役割と選定理由 |
| [📱 Apps Guide](./docs/APPS.md) | 全アプリケーションの役割と選定理由 |
| [🐚 Shell Guide](./docs/SHELL.md) | シェル設定の詳細解説 |
| [🍎 macOS Guide](./docs/MACOS.md) | macOS設定の詳細解説 |
| [🎨 Customization](./docs/CUSTOMIZATION.md) | カスタマイズ方法 |

## 📁 Structure

```
dotfiles/
├── bin/                    # Custom scripts (added to PATH)
│   ├── cleanup             # System cleanup utility
│   ├── colors              # Terminal color palette
│   ├── git-open            # Open repo in browser
│   ├── sysinfo             # System information
│   └── weather             # Weather in terminal
├── config/                 # Application configs (XDG_CONFIG_HOME)
│   ├── git/
│   │   ├── config          # Git configuration
│   │   └── ignore          # Global gitignore
│   ├── ghostty/config      # Ghostty terminal
│   ├── karabiner/          # Keyboard customization
│   ├── mise/config.toml    # Runtime manager
│   └── starship/           # Shell prompt
├── docs/                   # Documentation
│   ├── INDEX.md            # Documentation index
│   ├── TOOLS.md            # CLI tools guide
│   ├── APPS.md             # Applications guide
│   ├── SHELL.md            # Shell configuration guide
│   ├── MACOS.md            # macOS settings guide
│   └── CUSTOMIZATION.md    # Customization guide
├── macos/
│   └── defaults.sh         # macOS system preferences
├── shell/
│   ├── zshenv              # Environment variables
│   ├── zshrc               # Main Zsh config
│   ├── aliases.zsh         # Command aliases
│   ├── functions.zsh       # Shell functions
│   └── path.zsh            # PATH configuration
├── Brewfile                # Homebrew packages & App Store apps
├── Makefile                # Automation commands
├── setup.sh                # Main installer
└── README.md
```

## 🚀 Quick Start

### Fresh Mac Setup

```bash
# 1. Clone the repository
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles

# 2. Run the installer
cd ~/dotfiles
./setup.sh

# 3. Restart your terminal
exec zsh
```

### What Gets Installed

**CLI Tools**: git, gh, fzf, ripgrep, fd, bat, eza, jq, htop, tmux, and 150+ more

**Applications**: Cursor, VS Code, Docker, Ghostty, Alfred, Chrome, Slack, Discord, etc.

**App Store**: Xcode, Paste, BetterSnapTool, CleanMyMac, Hidden Bar, etc.

**Fonts**: JetBrains Mono, Fira Code, Hack (all Nerd Font variants)

## 🛠️ Commands

### Make Targets

| Command | Description |
|---------|-------------|
| `make install` | Full installation (default) |
| `make link` | Create symlinks only |
| `make brew` | Install Homebrew packages |
| `make macos` | Configure macOS settings |
| `make apps` | Install App Store apps |
| `make update` | Update all packages |
| `make doctor` | Check dotfiles health |
| `make help` | Show all commands |

### Custom Scripts (available after install)

| Script | Description |
|--------|-------------|
| `cleanup` | Clean system caches and temporary files |
| `sysinfo` | Display system information |
| `colors` | Show terminal color palette |
| `weather [city]` | Show weather information |
| `git-open [pr\|issues]` | Open git repo in browser |

## 🐚 Shell Features

### Modern Replacements

| Old | New | Description |
|-----|-----|-------------|
| `ls` | `eza` | Better ls with icons and git status |
| `cat` | `bat` | Syntax highlighting and line numbers |
| `cd` | `zoxide` | Smart directory jumping |
| `find` | `fd` | Faster, user-friendly find |
| `grep` | `ripgrep` | Blazingly fast search |
| `rm` | `trash` | Move to trash instead of delete |

### Key Aliases

```bash
# Git
gs    # git status
ga    # git add
gc    # git commit
gp    # git push
lg    # lazygit

# Docker
d     # docker
dc    # docker compose
dps   # docker ps

# Navigation
..    # cd ..
...   # cd ../..
dev   # cd ~/dev
dot   # cd ~/dotfiles

# macOS
o     # open
oo    # open .
```

### Functions

```bash
mkcd dirname    # Create and enter directory
extract file    # Extract any archive
serve [port]    # Start HTTP server
fe              # Fuzzy find and edit file
fcd             # Fuzzy find and cd to directory
gclone url      # Clone and cd into repo
```

## ⌨️ Key Bindings

### Zsh

| Shortcut | Action |
|----------|--------|
| `Ctrl+R` | Fuzzy history search (fzf) |
| `Ctrl+T` | Fuzzy file finder |
| `Alt+C` | Fuzzy directory jump |
| `Ctrl+P/N` | History search up/down |

### Karabiner (Emacs-style)

| Shortcut | Action |
|----------|--------|
| `Ctrl+A` | Beginning of line |
| `Ctrl+E` | End of line |
| `Ctrl+F/B` | Forward/backward char |
| `Ctrl+D` | Delete forward |
| `Ctrl+K` | Kill to end of line |

## 🎨 Theming

The setup uses **Catppuccin Mocha** theme across:
- Ghostty terminal
- Starship prompt
- git-delta (diff viewer)
- fzf (fuzzy finder)
- bat (syntax highlighting)

## 🔧 Customization

### Local Overrides

Create `~/.zshrc.local` for machine-specific settings (not tracked in git):

```bash
# ~/.zshrc.local
export WORK_PROJECT="~/work/secret-project"
alias myalias='my-custom-command'
```

### Adding Packages

1. Install with Homebrew: `brew install package-name`
2. Update Brewfile: `make brew-dump`
3. Commit changes

### Runtime Versions

Edit `~/.config/mise/config.toml`:

```toml
[tools]
python = "3.12"
node = "20"
go = "1.22"
```

Then run: `mise install`

## 📋 macOS Settings

The `macos/defaults.sh` script configures:

- **Dock**: Right side, auto-hide, small icons
- **Finder**: Show extensions, path bar, list view
- **Keyboard**: Fast key repeat, no auto-correct
- **Trackpad**: Tap to click, three-finger drag
- **Screenshots**: Save to Downloads, PNG format
- **Hot Corners**: Mission Control, Desktop, Lock Screen

## 🔄 Updating

```bash
# Update everything
make update

# Update specific
brew upgrade              # Homebrew packages
mise upgrade              # Runtime versions
mas upgrade               # App Store apps
```

## 🆘 Troubleshooting

### Check Health

```bash
make doctor
```

### Reset Symlinks

```bash
make link
```

### Shell Not Loading Correctly

```bash
# Check syntax
make test

# Reload shell
exec zsh
```

### Homebrew Issues

```bash
brew doctor
brew cleanup
```

## 📝 License

MIT License - feel free to use and modify for your own dotfiles!

## 🙏 Credits

Inspired by:
- [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
- [holman/dotfiles](https://github.com/holman/dotfiles)
- [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles)
