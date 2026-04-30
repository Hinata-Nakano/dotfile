#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname -s)" != "Linux" ]]; then
  echo "This script is for Linux only. Aborting."
  exit 1
fi

if [[ ! -r /etc/os-release ]]; then
  echo "Cannot detect distro (/etc/os-release not found). Aborting."
  exit 1
fi
# shellcheck disable=SC1091
source /etc/os-release

if [[ "${ID:-}" != "ubuntu" && "${ID:-}" != "debian" && "${ID_LIKE:-}" != *"debian"* ]]; then
  echo "Unsupported distro: ID=${ID:-unknown}, ID_LIKE=${ID_LIKE:-unknown}"
  echo "This script only supports Ubuntu/Debian (apt). Aborting."
  exit 1
fi

cat <<MSG
About to configure keyboard/IME on this machine:
- Distro: ${PRETTY_NAME:-unknown}
- Install: fcitx5 fcitx5-mozc fcitx5-config-qt im-config qtwayland5
- Set input method framework to fcitx5
- Set CapsLock -> Ctrl
- Disable GNOME input-source switching (avoid Ctrl+Space conflict)

Continue?
MSG

read -r -p "[y/N]: " ans
case "${ans:-N}" in
  y|Y|yes|YES) ;;
  *)
    echo "Canceled."
    exit 0
    ;;
esac

sudo apt update
sudo apt install -y fcitx5 fcitx5-mozc fcitx5-config-qt im-config qtwayland5

im-config -n fcitx5

gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier']"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "[]"

echo "Done. Please logout/login once."
