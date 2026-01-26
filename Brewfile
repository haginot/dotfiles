# ==============================================================================
# Brewfile - Complete Package Management
# ==============================================================================
# Install:  brew bundle install --file=Brewfile
# Update:   brew bundle dump --file=Brewfile --force --describe
# Cleanup:  brew bundle cleanup --file=Brewfile
# ==============================================================================

# ------------------------------------------------------------------------------
# Taps
# ------------------------------------------------------------------------------
tap "dbt-labs/dbt-cli"
tap "ekristen/tap"
tap "homebrew/bundle"
tap "homebrew/services"
tap "jbangdev/tap"
tap "rcmdnk/file"

# ------------------------------------------------------------------------------
# Core CLI Tools
# ------------------------------------------------------------------------------
brew "coreutils"             # GNU core utilities
brew "moreutils"             # Additional unix utilities (sponge, etc.)
brew "findutils"             # GNU find, xargs
brew "gnu-sed"               # GNU sed
brew "gnu-tar"               # GNU tar
brew "gawk"                  # GNU awk
brew "grep"                  # GNU grep
brew "ripgrep"               # Fast grep alternative
brew "fd"                    # Fast find alternative
brew "sd"                    # Fast sed alternative
brew "eza"                   # Modern ls replacement
brew "bat"                   # Cat with syntax highlighting
brew "fzf"                   # Fuzzy finder
brew "zoxide"                # Smart cd command
brew "tree"
brew "wget"
brew "curl"
brew "htop"                  # Process viewer
brew "jq"                    # JSON processor
brew "yq"                    # YAML processor

# ------------------------------------------------------------------------------
# Shell & Terminal
# ------------------------------------------------------------------------------
brew "zsh"
brew "zsh-autosuggestions"
brew "zsh-syntax-highlighting"
brew "zsh-completions"
brew "starship"              # Cross-shell prompt
brew "tmux"
brew "direnv"                # Directory-specific env vars

# ------------------------------------------------------------------------------
# Version Control
# ------------------------------------------------------------------------------
brew "git"
brew "git-lfs"
brew "git-delta"             # Better git diff
brew "gh"                    # GitHub CLI
brew "lazygit"               # Git TUI
brew "bfg"                   # Git history cleaner

# ------------------------------------------------------------------------------
# Version Managers (mise replaces asdf/pyenv/nodenv)
# ------------------------------------------------------------------------------
brew "mise"                  # Polyglot runtime manager (python, node, etc.)

# ------------------------------------------------------------------------------
# Languages & Package Managers
# ------------------------------------------------------------------------------
brew "node"
brew "yarn"
brew "uv"                    # Fast Python package manager
brew "poetry"                # Python dependency management
brew "openjdk"
brew "jbangdev/tap/jbang"

# ------------------------------------------------------------------------------
# Cloud & Infrastructure
# ------------------------------------------------------------------------------
brew "awscli"
brew "terraform"
brew "railway"
brew "render"
brew "ekristen/tap/aws-nuke"

# ------------------------------------------------------------------------------
# Database
# ------------------------------------------------------------------------------
brew "mysql@8.0"
brew "postgresql@14", restart_service: :changed

# ------------------------------------------------------------------------------
# AI & ML Tools
# ------------------------------------------------------------------------------
brew "claude-squad"
brew "gemini-cli"

# ------------------------------------------------------------------------------
# Data Processing & Media
# ------------------------------------------------------------------------------
brew "ffmpeg"
brew "imagemagick"
brew "graphicsmagick"
brew "graphviz"
brew "pandoc"
brew "poppler"               # PDF tools
brew "tesseract"
brew "tesseract-lang"
brew "nkf"                   # Japanese text encoding

# ------------------------------------------------------------------------------
# Development Tools
# ------------------------------------------------------------------------------
brew "act"                   # Run GitHub Actions locally
brew "just"                  # Command runner
brew "watchexec"             # File watcher
brew "hyperfine"             # Benchmarking tool
brew "tokei"                 # Code statistics
brew "shellcheck"            # Shell script linter

# ------------------------------------------------------------------------------
# Networking & Security
# ------------------------------------------------------------------------------
brew "openssh"
brew "gnupg"
brew "pinentry-mac"          # GPG PIN entry
brew "mtr"                   # Network diagnostics
brew "nmap"
brew "inetutils"

# ------------------------------------------------------------------------------
# Utilities
# ------------------------------------------------------------------------------
brew "mas"                   # Mac App Store CLI
brew "blueutil"              # Bluetooth CLI
brew "sleepwatcher"          # Sleep/wake automation
brew "duti"                  # Default app manager
brew "switchaudio-osx"       # Audio switching
brew "trash"                 # Safe rm alternative
brew "ghostscript"
brew "gmp"
brew "libomp"
brew "tcl-tk"
brew "xz"
brew "harfbuzz"
brew "dbt-labs/dbt-cli/dbt"
brew "rcmdnk/file/brew-file"

