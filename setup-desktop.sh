#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

usage() {
  cat <<USAGE
Usage:
  $0 [--only ibus|keybindings|fcitx5]

Examples:
  $0
  $0 --only ibus
USAGE
}

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  usage
  exit 0
fi

if [[ "${1:-}" == "--only" ]]; then
  case "${2:-}" in
    ibus)
      exec "$SCRIPT_DIR/scripts/ime-ibus-mozc.sh"
      ;;
    keybindings)
      exec "$SCRIPT_DIR/scripts/gnome-keybindings.sh"
      ;;
    fcitx5)
      exec "$SCRIPT_DIR/scripts/ime-fcitx5-setup.sh"
      ;;
    *)
      usage
      exit 1
      ;;
  esac
fi

"$SCRIPT_DIR/scripts/ime-ibus-mozc.sh"
"$SCRIPT_DIR/scripts/gnome-keybindings.sh"

echo "Desktop setup complete."
