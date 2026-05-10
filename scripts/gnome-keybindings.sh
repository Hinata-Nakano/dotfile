#!/usr/bin/env bash
set -euo pipefail

# GNOME keybinding: Ctrl+Alt+T launches WezTerm.

echo "[1/3] Disable default terminal shortcut"
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "[]"

echo "[2/3] Register custom shortcut"
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'LaunchWezTerm'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'wezterm'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Primary><Alt>t'

echo "[3/3] Verify"
echo -n "terminal: "
gsettings get org.gnome.settings-daemon.plugins.media-keys terminal
echo -n "custom-keybindings: "
gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings
