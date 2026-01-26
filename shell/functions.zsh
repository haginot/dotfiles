# ==============================================================================
# Shell Functions
# ==============================================================================

# ------------------------------------------------------------------------------
# File & Directory Operations
# ------------------------------------------------------------------------------

# Create directory and cd into it
mkcd() {
    mkdir -p "$@" && cd "$_"
}

# Create a temporary directory and cd into it
tmpd() {
    local dir
    dir=$(mktemp -d)
    echo "Created: $dir"
    cd "$dir"
}

# Extract any archive
extract() {
    if [[ -f "$1" ]]; then
        case "$1" in
            *.tar.bz2)  tar xjf "$1"     ;;
            *.tar.gz)   tar xzf "$1"     ;;
            *.tar.xz)   tar xJf "$1"     ;;
            *.bz2)      bunzip2 "$1"     ;;
            *.rar)      unrar x "$1"     ;;
            *.gz)       gunzip "$1"      ;;
            *.tar)      tar xf "$1"      ;;
            *.tbz2)     tar xjf "$1"     ;;
            *.tgz)      tar xzf "$1"     ;;
            *.zip)      unzip "$1"       ;;
            *.Z)        uncompress "$1"  ;;
            *.7z)       7z x "$1"        ;;
            *)          echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Create a backup of a file
backup() {
    cp -v "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"
}

# ------------------------------------------------------------------------------
# Git Functions
# ------------------------------------------------------------------------------

# Clone and cd into repo
gclone() {
    git clone "$1" && cd "$(basename "$1" .git)"
}

# Interactive branch delete
gbdel() {
    git branch | fzf --multi | xargs -r git branch -d
}

# Interactive checkout
gch() {
    local branch
    branch=$(git branch --all | fzf --height=40% | tr -d '[:space:]' | sed 's/remotes\/origin\///')
    [[ -n "$branch" ]] && git checkout "$branch"
}

# Show git branch in prompt-friendly format
git_branch() {
    git branch 2>/dev/null | grep '^\*' | sed 's/^\* //'
}

# Quick commit with message
gqc() {
    git add -A && git commit -m "${1:-Quick commit}"
}

# ------------------------------------------------------------------------------
# Development
# ------------------------------------------------------------------------------

# Serve current directory
serve() {
    local port="${1:-8000}"
    python3 -m http.server "$port"
}

# JSON pretty print
json() {
    if [[ -t 0 ]]; then
        python3 -m json.tool <<< "$*" | bat -l json
    else
        python3 -m json.tool | bat -l json
    fi
}

# Find process by name
psg() {
    ps aux | grep -v grep | grep -i "$1"
}

# Kill process by name
killp() {
    ps aux | grep -v grep | grep -i "$1" | awk '{print $2}' | xargs kill -9
}

# Port killer
killport() {
    lsof -ti:"$1" | xargs kill -9 2>/dev/null || echo "No process on port $1"
}

# ------------------------------------------------------------------------------
# Docker Functions
# ------------------------------------------------------------------------------

# Docker shell into container
dsh() {
    docker exec -it "$1" /bin/sh
}

# Docker bash into container
dbash() {
    docker exec -it "$1" /bin/bash
}

# Docker logs follow
dlogs() {
    docker logs -f "$1"
}

# ------------------------------------------------------------------------------
# FZF Enhanced Functions
# ------------------------------------------------------------------------------

# Interactive file finder and editor
fe() {
    local file
    file=$(fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' --height=80%)
    [[ -n "$file" ]] && ${EDITOR:-vim} "$file"
}

# Interactive directory changer
fcd() {
    local dir
    dir=$(fd --type d --hidden --exclude .git | fzf --preview 'eza -la --icons {}' --height=80%)
    [[ -n "$dir" ]] && cd "$dir"
}

# Interactive history search
fh() {
    local cmd
    cmd=$(history | fzf --tac --height=40% | sed 's/^ *[0-9]* *//')
    [[ -n "$cmd" ]] && print -z "$cmd"
}

# Interactive process killer
fkill() {
    local pid
    pid=$(ps -ef | sed 1d | fzf --multi --height=40% | awk '{print $2}')
    [[ -n "$pid" ]] && echo "$pid" | xargs kill -9
}

# Interactive brew install
fbrew() {
    local pkg
    pkg=$(brew formulae | fzf --multi --preview 'brew info {}' --height=80%)
    [[ -n "$pkg" ]] && brew install $(echo "$pkg" | tr '\n' ' ')
}

# Interactive brew cask install
fcask() {
    local cask
    cask=$(brew casks | fzf --multi --preview 'brew info --cask {}' --height=80%)
    [[ -n "$cask" ]] && brew install --cask $(echo "$cask" | tr '\n' ' ')
}

# ------------------------------------------------------------------------------
# macOS Functions
# ------------------------------------------------------------------------------

# Quick note
note() {
    local note_dir="$HOME/Documents/notes"
    mkdir -p "$note_dir"
    local note_file="$note_dir/$(date +%Y-%m-%d).md"
    if [[ -n "$1" ]]; then
        echo "- $(date +%H:%M) $*" >> "$note_file"
    else
        ${EDITOR:-vim} "$note_file"
    fi
}

# Show all macOS hidden files
showallfiles() {
    defaults write com.apple.finder AppleShowAllFiles -bool true
    killall Finder
}

# Hide all macOS hidden files
hideallfiles() {
    defaults write com.apple.finder AppleShowAllFiles -bool false
    killall Finder
}

# Open man page in Preview
manpdf() {
    man -t "$1" | open -f -a Preview
}

# Notification when command completes
notify() {
    local last_status=$?
    local title="${1:-Command}"
    if [[ $last_status -eq 0 ]]; then
        osascript -e "display notification \"Completed successfully\" with title \"$title\""
    else
        osascript -e "display notification \"Failed with status $last_status\" with title \"$title\""
    fi
}

# Get bundle identifier of an app
bundleid() {
    osascript -e "id of app \"$1\""
}

# ------------------------------------------------------------------------------
# Utilities
# ------------------------------------------------------------------------------

# Calculator
calc() {
    echo "scale=4; $*" | bc
}

# Weather in terminal
wttr() {
    curl -s "wttr.in/${1:-Tokyo}?format=v2"
}

# Cheat sheet
cheat() {
    curl -s "cheat.sh/$1"
}

# QR code generator
qr() {
    echo "$1" | curl -s -F-=\<- qrenco.de
}

# Shorten URL
short() {
    curl -s "https://is.gd/create.php?format=simple&url=$1"
}

# Get public IP info
ipinfo() {
    curl -s "ipinfo.io${1:+/$1}" | jq
}

# Colorize help output
help() {
    "$@" --help 2>&1 | bat --plain --language=help
}

# ------------------------------------------------------------------------------
# Path & Debug
# ------------------------------------------------------------------------------

# Pretty print PATH
path() {
    echo $PATH | tr ':' '\n' | nl
}

# Find command location in PATH
whichall() {
    type -a "$1"
}
