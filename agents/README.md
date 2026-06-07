# Agent Hub — shared config for Cursor, Codex, and Claude Code

This folder is the **single source of truth** for preferences, templates, and session handoffs that should follow you across tools and machines.

## Layout

```
~/.agents/
├── README.md              ← you are here
├── profile/               ← who you are (tool-agnostic)
├── templates/             ← copy into new projects
│   ├── AGENTS.md          ← project instructions (all agents)
│   └── CONTEXT.md         ← session handoff (update when switching tools)
└── skills/                ← symlink → ~/.codex/skills (canonical skill library)
```

## Skill library (one copy, three tools)

| Tool | Reads skills from |
|------|-------------------|
| **Cursor** | `~/.cursor/skills/`, `~/.codex/skills/`, `~/.agents/skills/` |
| **Codex** | `~/.codex/skills/` |
| **Claude Code** | `~/.claude/skills/` (symlink to the same library) |

**Canonical location:** `~/.codex/skills/` (52 scientific/ML skills already live here).

Run `setup.ps1` or `setup.sh` once per machine to wire symlinks.

## Context handoff (switch tools without losing state)

When you pause in one tool and continue in another:

1. Update `CONTEXT.md` in the **project root** (copy from `templates/CONTEXT.md` if missing).
2. Commit or stash your work so the other tool sees the same files.
3. In the new tool, start with: *"Read CONTEXT.md and continue where we left off."*

`AGENTS.md` holds **stable** project facts (stack, conventions, goals).  
`CONTEXT.md` holds **volatile** session state (current task, blockers, next steps).

## Cross-machine sync (Windows ↔ Mac)

Recommended: a private **git dotfiles repo** (not iCloud — symlinks and tool caches behave badly in cloud folders).

```
dotfiles/
├── agents/          → ~/.agents
├── codex/
│   ├── config.toml  → ~/.codex/config.toml (strip secrets first)
│   └── skills/      → ~/.codex/skills
├── cursor/
│   └── settings.json → Cursor User/settings.json
└── claude/
    ├── settings.json → ~/.claude/settings.json
    └── CLAUDE.md     → ~/.claude/CLAUDE.md
```

On each machine: clone dotfiles, run `setup.sh` / `setup.ps1` to symlink.

**Do not sync:** API keys, session logs, `~/.codex/sessions/`, `~/.cursor/projects/`.

## Which tool for what

| Task | Best tool | Why |
|------|-----------|-----|
| Edit code in IDE, inline diffs, PRs | **Cursor** | Native editor, Agent + Glass, Bugbot |
| Jupyter notebooks, Python debugging | **Cursor** | Jupyter + debugpy extensions already installed |
| Remote SSH / HPC (cluster.hpc.hse.ru, lab servers) | **Cursor** | Remote SSH configured; same UI as local |
| Long multi-phase builds (GSD workflow) | **Codex** | Multi-agent orchestration, hooks, plugins |
| Documents, spreadsheets, browser automation | **Codex** | Primary-runtime plugins |
| Quick terminal tasks, one-off scripts | **Claude Code** | Fast CLI, minimal overhead |
| Literature review, paper writing, Zotero | **Any** | `literature-review`, `pyzotero`, `scientific-writing` skills |

**Rule of thumb:** one **active** agent per project at a time. Finish a step, update `CONTEXT.md`, then switch.

## New project checklist

```bash
cd your-new-project
cp ~/.agents/templates/AGENTS.md .
cp ~/.agents/templates/CONTEXT.md .
# Edit AGENTS.md: stack, data paths, eval metrics
mkdir -p .cursor/rules   # optional: project-specific Cursor rules
```

## Your installed extensions (Windows)

Already set up and relevant to your work:

- Python, Cursor Pyright, Ruff, Jupyter
- Remote SSH, WSL, Dev Containers
- PDF viewer

## Maintenance

- **Add a skill once** in `~/.codex/skills/<name>/SKILL.md` — all tools see it after symlink setup.
- **Change global preferences** in `~/.agents/profile/PROFILE.md`, then mirror one-liners into Cursor User Rules / `~/.claude/CLAUDE.md` if needed.
- **Per-project overrides** go in project `AGENTS.md` or `.cursor/rules/*.mdc`, not here.
