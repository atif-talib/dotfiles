# dotfiles

Personal macOS config, organized as [GNU Stow](https://www.gnu.org/software/stow/)-compatible packages.
Each top-level directory is a *package* whose contents mirror paths relative to `$HOME`.

## Layout

```
dotfiles/
├── nvim/      .config/nvim/      LazyVim setup (lua/, lazy-lock.json)
├── tmux/      .config/tmux/      tmux.conf (plugins via TPM, not tracked)
├── starship/  .config/starship/  starship.toml prompt
├── wezterm/   .wezterm.lua       WezTerm terminal config
├── zsh/       .zshrc .zprofile   zsh shell
├── bash/      .bashrc .bash_profile
└── git/       .gitconfig
```

## Install (fresh machine, one command)

```sh
git clone <repo-url> ~/dotfiles && ~/dotfiles/bootstrap.sh
```

`bootstrap.sh` does everything:

1. Installs Homebrew if missing
2. Installs all tools/deps from `Brewfile` (nvim, tmux, wezterm, starship, fzf, zoxide, eza, zsh plugins)
3. Installs [TPM](https://github.com/tmux-plugins/tpm) for tmux
4. Symlinks every dotfile into place (via `install.sh`)

Idempotent — safe to re-run.

## Symlink only (tools already installed)

```sh
cd ~/dotfiles
./install.sh            # link everything
./install.sh nvim tmux  # or pick packages
```

`install.sh` symlinks each package into `$HOME` and backs up anything it
would overwrite to `~/.dotfiles-backup/<timestamp>/`. No GNU Stow required,
but `stow nvim tmux ...` works too.

## Post-install

| Step | Action |
|------|--------|
| shell | `exec zsh` to reload |
| tmux  | open tmux, `prefix` + <kbd>I</kbd> to fetch plugins |
| nvim  | first launch syncs plugins from `lazy-lock.json` |

## Notes

- Active starship config is `~/.config/starship/starship.toml` (set via `STARSHIP_CONFIG` in `.zshrc`).
- tmux plugins and nvim's vendored `.git` are intentionally excluded — see `.gitignore`.
