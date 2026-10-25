# dotfiles

Config files for zsh, tmux, Neovim, ranger, aerospace and Ghostty.

## Principle: keep it simple

- One file per config, at the top of its folder. No intermediate folders.
- Plain symlinks, created by one script with an explicit table. No tool to learn.
- No plugins in Neovim. Tmux and Vim are configured by hand, in plain text.
- Secrets never go in this repo.

## Layout

```
dotfiles/
├── install.sh              # creates the symlinks (and optionally installs packages)
├── Brewfile                # packages (brew bundle)
├── zsh/zshrc               -> ~/.zshrc
├── tmux/tmux.conf          -> ~/.tmux.conf
├── nvim/init.lua           -> ~/.config/nvim/init.lua
├── ranger/rc.conf          -> ~/.config/ranger/rc.conf
├── aerospace/aerospace.toml -> ~/.config/aerospace/aerospace.toml
└── ghostty/config.ghostty  -> ~/Library/Application Support/com.mitchellh.ghostty/config.ghostty
```

The mapping lives in `install.sh`. To add a config, add one `link` line there.

## Permissions

- **`install.sh` must be executable.** Git keeps the executable bit, so after a clone it already is. If it isn't (for example, the file was copied without it), run:
  ```bash
  chmod +x ~/dotfiles/install.sh
  ```
  You can also skip the bit entirely with `bash ~/dotfiles/install.sh`.
- **`~/.secrets` must be private.** Create it with `chmod 600`, as shown in section 3:
  ```bash
  chmod 600 ~/.secrets
  ```
- **aerospace needs Accessibility access.** Open aerospace once, then allow it in **System Settings → Privacy & Security → Accessibility**. Without it, aerospace can't move windows.
- The install script writes only to your home folder (`~/.config`, `~/Library/Application Support`) and to `~/dotfiles_bak`. It needs no `sudo`.

## 1. Install on a new Mac (Apple Silicon)

```bash
# Xcode Command Line Tools and Homebrew
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# clone the repo
git clone <your-remote-url> ~/dotfiles
cd ~/dotfiles

# packages from the Brewfile
brew bundle --file=Brewfile

# python: pyenv is used by zshrc
pyenv install 3.11.14
pyenv global 3.11.14

# links
./install.sh --dry-run   # preview
./install.sh             # apply
```

`./install.sh --brew` does the links and the `brew bundle` step in one go.

## 2. How the install script works

- Creates each symlink from the table in `install.sh`.
- If a real file or a different link is already in the destination, it is moved to `~/dotfiles_bak/pre-install/<timestamp>/`. Nothing is deleted.
- If the link already points to the right place, it is left alone. You can run it as many times as you want.

## 3. Secrets

Tokens and keys live in `~/.secrets`, outside the repo. `zsh/zshrc` loads it when it exists.

```bash
touch ~/.secrets && chmod 600 ~/.secrets
# add lines like: export SOME_TOKEN=...
```

`.gitignore` also excludes `.secrets`.

## 4. Things the configs expect outside the repo

- `~/.bash_profile`: sourced by `zshrc`. It is not in this repo.
- `~/scratch.txt` and `~/kb_shortcuts.txt`: opened from the tmux menu (`prefix m`). Create them if you want those entries to work.
- `nvm` is optional. `zshrc` only uses it when it is installed.

## 5. First run and checks

1. Open a new Ghostty window. It should load `config.ghostty`.
2. In tmux, press `prefix r` (`ctrl b`, then `r`) to reload the config.
3. Open Neovim on a Python file, then run `:checkhealth vim.lsp`. `basedpyright` and `ruff` should be attached.
4. Open aerospace once and grant it Accessibility permission in System Settings.
5. Authenticate the CLIs you use: `gh auth login`, `gcloud auth login`.

## 6. Manual steps (not in the repo)

- **Vimium** in Chrome: install the extension and import your settings JSON if you have one.
- **Chrome Sync** with your Google account for bookmarks and extensions.

## Keyboard reference

See `~/kb_shortcuts.txt` for Vim, tmux and app shortcuts.

## Background

The layout and the install script follow common dotfiles practice: explicit mappings, backups before linking, idempotent runs, and packages in a Brewfile. Stow was dropped because it needs the repo tree to mirror the destination, which conflicts with a flat layout. chezmoi would be the next step if this needed per-machine templates or built-in secret management.
