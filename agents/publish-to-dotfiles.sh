#!/usr/bin/env bash
# Mac version: copy local config into ~/agent-dotfiles for git push
set -euo pipefail

REPO="${AGENT_DOTFILES:-$HOME/agent-dotfiles}"

if [[ ! -d "$REPO" ]]; then
  echo "Create the repo first: git clone https://github.com/schneidermu/agent-dotfiles.git $REPO" >&2
  exit 1
fi

mkdir -p "$REPO/agents" "$REPO/codex-skills" "$REPO/claude"

for item in "$HOME/.agents"/*; do
  name="$(basename "$item")"
  [[ "$name" == "skills" ]] && continue
  rm -rf "$REPO/agents/$name"
  cp -R "$item" "$REPO/agents/$name"
  echo "COPY agents/$name"
done

rm -rf "$REPO/codex-skills"
mkdir -p "$REPO/codex-skills"
for dir in "$HOME/.codex/skills"/*/; do
  name="$(basename "$dir")"
  [[ "$name" == ".system" ]] && continue
  cp -R "$dir" "$REPO/codex-skills/$name"
done
echo "COPY codex-skills (user skills only)"

cp "$HOME/.codex/archive-skills.py" "$REPO/archive-skills.py" 2>/dev/null || true
cp "$HOME/.claude/CLAUDE.md" "$REPO/claude/CLAUDE.md" 2>/dev/null || true
cp "$HOME/.agents/install-mac.sh" "$REPO/install-mac.sh"
cp "$HOME/.agents/install-windows.ps1" "$REPO/install-windows.ps1"

echo "Ready to commit from: $REPO"
