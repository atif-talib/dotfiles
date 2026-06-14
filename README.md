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

## Install

```sh
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh            # symlink everything
./install.sh nvim tmux  # or pick packages
```

`install.sh` symlinks each package into `$HOME` and backs up anything it
would overwrite to `~/.dotfiles-backup/<timestamp>/`. No GNU Stow required,
but `stow nvim tmux ...` works too.

## Post-install

| Tool     | Step |
|----------|------|
| tmux     | Install [TPM](https://github.com/tmux-plugins/tpm), then `prefix` + <kbd>I</kbd> to fetch plugins |
| nvim     | Launch `nvim`; lazy.nvim syncs plugins from `lazy-lock.json` |
| starship | `brew install starship`; `$STARSHIP_CONFIG` must point at `~/.config/starship/starship.toml` |
| zsh      | Needs `fzf`, `zoxide`, `eza`, `zsh-syntax-highlighting`, `zsh-autosuggestions` (via brew) |

## Notes

- Active starship config is `~/.config/starship/starship.toml` (set via `STARSHIP_CONFIG` in `.zshrc`).
- tmux plugins and nvim's vendored `.git` are intentionally excluded — see `.gitignore`.
