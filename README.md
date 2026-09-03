# Odyssey Claude Sound Pack

A **standalone** sound pack for Claude Code. It plays cues from *The Odyssey*
(2026, Ludwig Göransson) when Claude starts a session, finishes a task, asks for
approval, and more. Everything needed is bundled — you install **one thing**.

![cover](cover.png)

## What plays when

| Event | Cue |
|---|---|
| Task complete | 4 clips, rotating (4.5s–12s) |
| Session start | one long cue |
| Approval / input needed | 2 clips |
| Rapid prompts ("spam") | 2 clips |

## Install

```bash
git clone https://github.com/termozas/odyssey-claude-soundpack.git
cd odyssey-claude-soundpack
./install.sh
```

Then open a **new** Claude Code session. The installer sets up the bundled runtime,
the pack, and the Claude Code hooks. It is idempotent — safe to run again.

Change the volume or switch packs later:

```bash
bash "${CLAUDE_CONFIG_DIR:-$HOME/.claude}/hooks/peon-ping/peon.sh" help
```

## Credits

The playback runtime is [peon-ping](https://github.com/PeonPing/peon-ping) by
Tony Sheng, bundled under the MIT License (see `vendor/peon-ping/LICENSE`).

## Audio license

The audio is from *The Odyssey* (2026), composed by Ludwig Göransson, and is
**copyrighted**. This is a **private** repository for personal use only. The music
is not licensed for redistribution — keep this repo private and do not share the audio.
