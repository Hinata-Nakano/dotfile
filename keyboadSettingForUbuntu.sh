#!/usr/bin/env bash
set -euo pipefail

# Backward-compatible wrapper (typo kept for compatibility).
exec "$(cd "$(dirname "$0")" && pwd)/scripts/ime-ibus-mozc.sh" "$@"
