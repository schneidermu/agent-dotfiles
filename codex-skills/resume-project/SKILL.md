---
name: resume-project
description: Start or resume work on a project. Read AGENTS.md and CONTEXT.md, check git log -3, then continue the next unchecked item. Use when the user says resume, continue where we left off, read CONTEXT.md, switching from another tool/device, or pastes the standard resume prompt.
disable-model-invocation: true
---

# Resume project

Run this at the **start** of a session on any device or in any tool (Cursor, Codex, Claude Code).

## Steps

1. **Find the project root** (git root).
2. **Read** (in order):
   - `AGENTS.md` — stack, conventions, commands (skip if missing)
   - `CONTEXT.md` — session state (if missing, say so and infer from git)
3. **Gather git state** (run yourself):
   ```bash
   git pull --ff-only
   git log -3 --oneline
   git status --short
   ```
   If `git pull` fails, report and ask before proceeding.
4. **Summarize** in 4–6 bullets:
   - Current goal
   - Last commits
   - What's checked off vs still open in CONTEXT.md
   - Blockers, if any
5. **Continue the next unchecked item** in CONTEXT.md Progress (or **Next agent should** if Progress is empty).
   - Do not restart from scratch unless CONTEXT is stale — if stale, say what's ambiguous and propose an updated plan.
6. **Match** conventions from `AGENTS.md` and neighboring code.

## Default user prompt

When the user says only "resume" or pastes:

> Read AGENTS.md and CONTEXT.md, check git log -3, and continue the next unchecked item.

…execute this skill without asking clarifying questions unless the project root or CONTEXT is missing.

## Output format

```
## Resume summary
- Goal: ...
- Branch: ...
- Recent commits: ...
- Next action: ...

## Doing now
<start the next unchecked item>
```

Then begin work — don't stop at the summary unless blocked.
