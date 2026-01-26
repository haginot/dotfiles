#!/bin/bash
# ==============================================================================
# Dotfiles Setup Script
# ==============================================================================
# Usage: ./setup.sh [options]
#
# Options:
#   all       Full setup (default)
#   link      Create symlinks only
#   brew      Install Homebrew and packages
#   macos     Configure macOS settings
#   apps      Install App Store apps
#   tools     Setup development tools
#   fonts     Install fonts
#   help      Show this help message
# ==============================================================================

set -e

# Script directory
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES

# Backup directory
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

# XDG directories
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# ------------------------------------------------------------------------------
# Colors & Logging
# ------------------------------------------------------------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warn()    { echo -e "${YELLOW}[WARNING]${NC} $1"; }
error()   { echo -e "${RED}[ERROR]${NC} $1"; }
header()  { echo -e "\n${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"; echo -e "${PURPLE}  $1${NC}"; echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"; }

# ------------------------------------------------------------------------------
# Helper Functions
# ------------------------------------------------------------------------------

# Check if command exists
has() {
    command -v "$1" &>/dev/null
}

# Backup and remove existing file/directory
backup_and_remove() {
    local target="$1"
    if [[ -e "$target" ]] && [[ ! -L "$target" ]]; then
        mkdir -p "$BACKUP_DIR"
        mv "$target" "$BACKUP_DIR/"
        warn "Backed up $target to $BACKUP_DIR/"
    elif [[ -L "$target" ]]; then
        rm "$target"
    fi
}

# Create symlink
link_file() {
    local src="$1"
    local dest="$2"

    backup_and_remove "$dest"
    mkdir -p "$(dirname "$dest")"
    ln -sf "$src" "$dest"
    success "Linked $dest → $src"
}

# ------------------------------------------------------------------------------
# Installation Functions
# ------------------------------------------------------------------------------

install_xcode_tools() {
    header "Installing Xcode Command Line Tools"

    if xcode-select -p &>/dev/null; then
        success "Xcode Command Line Tools already installed"
    else
        info "Installing Xcode Command Line Tools..."
        xcode-select --install

        # Wait for installation
        until xcode-select -p &>/dev/null; do
            sleep 5
        done
        success "Xcode Command Line Tools installed"
    fi
}

install_homebrew() {
    header "Installing Homebrew"

    if has brew; then
        success "Homebrew already installed"
        info "Updating Homebrew..."
        brew update
    else
        info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Add to PATH for Apple Silicon
        if [[ $(uname -m) == "arm64" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
        success "Homebrew installed"
    fi

    # Disable analytics
    brew analytics off
}

install_packages() {
    header "Installing Packages from Brewfile"

    if [[ -f "$DOTFILES/Brewfile" ]]; then
        info "Installing packages (this may take a while)..."
        brew bundle install --file="$DOTFILES/Brewfile" --no-lock

        info "Cleaning up..."
        brew cleanup

        success "Packages installed"
    else
        error "Brewfile not found!"
        return 1
    fi
}

install_mas_apps() {
    header "Installing Mac App Store Apps"

    if ! has mas; then
        error "mas is not installed. Run 'brew install mas' first."
        return 1
    fi

    # Check if signed in
    if ! mas account &>/dev/null; then
        warn "Not signed into Mac App Store."
        warn "Please sign in manually and re-run this script."
        return 0
    fi

    info "Installing App Store apps from Brewfile..."
    brew bundle install --file="$DOTFILES/Brewfile" --no-lock

    success "App Store apps installed"
}

setup_symlinks() {
    header "Creating Symlinks"

    # Create XDG directories
    mkdir -p "$XDG_CONFIG_HOME"
    mkdir -p "$XDG_DATA_HOME"
    mkdir -p "$XDG_STATE_HOME"
    mkdir -p "$XDG_CACHE_HOME"
    mkdir -p "$HOME/.local/bin"

    # Shell
    link_file "$DOTFILES/shell/zshenv" "$HOME/.zshenv"
    link_file "$DOTFILES/shell/zshrc" "$HOME/.zshrc"

    # Git
    mkdir -p "$XDG_CONFIG_HOME/git"
    link_file "$DOTFILES/config/git/config" "$XDG_CONFIG_HOME/git/config"
    link_file "$DOTFILES/config/git/ignore" "$XDG_CONFIG_HOME/git/ignore"

    # Starship
    link_file "$DOTFILES/config/starship/starship.toml" "$XDG_CONFIG_HOME/starship.toml"

    # mise
    mkdir -p "$XDG_CONFIG_HOME/mise"
    link_file "$DOTFILES/config/mise/config.toml" "$XDG_CONFIG_HOME/mise/config.toml"

    # Ghostty
    mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"
    link_file "$DOTFILES/config/ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"

    # Karabiner
    mkdir -p "$XDG_CONFIG_HOME/karabiner"
    link_file "$DOTFILES/config/karabiner/karabiner.json" "$XDG_CONFIG_HOME/karabiner/karabiner.json"

    # Custom scripts
    if [[ -d "$DOTFILES/bin" ]]; then
        for script in "$DOTFILES/bin"/*; do
            if [[ -f "$script" ]]; then
                link_file "$script" "$HOME/.local/bin/$(basename "$script")"
            fi
        done
    fi

    success "Symlinks created"
}

setup_shell() {
    header "Setting up Shell"

    # Add Homebrew zsh to allowed shells
    local brew_zsh="$(brew --prefix)/bin/zsh"
    if [[ -f "$brew_zsh" ]]; then
        if ! grep -q "$brew_zsh" /etc/shells; then
            info "Adding Homebrew zsh to /etc/shells..."
            echo "$brew_zsh" | sudo tee -a /etc/shells >/dev/null
        fi

        # Set as default shell
        if [[ "$SHELL" != "$brew_zsh" ]]; then
            info "Setting Homebrew zsh as default shell..."
            chsh -s "$brew_zsh"
            success "Default shell changed to $brew_zsh"
        else
            success "Homebrew zsh is already the default shell"
        fi
    fi
}

setup_mise() {
    header "Setting up mise (Runtime Manager)"

    if has mise; then
        info "Installing default tools..."
        mise install --yes
        success "mise tools installed"
    else
        warn "mise not found. Install it first with 'brew install mise'"
    fi
}

setup_fzf() {
    header "Setting up fzf"

    if [[ -f "$(brew --prefix)/opt/fzf/install" ]]; then
        info "Installing fzf keybindings and completions..."
        "$(brew --prefix)/opt/fzf/install" --xdg --key-bindings --completion --no-update-rc --no-bash --no-fish
        success "fzf configured"
    fi
}

setup_git_delta() {
    header "Setting up git-delta themes"

    if has delta; then
        # Download Catppuccin theme for delta
        local themes_dir="$XDG_CONFIG_HOME/delta/themes"
        mkdir -p "$themes_dir"

        if [[ ! -f "$themes_dir/catppuccin.gitconfig" ]]; then
            info "Downloading Catppuccin theme for delta..."
            curl -fsSL "https://raw.githubusercontent.com/catppuccin/delta/main/catppuccin.gitconfig" -o "$themes_dir/catppuccin.gitconfig"
            success "Catppuccin theme downloaded"
        fi
    fi
}

setup_macos() {
    header "Configuring macOS Settings"

    if [[ -f "$DOTFILES/macos/defaults.sh" ]]; then
        chmod +x "$DOTFILES/macos/defaults.sh"
        "$DOTFILES/macos/defaults.sh"
    else
        error "macos/defaults.sh not found!"
    fi
}

# ------------------------------------------------------------------------------
# Main Functions
# ------------------------------------------------------------------------------

show_help() {
    cat << EOF
Dotfiles Setup Script

Usage: ./setup.sh [command]

Commands:
    all       Full setup - installs everything (default)
    link      Create symlinks only
    brew      Install Homebrew and packages
    macos     Configure macOS settings
    apps      Install App Store apps
    tools     Setup development tools (mise, fzf, etc.)
    shell     Setup shell configuration
    help      Show this help message

Examples:
    ./setup.sh          # Full setup
    ./setup.sh link     # Create symlinks only
    ./setup.sh brew     # Install Homebrew packages only

EOF
}

setup_all() {
    header "🚀 Starting Full Setup"

    install_xcode_tools
    install_homebrew
    install_packages
    setup_symlinks
    setup_shell
    setup_fzf
    setup_mise
    setup_git_delta
    install_mas_apps
    setup_macos

    header "✅ Setup Complete!"

    echo -e "${GREEN}Your dotfiles have been installed!${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Restart your terminal (or run: exec zsh)"
    echo "  2. Log out and back in for macOS settings"
    echo "  3. Open System Settings to verify preferences"
    echo ""
    echo "Useful commands:"
    echo "  make update    - Update all packages"
    echo "  make link      - Re-create symlinks"
    echo "  make help      - Show all available commands"
}

# ------------------------------------------------------------------------------
# Entry Point
# ------------------------------------------------------------------------------

main() {
    echo ""
    echo -e "${CYAN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║                                                           ║${NC}"
    echo -e "${CYAN}║              🏠 Dotfiles Setup Script                     ║${NC}"
    echo -e "${CYAN}║                                                           ║${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""

    local cmd="${1:-all}"

    case "$cmd" in
        all)      setup_all ;;
        link)     setup_symlinks ;;
        brew)     install_homebrew && install_packages ;;
        macos)    setup_macos ;;
        apps)     install_mas_apps ;;
        tools)    setup_fzf && setup_mise && setup_git_delta ;;
        shell)    setup_shell ;;
        help|-h|--help) show_help ;;
        *)
            error "Unknown command: $cmd"
            show_help
            exit 1
            ;;
    esac
}

main "$@"
