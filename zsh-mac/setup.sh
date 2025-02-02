#!/usr/bin/env bash
set -euo pipefail

# --- Ensure Homebrew is installed ---
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found! Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Updating Homebrew..."
brew update

# --- Install essential command-line utilities and extra tools ---
echo "Installing command-line utilities..."
brew install \
    zoxide \
    fzf \
    bat \
    eza \
    fd \
    ripgrep \
    tldr \
    lazygit \
    gh \
    git-delta \
    htop \
    ncdu \
    procs \
    duf \
    httpie \
    starship \
    tmux \
    jq \
    yq \
    entr \
    direnv \
    neofetch \
    hyperfine \
    broot \
    tig \
    coreutils \
    moreutils \
    hstr \
    n \
    pnpm

# --- Install Zsh plugins ---
echo "Installing Zsh plugins..."
brew install zsh-autosuggestions zsh-syntax-highlighting

# --- Set up fzf key bindings and auto-completion ---
if [ -f "$(brew --prefix)/opt/fzf/install" ]; then
    echo "Setting up fzf..."
    # The --no-update-rc flag prevents fzf from modifying .zshrc automatically.
    "$(brew --prefix)/opt/fzf/install" --all --no-update-rc
fi

# --- Optionally, change the default shell to zsh if it's not already ---
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to zsh..."
    chsh -s "$(which zsh)"
fi

# --- Configure .zshrc ---
ZSHRC="${HOME}/.zshrc"

# Define markers for the custom Zsh configuration block.
START_MARKER="# === Custom Zsh Configuration Start ==="
END_MARKER="# === Custom Zsh Configuration End ==="

# Remove any previous custom block to avoid duplicates.
# Note: The following sed command is for macOS/BSD. For Linux, you may need to adjust it.
if grep -q "$START_MARKER" "$ZSHRC"; then
    sed -i '' "/$START_MARKER/,/$END_MARKER/d" "$ZSHRC"
fi

cat <<'EOF' >> "$ZSHRC"
# === Custom Zsh Configuration Start ===

# --- Locale and Terminal Settings ---
# Ensure proper UTF-8 encoding and terminal type for correct display of characters.
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color

# --- fzf Default Options ---
# These options help prevent output corruption and improve fzf's layout and preview.
export FZF_DEFAULT_OPTS="--ansi --height 40% --layout=reverse --border --preview 'bat --style=numbers --color=always {}'"

# --- Shell Options ---
# Automatically cd into directories by simply typing their name.
setopt autocd
# Correct minor mistakes in directory names and commands.
setopt correct
# Append to the history file, rather than overwriting it.
setopt append_history
# Share history among all open terminals.
setopt share_history
# Enable extended globbing for powerful pattern matching.
setopt extended_glob

# --- Aliases for Navigation and Productivity ---
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias cat='bat'
alias ls="eza --icons --group-directories-first"
alias ll="eza -lh"
alias la="eza -lha"
alias find="fd"
alias grep="rg"
alias du="duf"

# --- Git Aliases ---
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# --- Python Shortcuts ---
alias py='python3'
alias pip='pip3'

# --- AWS SSO Login Helper ---
# Usage:
#   awslogin <profile>   # Logs into the specified AWS SSO profile.
#   awslogin             # Presents an interactive selection if fzf is installed.
awslogin() {
    if [ -n "${1:-}" ]; then
        aws sso login --profile "$1"
    else
        if command -v fzf >/dev/null 2>&1 && [ -f "$HOME/.aws/config" ]; then
            local profile
            # Use awk to remove the "[profile " prefix and trailing "]" from each header.
            profile=$(awk '/^\[profile / {sub(/^\[profile /, ""); sub(/\]$/, ""); print}' "$HOME/.aws/config" | fzf --height 40% --border --prompt="AWS Profile > ")
            if [ -n "$profile" ]; then
                aws sso login --profile "$profile"
            else
                echo "No profile selected."
            fi
        else
            echo "Usage: awslogin <profile>"
        fi
    fi
}

# --- Docker Shortcuts ---
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias di='docker images'
alias dlogs='docker logs'
alias dstop='docker stop $(docker ps -q)'

# Clean up Docker resources: stopped containers, unused images, and networks.
docker_clean() {
    echo "Removing all stopped containers, unused images, and networks..."
    docker system prune -af
}

# --- Optional PATH Addition ---
if [ -d "$HOME/.era/bin" ]; then
    export PATH="$HOME/.era/bin:$PATH"
fi

# --- fzf Keybindings, Environment, and Completion ---
# Use fd for fast file searches, excluding heavy or irrelevant directories.
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules --exclude bower_components --exclude vendor'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

if [ -f "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh" ]; then
    source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
fi
if [ -f "$(brew --prefix)/opt/fzf/shell/completion.zsh" ]; then
    source "$(brew --prefix)/opt/fzf/shell/completion.zsh"
fi

# --- Zsh Plugins ---
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# --- Zoxide Setup ---
# Initialize zoxide with a jump command "j". This command updates your directory database.
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh --cmd j)"
else
    echo "Warning: zoxide is not installed or not in PATH."
fi

# Define alias for interactive zoxide query (after initialization).
alias z='zoxide query --interactive'

# --- Starship Prompt ---
# Initialize the Starship prompt for a fast, customizable shell prompt.
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
else
    echo "Warning: starship is not installed or not in PATH."
fi

# --- hstr for History Search ---
if command -v hstr &>/dev/null; then
    eval "$(hstr --show-configuration)"
fi

# --- direnv for Environment-Specific Variables ---
if command -v direnv &>/dev/null; then
    eval "$(direnv hook zsh)"
fi

# --- Node Version Management using n ---
# 'n' (installed via Homebrew) is now used for Node.js version management.
# To change Node versions, use: sudo n <version>
# (e.g., 'sudo n lts' to switch to the latest LTS release)
# No further initialization is required.

# --- Intercept npm Calls ---
# This function intercepts any calls to 'npm' and warns you to use 'pnpm' instead.
npm() {
    echo "WARNING: 'npm' is intercepted. Please use 'pnpm' instead." >&2
    return 1
}

# --- SCSS/CSS Build Shortcuts (Optional) ---
# Adjust these aliases to suit your project's build process.
alias scss="sass --watch src:dist"
alias buildcss="node-sass src -o dist"

# --- Source Local Customizations ---
# If you have any host- or user-specific tweaks, place them in ~/.zshrc.local.
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# === Custom Zsh Configuration End ===
EOF

echo "Installation complete! Restart your terminal or run 'exec zsh' to apply changes."