#!/usr/bin/env bash
set -euo pipefail

# Backward-compatible wrapper.
exec "$(cd "$(dirname "$0")" && pwd)/scripts/ime-fcitx5-setup.sh" "$@"
