#!/usr/bin/env bash
# Install agent dotfiles on Mac after: git clone ... ~/agent-dotfiles
set -euo pipefail

REPO="${1:-$HOME/agent-dotfiles}"
AGENTS="$HOME/.agents"
CODEX_SKILLS="$HOME/.codex/skills"
CLAUDE="$HOME/.claude"

echo "Installing from $REPO"

mkdir -p "$AGENTS" "$HOME/.codex" "$CLAUDE"

# Copy agents content (skip skills — setup.sh creates symlink)
for item in "$REPO/agents"/*; do
  name="$(basename "$item")"
  [[ "$name" == "skills" ]] && continue
  if [[ -d "$item" ]]; then
    rm -rf "$AGENTS/$name"
    cp -R "$item" "$AGENTS/$name"
  else
    cp "$item" "$AGENTS/$name"
  fi
  echo "COPY agents/$name"
done

# Active skill library
rm -rf "$CODEX_SKILLS"
mkdir -p "$CODEX_SKILLS"
cp -R "$REPO/codex-skills/." "$CODEX_SKILLS/"
echo "COPY codex-skills -> ~/.codex/skills"

# Archive helper
cp "$REPO/archive-skills.py" "$HOME/.codex/archive-skills.py" 2>/dev/null || true
cp "$REPO/archive-skills.sh" "$HOME/.codex/archive-skills.sh" 2>/dev/null || true

# Claude global instructions
cp "$REPO/claude/CLAUDE.md" "$CLAUDE/CLAUDE.md" 2>/dev/null || true

# Wire symlinks
bash "$AGENTS/setup.sh"

echo ""
echo "Done. Verify: ls -la ~/.cursor/skills ~/.agents/skills ~/.claude/skills"