# ==============================================================================
# Applications (Casks)
# ==============================================================================

# ------------------------------------------------------------------------------
# Development
# ------------------------------------------------------------------------------
cask "cursor"                # AI-powered editor
cask "visual-studio-code"
cask "macvim-app"
cask "docker-desktop"
cask "ghostty"               # Modern terminal
cask "warp"                  # AI terminal (alternative)
cask "orbstack"              # Fast Docker/Linux (alternative to Docker Desktop)
cask "tableplus"             # Database GUI
cask "insomnia"              # API client

# ------------------------------------------------------------------------------
# Cloud & DevOps
# ------------------------------------------------------------------------------
cask "gcloud-cli"
cask "cyberduck"             # FTP/S3 client

# ------------------------------------------------------------------------------
# Productivity
# ------------------------------------------------------------------------------
cask "alfred"                # Launcher
cask "raycast"               # Modern launcher (alternative)
cask "karabiner-elements"    # Keyboard customization
cask "keyboardcleantool"     # Keyboard cleaner
cask "rectangle"             # Window manager (free)
cask "1password"             # Password manager
cask "notion"                # Notes & docs
cask "obsidian"              # Markdown notes

# ------------------------------------------------------------------------------
# Communication
# ------------------------------------------------------------------------------
cask "discord"
cask "zoom"

# ------------------------------------------------------------------------------
# Browsers
# ------------------------------------------------------------------------------
cask "google-chrome"
cask "firefox"
cask "arc"                   # Modern browser

# ------------------------------------------------------------------------------
# Media
# ------------------------------------------------------------------------------
cask "vlc"                   # Video player
cask "spotify"               # Music
cask "handbrake"             # Video converter

# ------------------------------------------------------------------------------
# Documents & Office
# ------------------------------------------------------------------------------
cask "libreoffice"
cask "basictex"

# ------------------------------------------------------------------------------
# Storage & Sync
# ------------------------------------------------------------------------------
cask "box-drive"
cask "dropbox"

# ------------------------------------------------------------------------------
# Input & Fonts
# ------------------------------------------------------------------------------
cask "google-japanese-ime"

# ------------------------------------------------------------------------------
# Utilities
# ------------------------------------------------------------------------------
cask "bluesnooze"            # Bluetooth sleep fix
cask "appcleaner"            # Clean uninstaller
cask "the-unarchiver"        # Archive utility
cask "stats"                 # System monitor
cask "monitorcontrol"        # External display control
cask "aldente"               # Battery management

# ------------------------------------------------------------------------------
# Specialized
# ------------------------------------------------------------------------------
cask "neo4j-desktop"
cask "unity-hub"

# ------------------------------------------------------------------------------
# Fonts
# ------------------------------------------------------------------------------
cask "font-fira-code"
cask "font-fira-code-nerd-font"
cask "font-jetbrains-mono"
cask "font-jetbrains-mono-nerd-font"
cask "font-hack-nerd-font"
cask "font-meslo-lg-nerd-font"
cask "font-sf-mono"

# ==============================================================================
# Mac App Store Applications
# ==============================================================================
mas "BetterSnapTool", id: 417375580
mas "CleanMyMac", id: 1339170533
mas "GarageBand", id: 682658836
mas "HP Smart", id: 1474276998
mas "iMovie", id: 408981434
mas "Keynote", id: 409183694
mas "Microsoft PowerPoint", id: 462062816
mas "Numbers", id: 409203825
mas "Pages", id: 409201541
mas "Paste", id: 967805235
mas "Slack", id: 803453959
mas "Xcode", id: 497799835
mas "Developer", id: 640199958
mas "TestFlight", id: 899247664
mas "Amphetamine", id: 937984704
mas "Magnet", id: 441258766
mas "Hidden Bar", id: 1452453066
mas "RunCat", id: 1429033973

# ==============================================================================
# VS Code Extensions
# ==============================================================================
vscode "ms-vsliveshare.vsliveshare"
vscode "github.copilot"
vscode "github.copilot-chat"
vscode "ms-python.python"
vscode "ms-python.vscode-pylance"
vscode "dbaeumer.vscode-eslint"
vscode "esbenp.prettier-vscode"
vscode "bradlc.vscode-tailwindcss"
vscode "eamodio.gitlens"
vscode "usernamehw.errorlens"
vscode "pkief.material-icon-theme"
vscode "catppuccin.catppuccin-vsc"
