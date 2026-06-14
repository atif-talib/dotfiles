#!/usr/bin/env bash
#
# One-shot bootstrap for a fresh machine:
#   1. Install Homebrew (if missing)
#   2. Install all tools/deps from Brewfile
#   3. Install TPM (tmux plugin manager)
#   4. Symlink dotfiles into $HOME (delegates to install.sh)
#
# Usage on a new system:
#   git clone <repo-url> ~/dotfiles && ~/dotfiles/bootstrap.sh
#
# Idempotent: safe to re-run. Existing configs are backed up by install.sh.

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() { printf '\n\033[1;34m==>\033[0m %s\n' "$1"; }

# --- 1. Homebrew -------------------------------------------------------------
if ! command -v brew >/dev/null 2>&1; then
  log "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Make brew available in this shell (Apple Silicon vs Intel vs Linuxbrew).
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
else
  log "Homebrew already installed"
fi

# --- 2. Packages -------------------------------------------------------------
log "Installing packages from Brewfile"
brew bundle --file="$DOTFILES_DIR/Brewfile"

# --- 3. TPM (tmux plugin manager) -------------------------------------------
TPM_DIR="$HOME/.config/tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  log "Installing TPM"
  git clone --depth 1 https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
  log "TPM already installed"
fi

# --- 4. Symlink dotfiles -----------------------------------------------------
log "Symlinking dotfiles"
"$DOTFILES_DIR/install.sh"

log "Bootstrap complete"
cat <<'EOF'

Next steps:
  - Restart your shell:           exec zsh
  - Install tmux plugins:         open tmux, press <prefix> + I
  - First nvim launch syncs plugins automatically from lazy-lock.json
EOF
