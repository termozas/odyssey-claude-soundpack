#!/usr/bin/env bash
# Odyssey sound pack installer for peon-ping.
# Copies the pack into your peon-ping packs dir and sets it active.
set -euo pipefail

PEON_DIR="${CLAUDE_PEON_DIR:-${CLAUDE_CONFIG_DIR:-$HOME/.claude}/hooks/peon-ping}"
if [ ! -d "$PEON_DIR/packs" ]; then
  echo "peon-ping not found at $PEON_DIR."
  echo "Install it first:  curl -fsSL https://raw.githubusercontent.com/PeonPing/peon-ping/main/install.sh | bash"
  exit 1
fi

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/packs/odyssey"
DEST="$PEON_DIR/packs/odyssey"
mkdir -p "$DEST"
cp -R "$SRC/." "$DEST/"

# Set as the active pack (edits config.json with python, no jq dependency).
python3 - "$PEON_DIR/config.json" <<'PY'
import json, sys, os
p = sys.argv[1]
cfg = json.load(open(p)) if os.path.exists(p) else {}
cfg["active_pack"] = "odyssey"
json.dump(cfg, open(p, "w"), indent=2)
PY

echo "Odyssey pack installed and set active. Open a new session to hear it."
