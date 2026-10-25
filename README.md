# dotfiles

Config files for zsh, tmux, Neovim, ranger, aerospace and Ghostty, managed with GNU Stow.

```
dotfiles/
├── zsh/.zshrc
├── tmux/.tmux.conf
├── nvim/.config/nvim/init.lua
├── ranger/.config/ranger/rc.conf
├── aerospace/.config/aerospace/aerospace.toml
└── ghostty/Library/Application Support/com.mitchellh.ghostty/config.ghostty
```

Each top-level folder is a Stow package. `stow zsh` creates `~/.zshrc` as a symlink into this repo.

## 1. Base tools (macOS, Apple Silicon)

Install Xcode Command Line Tools and Homebrew first:

```bash
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Required by these dotfiles

```bash
brew install stow git tmux neovim ripgrep fzf lazygit gh ranger
brew install ruff basedpyright lua-language-server   # Python and Lua LSP
brew install pyenv                                  # used by .zshrc
brew install --cask aerospace ghostty
```

`fzf` needs 0.48 or newer, because `.zshrc` runs `fzf --zsh`.

### Other tools installed on this machine (not needed by the configs)

```bash
brew install python-lsp-server htop wget rsync glow pipx ffmpeg whisper.cpp
brew install docker docker-compose colima podman docker-credential-helper
brew install gemini-cli googleworkspace-cli flatbuffers slides reattach-to-user-namespace
brew install --cask claude-code codex copilot-cli gcloud-cli
```

`python-lsp-server` (pylsp) is no longer used by the Neovim config, which now runs basedpyright and ruff. It can be removed.

## 2. Python and Poetry

```bash
pyenv install 3.11.14
pyenv global 3.11.14
pipx install poetry
```

`.zshrc` runs `eval "$(pyenv init -)"`, so pyenv must be installed before opening a new shell. It also has a `pea` alias that uses `poetry`.

## 3. Install the dotfiles

Clone the repo to `~/dotfiles`:

```bash
git clone <your-remote-url> ~/dotfiles
```

Before the first `stow`, move any existing real files out of the way. Stow refuses to overwrite them:

```bash
mkdir -p ~/dotfiles_bak/pre-stow
mv ~/.zshrc ~/.tmux.conf ~/dotfiles_bak/pre-stow/ 2>/dev/null
mv ~/.config/nvim/init.lua ~/.config/ranger/rc.conf ~/.config/aerospace/aerospace.toml ~/dotfiles_bak/pre-stow/ 2>/dev/null
mv "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty" ~/dotfiles_bak/pre-stow/ 2>/dev/null
```

Then dry-run and link:

```bash
cd ~/dotfiles
stow -n -v -t ~ zsh tmux nvim ranger aerospace ghostty   # check for conflicts
stow -t ~ zsh tmux nvim ranger aerospace ghostty
```

To remove the links: `stow -D -t ~ <package>`. To re-link after changes: `stow -R -t ~ <package>`.

Back up the repo with `~/dotfiles_bak/backup.sh` (copies `~/dotfiles` into `~/dotfiles_bak`).

## 4. Things the configs expect outside the repo

- `~/.bash_profile` is sourced by `.zshrc` but is not in this repo. Copy yours over or remove that line.
- `~/scratch.txt`, `~/kb_shortcuts.txt` and `~/.config/aerospace/aerospace.toml` are opened from the tmux menu (`prefix m`). Create the first two if you want the menu entries to work.
- `.zshrc` checks for `nvm`, but it is not installed here. The check is harmless if it's missing.

## 5. First run and checks

1. Open a new terminal in Ghostty. It should pick up `config.ghostty`.
2. Start tmux and press `prefix r` (`ctrl b`, then `r`) to load the config.
3. Open Neovim on a Python file, then run `:checkhealth vim.lsp`. `basedpyright` and `ruff` should show as attached.
4. Open aerospace once and grant it Accessibility permission in System Settings.
5. Authenticate the CLIs you use: `gh auth login`, `gcloud auth login`.

## 6. Manual steps (not in the repo)

- **Vimium** in Chrome: install the extension and import your saved settings JSON if you have one.
- **Chrome** sign-in with Chrome Sync for bookmarks and extensions.
- **Secrets:** keep tokens out of `.zshrc`. Use a separate untracked file and `source` it from `.zshrc`.
