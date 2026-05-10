#!/usr/bin/env bash
set -euo pipefail

# Backward-compatible entrypoint.
exec "$(cd "$(dirname "$0")" && pwd)/link-dotfiles.sh" "$@"
