#!/usr/bin/env bash
set -euo pipefail

# Ubuntu (GNOME + IBus) で日本語入力まわりを復旧するスクリプト
# - キーボード配列: JP
# - 入力ソース: JP keyboard + Mozc
# - Caps Lock: Ctrl
# - 切替キー: Super+Space / Ctrl+Space
# - ログイン直後にMozcを有効化

echo "[1/6] 入力ソースを JP + Mozc に設定"
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'jp'), ('ibus', 'mozc-jp')]"

echo "[2/6] Caps Lock を Ctrl に割り当て"
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier']"

echo "[3/6] 入力ソース切替キーを設定"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Super>space','<Ctrl>space']"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "['<Shift><Super>space']"

echo "[4/6] Mozc を起動時アクティブに設定"
mkdir -p "$HOME/.config/mozc"
if [ -f "$HOME/.config/mozc/ibus_config.textproto" ]; then
  if rg -q '^active_on_launch:' "$HOME/.config/mozc/ibus_config.textproto"; then
    sed -i 's/^active_on_launch:.*/active_on_launch: True/' "$HOME/.config/mozc/ibus_config.textproto"
  else
    printf '\nactive_on_launch: True\n' >> "$HOME/.config/mozc/ibus_config.textproto"
  fi
else
  cat > "$HOME/.config/mozc/ibus_config.textproto" <<'EOT'
engines {
  name : "mozc-jp"
  longname : "Mozc"
  layout : "default"
  layout_variant : ""
  layout_option : ""
  rank : 80
}
active_on_launch: True
EOT
fi

ibus write-cache || true

echo "[5/6] ibus を再起動して Mozc を選択"
ibus restart || true
sleep 0.5
ibus engine mozc-jp || true

echo "[6/6] 設定確認"
echo -n "sources: "
gsettings get org.gnome.desktop.input-sources sources
echo -n "xkb-options: "
gsettings get org.gnome.desktop.input-sources xkb-options
echo -n "switch-input-source: "
gsettings get org.gnome.desktop.wm.keybindings switch-input-source
echo -n "switch-input-source-backward: "
gsettings get org.gnome.desktop.wm.keybindings switch-input-source-backward
echo -n "mozc active_on_launch: "
rg '^active_on_launch:' "$HOME/.config/mozc/ibus_config.textproto" || true
echo -n "current ibus engine: "
ibus engine || true

echo
echo "完了。"
