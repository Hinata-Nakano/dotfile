#!/usr/bin/env bash
set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/dotfiles}"

backup() {
  local target="$1"

  if [ -e "$target" ] && [ ! -L "$target" ]; then
    local backup_file="${target}.backup.$(date +%Y%m%d%H%M%S)"
    echo "Backup: $target -> $backup_file"
    mv "$target" "$backup_file"
  fi
}

link_item() {
  local src="$1"
  local dest="$2"

  if [ ! -e "$src" ]; then
    echo "Skip (missing): $src"
    return 0
  fi

  backup "$dest"
  ln -sfn "$src" "$dest"
  echo "Link: $dest -> $src"
}

echo "Link dotfiles (explicit allowlist)..."

HOME_ITEMS=(
  ".zshrc"
)

CONFIG_ITEMS=(
  "nvim"
  "wezterm"
)

for name in "${HOME_ITEMS[@]}"; do
  link_item "$DOTFILES/home/$name" "$HOME/$name"
done

mkdir -p "$HOME/.config"
for name in "${CONFIG_ITEMS[@]}"; do
  link_item "$DOTFILES/config/$name" "$HOME/.config/$name"
done

echo

echo "Done."
