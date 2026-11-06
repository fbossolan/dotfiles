# dotfiles

Config files for zsh, tmux, Neovim, ranger, aerospace and Ghostty.

## Principle: keep it simple

- Each application is a GNU Stow package whose tree mirrors its destination under `$HOME`.
- Plain symlinks, created by GNU Stow.
- No plugins in Neovim. Tmux and Vim are configured by hand, in plain text.
- Secrets never go in this repo.

## Layout

```
dotfiles/
├── Brewfile                # packages (brew bundle)
├── zsh/.zshrc              -> ~/.zshrc
├── zsh/.zsh/config.zsh     -> ~/.zsh/config.zsh
├── zsh/.zsh/aliases.zsh    -> ~/.zsh/aliases.zsh
├── tmux/.tmux.conf         -> ~/.tmux.conf
├── nvim/.config/nvim/init.lua -> ~/.config/nvim/init.lua
├── ranger/.config/ranger/rc.conf -> ~/.config/ranger/rc.conf
├── aerospace/.config/aerospace/aerospace.toml -> ~/.config/aerospace/aerospace.toml
└── ghostty/Library/Application Support/com.mitchellh.ghostty/config.ghostty
                              -> ~/Library/Application Support/com.mitchellh.ghostty/config.ghostty
```

Each top-level application directory is a Stow package. To add a config, add it
under the package directory using the path it should have below `$HOME`.

## Permissions

- **GNU Stow must be installed.** On macOS, use `brew install stow`.
- **`~/.secrets` must be private.** Create it with `chmod 600`, as shown in section 3:
  ```bash
  chmod 600 ~/.secrets
  ```
- **aerospace needs Accessibility access.** Open aerospace once, then allow it in **System Settings → Privacy & Security → Accessibility**. Without it, aerospace can't move windows.
- Stow writes symlinks only within your home folder. It does not automatically back up conflicting files; inspect conflicts and move them aside before running it.

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

# GNU Stow
brew install stow
```

## Install with Stow directly

Run these commands from the repository root. To install one package, such as
Neovim:

```bash
cd ~/dotfiles
stow --dir="$PWD" --target="$HOME" --restow nvim
```

Replace `nvim` with `zsh`, `tmux`, `ranger`, `aerospace`, or `ghostty` to
install another package. To preview it, add `--no --verbose=1`:

```bash
stow --dir="$PWD" --target="$HOME" --restow --no --verbose=1 nvim
```

To install all packages:

```bash
stow --dir="$PWD" --target="$HOME" --restow */
```

The `*/` expands only to the Stow package directories, so files such as
`README.md` and `Brewfile` are not installed. Do not use
`stow .`; the repository root is not a package.

## 2. Using GNU Stow

- `--restow` refreshes links safely if a package has changed.
- `--no --verbose=1` previews changes without modifying anything.
- Stow reports conflicts instead of overwriting existing files. Move conflicting real files aside, then rerun the command.

If this repository was previously installed with the old linker, remove only the
old symlinks before running Stow. They point to paths that no longer exist:

```bash
unlink ~/.zshrc
unlink ~/.tmux.conf
unlink ~/.config/nvim/init.lua
unlink ~/.config/ranger/rc.conf
unlink ~/.config/aerospace/aerospace.toml
unlink "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
```

Only run these commands if those paths are old symlinks into this repository. Do
not use them if they are real files; move real files aside first so Stow can
report any remaining conflicts safely.

## 3. Secrets

Tokens and keys live in `~/.secrets`, outside the repo. `zsh/.zshrc` loads it when it exists.

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

The layout follows GNU Stow's package convention: each package mirrors the destination tree, while packages and secrets remain separate. chezmoi would be the next step if this needed per-machine templates or built-in secret management.
