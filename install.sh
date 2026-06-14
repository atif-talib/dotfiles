#!/usr/bin/env bash
#
# Symlink dotfiles into $HOME using a GNU Stow-compatible layout.
# Each top-level dir is a "package"; its contents mirror paths relative to $HOME.
#
# NON-DESTRUCTIVE: anything that already exists at the destination is left
# untouched and skipped. This script only ADDS new symlinks; it never moves,
# overwrites, or deletes existing files. Re-run safe.
#
# Usage:
#   ./install.sh            # link all packages
#   ./install.sh nvim tmux  # link only the named packages
#   stow nvim tmux          # equivalent, if you have GNU Stow installed

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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

    # Already correctly linked.
    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
      echo "ok:   $dest"
      continue
    fi

    # NON-DESTRUCTIVE: never touch an existing file/dir/symlink. Skip it.
    if [ -e "$dest" ] || [ -L "$dest" ]; then
      echo "skip: $dest (already exists, left untouched)"
      continue
    fi

    mkdir -p "$(dirname "$dest")"
    ln -s "$src" "$dest"
    echo "link: $dest -> $src"
  done < <(find "$pkg_dir" -type f -print0)
}

for pkg in "${PACKAGES[@]}"; do
  echo "== $pkg =="
  link_package "$pkg"
done

echo
echo "Done. Existing files were left untouched (see 'skip:' lines above)."
