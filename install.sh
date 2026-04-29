#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/dotfiles"

backup() {
  local target="$1"

  if [ -e "$target" ] && [ ! -L "$target" ]; then
    local backup="${target}.backup.$(date +%Y%m%d%H%M%S)"
    echo "Backup: $target -> $backup"
    mv "$target" "$backup"
  fi
}

link() {
  local src="$1"
  local dest="$2"

  backup "$dest"
  ln -sfn "$src" "$dest"
  echo "Link: $dest -> $src"
}

echo "Link dotfiles..."

if [ -d "$DOTFILES/home" ]; then
  find "$DOTFILES/home" -maxdepth 1 -mindepth 1 | while read -r src; do
    name="$(basename "$src")"
    dest="$HOME/$name"
    link "$src" "$dest"
  done
fi

if [ -d "$DOTFILES/config" ]; then
  mkdir -p "$HOME/.config"

  find "$DOTFILES/config" -maxdepth 1 -mindepth 1 | while read -r src; do
    name="$(basename "$src")"
    dest="$HOME/.config/$name"
    link "$src" "$dest"
  done
fi

echo ""
echo "Done."
