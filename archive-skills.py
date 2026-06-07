#!/usr/bin/env python3
"""Move inactive skills to ~/.codex/skills-archive/ to reduce agent token usage."""
from __future__ import annotations

import shutil
from pathlib import Path

KEEP = {
    "ml-researcher-profile",
    "rdkit",
    "scikit-learn",
    "shap",
    "matplotlib",
    "plotly",
    "seaborn",
    "polars",
    "scientific-visualization",
    "scientific-writing",
    "humanizer",
    "peer-review",
    "pdf",
    "docx",
    "obsidian-cli",
    ".system",
}

home = Path.home()
skills = home / ".codex" / "skills"
archive = home / ".codex" / "skills-archive"
archive.mkdir(parents=True, exist_ok=True)

kept = archived = skipped = 0

for path in sorted(skills.iterdir()):
    if not path.is_dir():
        continue
    name = path.name
    if name in KEEP:
        print(f"KEEP {name}")
        kept += 1
        continue
    dest = archive / name
    if dest.exists():
        print(f"SKIP {name} (already archived)")
        skipped += 1
        continue
    shutil.move(str(path), str(dest))
    print(f"ARCHIVE {name}")
    archived += 1

graphify = home / ".agents" / "skills" / "graphify"
graphify_dest = archive / "graphify"
if graphify.is_dir() and not graphify_dest.exists():
    shutil.move(str(graphify), str(graphify_dest))
    print("ARCHIVE graphify")
    archived += 1

print()
print(f"Done. Kept {kept}, archived {archived}, skipped {skipped}.")
