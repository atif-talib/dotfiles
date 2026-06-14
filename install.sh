#!/usr/bin/env bash
#
# Symlink dotfiles into $HOME using a GNU Stow-compatible layout.
# Each top-level dir is a "package"; its contents mirror paths relative to $HOME.
# Existing files are backed up to ~/.dotfiles-backup/<timestamp>/ before linking.
#
# Usage:
#   ./install.sh            # link all packages
#   ./install.sh nvim tmux  # link only the named packages
#   stow nvim tmux          # equivalent, if you have GNU Stow installed

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

PACKAGES=("$@")
if [ ${#PACKAGES[@]} -eq 0 ]; then
  PACKAGES=(nvim tmux starship wezterm zsh bash git)
fi

link_package() {
  local pkg="$1"
  local pkg_dir="$DOTFILES_DIR/$pkg"
  [ -d "$pkg_dir" ] || { echo "skip: no package '$pkg'"; return; }

  while IFS= read -r -d '' src; do
    local rel="${src#"$pkg_dir"/}"
    local dest="$HOME/$rel"

    mkdir -p "$(dirname "$dest")"

    # Already correctly linked.
    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
      echo "ok:   $dest"
      continue
    fi

    # Back up anything in the way.
    if [ -e "$dest" ] || [ -L "$dest" ]; then
      mkdir -p "$(dirname "$BACKUP_DIR/$rel")"
      mv "$dest" "$BACKUP_DIR/$rel"
      echo "bak:  $dest -> $BACKUP_DIR/$rel"
    fi

    ln -s "$src" "$dest"
    echo "link: $dest -> $src"
  done < <(find "$pkg_dir" -type f -print0)
}

for pkg in "${PACKAGES[@]}"; do
  echo "== $pkg =="
  link_package "$pkg"
done

echo
echo "Done. Backups (if any): $BACKUP_DIR"
