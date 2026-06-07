#!/usr/bin/env bash
# Wire ~/.agents as the shared hub (Mac / Linux / Git Bash on Windows)
set -euo pipefail

AGENTS="$HOME/.agents"
CODEX_SKILLS="$HOME/.codex/skills"
CURSOR_SKILLS="$HOME/.cursor/skills"
CLAUDE_SKILLS="$HOME/.claude/skills"
AGENTS_SKILLS="$AGENTS/skills"

link_if_missing() {
  local link="$1" target="$2"
  if [[ -L "$link" ]]; then
    echo "OK  $link -> $(readlink "$link")"
    return
  fi
  if [[ -e "$link" ]]; then
    echo "SKIP $link exists and is not a symlink" >&2
    return
  fi
  ln -s "$target" "$link"
  echo "LINK $link -> $target"
}

mkdir -p "$CODEX_SKILLS"
link_if_missing "$AGENTS_SKILLS" "$CODEX_SKILLS"
link_if_missing "$CURSOR_SKILLS" "$CODEX_SKILLS"
link_if_missing "$CLAUDE_SKILLS" "$CODEX_SKILLS"

echo ""
echo "Done. Skill library: $CODEX_SKILLS"
echo "Templates: $AGENTS/templates/"
echo "Profile:   $AGENTS/profile/PROFILE.md"
