#!/usr/bin/env bash
# Link each config in this repo to its place in $HOME.
#
#   ./install.sh             link configs
#   ./install.sh --dry-run   show what would happen, change nothing
#   ./install.sh --brew      also install the packages in Brewfile
#
# Existing files are moved to ~/dotfiles_bak/pre-install/<timestamp>/, never deleted.
# Running it again is safe: links that already point here are left alone.

set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
BACKUP="$HOME/dotfiles_bak/pre-install/$(date +%Y%m%d-%H%M%S)"
DRY_RUN=0
BREW=0

for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    --brew) BREW=1 ;;
    *) echo "unknown option: $arg" >&2; exit 1 ;;
  esac
done

run() {
  if [[ $DRY_RUN -eq 1 ]]; then
    echo "  [dry-run] $*"
  else
    "$@"
  fi
}

# link <file in repo> <destination in $HOME>
link() {
  local src="$REPO/$1"
  local dst="$2"

  if [[ ! -e "$src" ]]; then
    echo "missing in repo: $src" >&2
    exit 1
  fi

  if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
    echo "ok      $dst"
    return
  fi

  if [[ -e "$dst" || -L "$dst" ]]; then
    echo "backup  $dst -> $BACKUP/"
    run mkdir -p "$BACKUP"
    run mv "$dst" "$BACKUP/$(basename "$dst")"
  fi

  echo "link    $dst -> $src"
  if [[ ! -d "$(dirname "$dst")" ]]; then
    run mkdir -p "$(dirname "$dst")"
  fi
  run ln -s "$src" "$dst"
}

link zsh/zshrc                 "$HOME/.zshrc"
link tmux/tmux.conf            "$HOME/.tmux.conf"
link nvim/init.lua             "$HOME/.config/nvim/init.lua"
link ranger/rc.conf            "$HOME/.config/ranger/rc.conf"
link aerospace/aerospace.toml  "$HOME/.config/aerospace/aerospace.toml"
link ghostty/config.ghostty    "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"

if [[ $BREW -eq 1 ]]; then
  echo "brew    installing from $REPO/Brewfile"
  run brew bundle --file="$REPO/Brewfile"
fi

echo "done"
