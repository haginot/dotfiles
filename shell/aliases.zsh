# ==============================================================================
# Aliases
# ==============================================================================

# ------------------------------------------------------------------------------
# Core Replacements
# ------------------------------------------------------------------------------
# Use modern alternatives if available
if command -v eza &>/dev/null; then
    alias ls='eza --icons --group-directories-first'
    alias ll='eza -la --icons --group-directories-first --git'
    alias la='eza -a --icons --group-directories-first'
    alias lt='eza -T --icons --level=2'
    alias lta='eza -Ta --icons --level=2'
else
    alias ls='ls --color=auto'
    alias ll='ls -lah'
    alias la='ls -A'
fi

if command -v bat &>/dev/null; then
    alias cat='bat --paging=never'
    alias catp='bat --plain --paging=never'
fi

if command -v trash &>/dev/null; then
    alias rm='trash'
fi

if command -v zoxide &>/dev/null; then
    alias cd='z'
fi

# ------------------------------------------------------------------------------
# Navigation
# ------------------------------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'
alias -- -='cd -'

# Quick access
alias dl='cd ~/Downloads'
alias dt='cd ~/Desktop'
alias dev='cd ~/dev'
alias dot='cd $DOTFILES'

# ------------------------------------------------------------------------------
# Git
# ------------------------------------------------------------------------------
alias g='git'
alias gs='git status -sb'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gd='git diff'
alias gds='git diff --staged'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpl='git pull'
alias gplr='git pull --rebase'
alias gl='git log --oneline -20'
alias glg='git log --graph --oneline --decorate'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gst='git stash'
alias gstp='git stash pop'
alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias grb='git rebase'
alias grbi='git rebase -i'
alias gm='git merge'
alias gcp='git cherry-pick'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias gclean='git clean -fd'

# lazygit
alias lg='lazygit'

# ------------------------------------------------------------------------------
# Docker
# ------------------------------------------------------------------------------
alias d='docker'
alias dc='docker compose'
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcr='docker compose restart'
alias dcl='docker compose logs -f'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'
alias drm='docker rm $(docker ps -aq)'
alias drmi='docker rmi $(docker images -q)'
alias dprune='docker system prune -af'

# ------------------------------------------------------------------------------
# Python
# ------------------------------------------------------------------------------
alias py='python3'
alias pip='pip3'
alias venv='python3 -m venv'
alias activate='source .venv/bin/activate'
alias pir='pip install -r requirements.txt'

# uv
alias uvv='uv venv && source .venv/bin/activate'
alias uvs='uv sync'
alias uvr='uv run'

# ------------------------------------------------------------------------------
# Node.js
# ------------------------------------------------------------------------------
alias ni='npm install'
alias nid='npm install -D'
alias nig='npm install -g'
alias nr='npm run'
alias ns='npm start'
alias nt='npm test'
alias nb='npm run build'

alias yi='yarn install'
alias ya='yarn add'
alias yad='yarn add -D'
alias yr='yarn run'

alias pi='pnpm install'
alias pa='pnpm add'
alias pad='pnpm add -D'
alias pr='pnpm run'

alias buni='bun install'
alias buna='bun add'
alias bunad='bun add -D'
alias bunr='bun run'

# ------------------------------------------------------------------------------
# Terraform
# ------------------------------------------------------------------------------
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfaa='terraform apply -auto-approve'
alias tfd='terraform destroy'
alias tff='terraform fmt -recursive'
alias tfv='terraform validate'

# ------------------------------------------------------------------------------
# Kubernetes
# ------------------------------------------------------------------------------
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kl='kubectl logs -f'
alias kex='kubectl exec -it'
alias kctx='kubectx'
alias kns='kubens'

# ------------------------------------------------------------------------------
# macOS Specific
# ------------------------------------------------------------------------------
alias o='open'
alias oo='open .'
alias finder='open -a Finder'
alias chrome='open -a "Google Chrome"'
alias cursor='open -a Cursor'
# Note: 'code' command is provided by brew-wrap for VS Code extension management
# Use 'vscode' alias if you just want to open VS Code
alias vscode='open -a "Visual Studio Code"'

# Clipboard
alias pbp='pbpaste'
alias pbc='pbcopy'

# System
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'
alias wifi='networksetup -setairportpower en0'
alias ip='ipconfig getifaddr en0'
alias localip='ipconfig getifaddr en0'
alias publicip='curl -s ifconfig.me'

# Power management
alias sleepnow='pmset sleepnow'
alias caffeinate='caffeinate -d'

# ------------------------------------------------------------------------------
# Utilities
# ------------------------------------------------------------------------------
# Reload shell
alias reload='exec $SHELL -l'
alias rl='reload'

# Edit configs
alias zshrc='$EDITOR $DOTFILES/shell/zshrc'
alias aliases='$EDITOR $DOTFILES/shell/aliases.zsh'

# Quick look
alias ql='qlmanage -p'

# Network
alias ports='netstat -tulanp 2>/dev/null || lsof -i -n -P'
alias listening='lsof -i -n -P | grep LISTEN'

# Disk usage
alias du='du -h'
alias df='df -h'
alias duf='du -sh * | sort -h'

# Date/time
alias now='date +"%Y-%m-%d %H:%M:%S"'
alias week='date +%V'
alias timestamp='date +%s'

# Generate random string
alias randstr='openssl rand -base64 32'
alias uuid='uuidgen'

# Weather
alias weather='curl -s "wttr.in/?format=3"'

# ------------------------------------------------------------------------------
# Safety Nets
# ------------------------------------------------------------------------------
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias ln='ln -iv'

# ------------------------------------------------------------------------------
# Fun / Misc
# ------------------------------------------------------------------------------
alias please='sudo'
alias fucking='sudo'
alias shrug='echo "¯\_(ツ)_/¯" | pbcopy && echo "¯\_(ツ)_/¯"'
