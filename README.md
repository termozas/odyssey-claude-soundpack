# Odyssey Sound Pack

A [peon-ping](https://github.com/PeonPing/peon-ping) sound pack that plays cues from
*The Odyssey* (2026, Ludwig Göransson) on Claude Code events.

![cover](cover.png)

## What plays when

| Event | Cue |
|---|---|
| Task complete | 4 clips, rotating (4.5s–12s) |
| Session start | one long cue |
| Approval / input needed | 2 clips |
| Rapid prompts ("spam") | 2 clips |

## Install

Requires [peon-ping](https://github.com/PeonPing/peon-ping) already installed.

Clone this repo and run the installer:

```bash
git clone https://github.com/termozas/odyssey-soundpack.git
cd odyssey-soundpack
./install.sh
```

Then open a new Claude Code session. To switch back to another pack:

```bash
bash "${CLAUDE_CONFIG_DIR:-$HOME/.claude}/hooks/peon-ping/peon.sh" packs use <name>
```

## License / audio

The audio is from *The Odyssey* (2026), composed by Ludwig Göransson, and is
**copyrighted**. This is a **private** repository for personal use. The music is not
licensed for redistribution — do not make this repo public or share the audio.
