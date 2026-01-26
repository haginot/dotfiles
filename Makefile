# ==============================================================================
# Dotfiles Makefile
# ==============================================================================
# Usage: make [target]
# ==============================================================================

.PHONY: all install link brew macos apps tools shell update clean test help

SHELL := /bin/bash
DOTFILES := $(shell pwd)

# Colors
BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[0;33m
NC := \033[0m

# Default target
all: install

# ==============================================================================
# Installation
# ==============================================================================

## install: Full installation (default)
install:
	@./setup.sh all

## link: Create symlinks only
link:
	@./setup.sh link

## brew: Install Homebrew and packages
brew:
	@./setup.sh brew

## macos: Configure macOS settings
macos:
	@./setup.sh macos

## apps: Install Mac App Store apps
apps:
	@./setup.sh apps

## tools: Setup development tools
tools:
	@./setup.sh tools

## shell: Setup shell configuration
shell:
	@./setup.sh shell

# ==============================================================================
# Package Management
# ==============================================================================

## update: Update all packages
update:
	@echo -e "$(BLUE)Updating Homebrew...$(NC)"
	@brew update
	@echo -e "$(BLUE)Upgrading packages...$(NC)"
	@brew upgrade
	@echo -e "$(BLUE)Upgrading casks...$(NC)"
	@brew upgrade --cask --greedy
	@echo -e "$(BLUE)Cleaning up...$(NC)"
	@brew cleanup
	@echo -e "$(BLUE)Updating mise tools...$(NC)"
	@mise upgrade --yes 2>/dev/null || true
	@echo -e "$(GREEN)Update complete!$(NC)"

## brew-dump: Export current packages to Brewfile
brew-dump:
	@echo -e "$(BLUE)Exporting Brewfile...$(NC)"
	@brew bundle dump --file=Brewfile --force --describe
	@echo -e "$(GREEN)Brewfile updated!$(NC)"

## brew-check: Check Brewfile packages
brew-check:
	@brew bundle check --file=Brewfile

## brew-cleanup: Remove packages not in Brewfile
brew-cleanup:
	@brew bundle cleanup --file=Brewfile

## brew-outdated: Show outdated packages
brew-outdated:
	@echo -e "$(BLUE)Outdated formulas:$(NC)"
	@brew outdated --formula
	@echo ""
	@echo -e "$(BLUE)Outdated casks:$(NC)"
	@brew outdated --cask

# ==============================================================================
# Development
# ==============================================================================

## mise-install: Install mise tools
mise-install:
	@mise install --yes

## mise-update: Update mise tools
mise-update:
	@mise upgrade --yes

# ==============================================================================
# Utilities
# ==============================================================================

## clean: Remove backup files
clean:
	@echo -e "$(YELLOW)Removing backup files...$(NC)"
	@rm -rf ~/.dotfiles_backup
	@echo -e "$(GREEN)Cleanup complete!$(NC)"

## test: Test shell configuration
test:
	@echo -e "$(BLUE)Testing shell configuration...$(NC)"
	@zsh -n $(DOTFILES)/shell/zshrc && echo -e "$(GREEN)zshrc: OK$(NC)" || echo -e "$(RED)zshrc: FAIL$(NC)"
	@zsh -n $(DOTFILES)/shell/zshenv && echo -e "$(GREEN)zshenv: OK$(NC)" || echo -e "$(RED)zshenv: FAIL$(NC)"
	@zsh -n $(DOTFILES)/shell/aliases.zsh && echo -e "$(GREEN)aliases: OK$(NC)" || echo -e "$(RED)aliases: FAIL$(NC)"
	@zsh -n $(DOTFILES)/shell/functions.zsh && echo -e "$(GREEN)functions: OK$(NC)" || echo -e "$(RED)functions: FAIL$(NC)"

## doctor: Check dotfiles health
doctor:
	@echo -e "$(BLUE)Checking dotfiles health...$(NC)"
	@echo ""
	@echo "Symlinks:"
	@[ -L ~/.zshrc ] && echo "  ✓ ~/.zshrc" || echo "  ✗ ~/.zshrc"
	@[ -L ~/.zshenv ] && echo "  ✓ ~/.zshenv" || echo "  ✗ ~/.zshenv"
	@[ -L ~/.config/git/config ] && echo "  ✓ ~/.config/git/config" || echo "  ✗ ~/.config/git/config"
	@[ -L ~/.config/starship.toml ] && echo "  ✓ ~/.config/starship.toml" || echo "  ✗ ~/.config/starship.toml"
	@echo ""
	@echo "Tools:"
	@command -v brew >/dev/null && echo "  ✓ Homebrew" || echo "  ✗ Homebrew"
	@command -v mise >/dev/null && echo "  ✓ mise" || echo "  ✗ mise"
	@command -v starship >/dev/null && echo "  ✓ starship" || echo "  ✗ starship"
	@command -v fzf >/dev/null && echo "  ✓ fzf" || echo "  ✗ fzf"
	@command -v delta >/dev/null && echo "  ✓ delta" || echo "  ✗ delta"

## backup: Create a backup of current dotfiles
backup:
	@echo -e "$(BLUE)Creating backup...$(NC)"
	@mkdir -p ~/.dotfiles_backup/manual
	@cp -r ~/.zshrc ~/.dotfiles_backup/manual/ 2>/dev/null || true
	@cp -r ~/.zshenv ~/.dotfiles_backup/manual/ 2>/dev/null || true
	@cp -r ~/.gitconfig ~/.dotfiles_backup/manual/ 2>/dev/null || true
	@cp -r ~/.config ~/.dotfiles_backup/manual/ 2>/dev/null || true
	@echo -e "$(GREEN)Backup created at ~/.dotfiles_backup/manual/$(NC)"

# ==============================================================================
# Help
# ==============================================================================

## help: Show this help message
help:
	@echo ""
	@echo "Dotfiles Makefile"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Installation:"
	@grep -E '^## ' $(MAKEFILE_LIST) | grep -E '(install|link|brew|macos|apps|tools|shell):' | \
		sed -E 's/^## /  /' | sed -E 's/: /\t/'
	@echo ""
	@echo "Package Management:"
	@grep -E '^## ' $(MAKEFILE_LIST) | grep -E '(update|brew-):' | \
		sed -E 's/^## /  /' | sed -E 's/: /\t/'
	@echo ""
	@echo "Development:"
	@grep -E '^## ' $(MAKEFILE_LIST) | grep -E 'mise-' | \
		sed -E 's/^## /  /' | sed -E 's/: /\t/'
	@echo ""
	@echo "Utilities:"
	@grep -E '^## ' $(MAKEFILE_LIST) | grep -E '(clean|test|doctor|backup|help):' | \
		sed -E 's/^## /  /' | sed -E 's/: /\t/'
	@echo ""
