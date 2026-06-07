# agent-dotfiles

Private dotfiles for Cursor, Codex, and Claude Code — synced between Windows and Mac.

## Install on a new machine

### Mac

```bash
git clone https://github.com/schneidermu/agent-dotfiles.git ~/agent-dotfiles
bash ~/agent-dotfiles/install-mac.sh
```

### Windows

```powershell
git clone https://github.com/schneidermu/agent-dotfiles.git $env:USERPROFILE\agent-dotfiles
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\agent-dotfiles\install-windows.ps1"
```

## Update after editing config

```powershell
# Windows
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.agents\publish-to-dotfiles.ps1"
cd $env:USERPROFILE\agent-dotfiles
git add -A
git commit -m "Update agent config"
git push
```

```bash
# Mac
bash ~/.agents/publish-to-dotfiles.sh
cd ~/agent-dotfiles
git add -A
git commit -m "Update agent config"
git push
```

Then on the other machine: `git pull` and re-run the install script.

## Contents

- `agents/` — templates, profile, setup scripts
- `codex-skills/` — active skill library (15 skills)
- `claude/CLAUDE.md` — global Claude Code instructions
- `archive-skills.py` — trim/restore skills on each machine
