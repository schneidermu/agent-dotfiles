---
name: handoff-context
description: End-of-session handoff. Update CONTEXT.md in the project root with current goal, progress, blockers, and next steps so another device or tool (Cursor, Codex, Claude Code) can continue. Use when the user says handoff, end session, switching devices, done for today, or update CONTEXT.md.
disable-model-invocation: true
---

# Handoff context

Run this at the **end** of a session before switching tools, devices, or stopping for the day.

## Steps

1. **Find the project root** (git root). If unclear, ask once.
2. **Gather state** (run yourself):
   - `git branch --show-current`
   - `git status --short`
   - `git log -3 --oneline`
   - What was accomplished this session vs still open
3. **Ensure `CONTEXT.md` exists** in the project root. If missing, copy from `~/.agents/templates/CONTEXT.md`.
4. **Rewrite `CONTEXT.md`** — keep it short (under 60 lines):
   - **Last updated:** date, tool name (Cursor / Codex / Claude Code), branch
   - **Current goal:** one sentence
   - **Progress:** checkboxes — `[x]` done, `[ ]` todo; mark the single in-progress item with `(in progress)`
   - **Key decisions made:** only what matters for the next session
   - **Blockers / open questions**
   - **Files touched recently**
   - **Next agent should:** numbered list, 1–3 concrete actions
   - **Commands already run:** only non-obvious commands worth not repeating
5. **Do not** update `AGENTS.md` unless the user asked — that file is for stable conventions.
6. **Remind the user** to commit and push if there are uncommitted changes:
   ```bash
   git add CONTEXT.md
   git commit -m "chore: session handoff"
   git push
   ```
   Only commit if the user agrees (don't commit without permission).

## Output

After writing `CONTEXT.md`, give a 3-line summary: what was done, what's next, whether push is needed.
