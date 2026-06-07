# Project agent instructions

> Copy this file to your project root. Stable facts only — session state goes in `CONTEXT.md`.

## What this project is

<!-- One paragraph: problem, approach, target outcome -->

## Stack

- **Language:** Python 3.11+
- **ML:** PyTorch / Lightning / <!-- GNN, transformers, etc. -->
- **Chemistry:** RDKit <!-- or other -->
- **Data:** <!-- parquet, SDF, custom formats -->
- **Env:** <!-- uv, conda env name, CUDA version -->

## Repository layout

```
<!-- key directories and what they contain -->
```

## Conventions

- Lint/format: **Ruff** (`ruff check`, `ruff format`)
- Tests: `pytest` in `tests/`
- Config: <!-- hydra, yaml, dataclasses -->
- Random seeds: set explicitly in training scripts
- Checkpoints / artifacts: <!-- path, never commit large binaries -->

## Commands

```bash
# install
<!-- e.g. uv sync -->

# train
<!-- e.g. python train.py --config configs/default.yaml -->

# evaluate
<!-- e.g. python eval.py --checkpoint ... -->

# test
pytest
```

## Data & paths

| Resource | Path | Notes |
|----------|------|-------|
| Raw data | | |
| Processed | | |
| Checkpoints | | |

## Goals & non-goals

**In scope:**
-

**Out of scope:**
-

## Agent rules for this repo

- Read `CONTEXT.md` before continuing interrupted work
- Match existing patterns in neighboring files
- No new dependencies without stating why
- Chemistry: validate SMILES / sanitize mols before descriptor computation
- ML: log hyperparameters and data split seed for reproducibility
