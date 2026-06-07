#!/usr/bin/env bash
# Move inactive skills out of ~/.codex/skills/ to cut agent token usage.
set -euo pipefail

SKILLS="$HOME/.codex/skills"
ARCHIVE="$HOME/.codex/skills-archive"

keep=(
  ml-researcher-profile
  rdkit
  scikit-learn
  shap
  matplotlib
  plotly
  seaborn
  polars
  scientific-visualization
  scientific-writing
  humanizer
  peer-review
  pdf
  docx
  obsidian-cli
  .system
)

is_kept() {
  local name="$1"
  for k in "${keep[@]}"; do
    [[ "$k" == "$name" ]] && return 0
  done
  return 1
}

mkdir -p "$ARCHIVE"

for dir in "$SKILLS"/*/; do
  name="$(basename "$dir")"
  if is_kept "$name"; then
    echo "KEEP $name"
    continue
  fi
  if [[ -e "$ARCHIVE/$name" ]]; then
    echo "SKIP $name (already in archive)" >&2
    continue
  fi
  mv "$dir" "$ARCHIVE/$name"
  echo "ARCHIVE $name"
done

if [[ -d "$HOME/.agents/skills/graphify" && ! -e "$ARCHIVE/graphify" ]]; then
  mv "$HOME/.agents/skills/graphify" "$ARCHIVE/graphify"
  echo "ARCHIVE graphify"
fi

echo ""
echo "Done. Active: $((${#keep[@]} - 1)) skills (+ .system for Codex)."
