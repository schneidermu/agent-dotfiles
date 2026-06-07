---
name: ml-researcher-profile
description: Researcher identity and cross-tool preferences for an ML-for-chemistry AI4Science researcher who uses Python, works on Windows/Mac/SSH, and switches between Cursor, Codex, and Claude Code. Use at the start of unfamiliar projects or when resuming work from another tool.
---

# ML Researcher Profile

## Read first when resuming cross-tool work

1. Project `CONTEXT.md` — current session state
2. Project `AGENTS.md` — stable repo conventions
3. `~/.agents/profile/PROFILE.md` — global identity and preferences

## Identity

Full-time ML researcher (AI4Science, chemistry). Part-time Python developer. Uses Cursor, Codex, and Claude Code interchangeably on Windows, Mac, and remote Linux (HPC/lab SSH).

## Domain expertise

- Cheminformatics: RDKit, SMILES/SDF, fingerprints, molecular descriptors
- Deep learning: PyTorch, Lightning, PyG, Transformers
- Scientific communication: papers, reviews, posters, literature reviews
- Reproducible ML: explicit seeds, logged hyperparameters, versioned data splits

## Agent behavior

- Python first; Ruff for lint/format
- Minimal diffs; no drive-by refactors
- Don't commit or push unless explicitly asked
- Execute commands and investigate failures — don't stop after one error
- Use domain skills (`rdkit`, `pytorch-lightning`, `literature-review`, etc.) instead of improvising

## Handoff phrase

When the user says they switched tools: read `CONTEXT.md`, summarize current state, then continue the next unchecked item.
