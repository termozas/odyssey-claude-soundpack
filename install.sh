#!/usr/bin/env bash
# Odyssey Claude Sound Pack — standalone installer.
#
# Installs everything in one go: the peon-ping runtime (bundled, MIT — see
# vendor/peon-ping/LICENSE), the Odyssey sound pack, and the Claude Code hooks
# that trigger sounds on session/task events. No separate downloads.
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
PEON_DIR="$CONFIG_DIR/hooks/peon-ping"
SETTINGS="$CONFIG_DIR/settings.json"

command -v python3 >/dev/null || { echo "python3 is required." >&2; exit 1; }

echo "Installing the peon-ping runtime into $PEON_DIR ..."
mkdir -p "$PEON_DIR/packs"
cp "$HERE/vendor/peon-ping/peon.sh" "$HERE/vendor/peon-ping/relay.sh" "$HERE/vendor/peon-ping/VERSION" "$PEON_DIR/"
cp -R "$HERE/vendor/peon-ping/adapters" "$PEON_DIR/adapters"
chmod +x "$PEON_DIR/peon.sh" "$PEON_DIR/relay.sh"

echo "Installing the Odyssey pack ..."
cp -R "$HERE/packs/odyssey" "$PEON_DIR/packs/odyssey"

echo "Configuring ..."
python3 - "$PEON_DIR/config.json" <<'PY'
import json, os, sys
p = sys.argv[1]
cfg = {}
if os.path.exists(p):
    try: cfg = json.load(open(p))
    except Exception: cfg = {}
cfg.setdefault("volume", 0.5)
cfg.setdefault("enabled", True)
cfg["active_pack"] = "odyssey"
json.dump(cfg, open(p, "w"), indent=2)
PY

echo "Registering Claude Code hooks in $SETTINGS ..."
PEON_SH="$PEON_DIR/peon.sh" python3 - "$SETTINGS" <<'PY'
import json, os, sys
settings_path = sys.argv[1]
cmd = os.environ["PEON_SH"]
events = ["SessionStart","SessionEnd","UserPromptSubmit","Stop","Notification","PermissionRequest"]

s = {}
if os.path.exists(settings_path):
    try: s = json.load(open(settings_path))
    except Exception: s = {}
hooks = s.setdefault("hooks", {})
for ev in events:
    arr = hooks.setdefault(ev, [])
    # Idempotent: skip if a peon.sh hook is already registered for this event.
    already = any(
        cmd in h.get("command","")
        for entry in arr for h in entry.get("hooks", [])
    )
    if not already:
        arr.append({"hooks": [{"type": "command", "command": cmd}]})
os.makedirs(os.path.dirname(settings_path) or ".", exist_ok=True)
json.dump(s, open(settings_path, "w"), indent=2)
PY

echo
echo "Done. The Odyssey pack is installed and active."
echo "Open a NEW Claude Code session to hear it."
