# ==============================================================================
# Path Configuration
# ==============================================================================

# Function to add to PATH if directory exists
path_prepend() {
    [[ -d "$1" ]] && path=("$1" $path)
}

path_append() {
    [[ -d "$1" ]] && path+=("$1")
}

# Remove duplicates from PATH
typeset -U path

# System paths (lowest priority)
path_append "/usr/local/bin"
path_append "/usr/bin"
path_append "/bin"
path_append "/usr/sbin"
path_append "/sbin"

# Homebrew GNU utilities (override system commands)
path_prepend "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"
path_prepend "$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin"
path_prepend "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin"
path_prepend "$HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnubin"
path_prepend "$HOMEBREW_PREFIX/opt/grep/libexec/gnubin"
path_prepend "$HOMEBREW_PREFIX/opt/gawk/libexec/gnubin"

# Homebrew binaries
path_prepend "$HOMEBREW_PREFIX/bin"
path_prepend "$HOMEBREW_PREFIX/sbin"

# Language-specific paths
path_prepend "$HOMEBREW_PREFIX/opt/mysql@8.0/bin"
path_prepend "$HOMEBREW_PREFIX/opt/openjdk/bin"
path_prepend "$HOMEBREW_PREFIX/opt/postgresql@14/bin"

# Runtime managers
path_prepend "$CARGO_HOME/bin"
path_prepend "$GOPATH/bin"

# User paths (highest priority)
path_prepend "$HOME/.local/bin"
path_prepend "$DOTFILES/bin"

export PATH
