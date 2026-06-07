# Sync agent config: Windows ↔ Mac

`~/.agents/`, `~/.codex/skills/`, and the setup scripts are **local files**.  
Running commands on Windows does nothing on your Mac unless you **copy or git-sync** them.

## What to sync

| Sync via dotfiles git repo | Do NOT sync |
|----------------------------|-------------|
| `~/.agents/` (templates, profile, scripts) | `~/.codex/sessions/` |
| `~/.codex/skills/` (your 15 active skills) | `~/.cursor/projects/` |
| `~/.codex/archive-skills.py` | API keys / tokens |
| `~/.claude/CLAUDE.md` | `~/.codex/skills-archive/` (optional) |

Project code (`C:\Dev\...`) syncs through **each project's own git repo** — that's separate.

## One-time: publish from Windows

```powershell
# 1) Trim skills first (if not done)
python "$env:USERPROFILE\.codex\archive-skills.py"

# 2) Create a private repo on GitHub, then:
cd $env:USERPROFILE
git clone https://github.com/schneidermu/agent-dotfiles.git
cd agent-dotfiles

# 3) Copy your config into the repo
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.agents\publish-to-dotfiles.ps1"

# 4) Commit and push
git add -A
git commit -m "Initial agent dotfiles from Windows"
git push
```

## On your Mac (first time)

```bash
cd ~
git clone https://github.com/schneidermu/agent-dotfiles.git
bash ~/agent-dotfiles/install-mac.sh
```

That script:
1. Copies `agents/`, `codex-skills/`, `claude/` into `~/`
2. Runs `~/\.agents/setup.sh` to create symlinks
3. Leaves you with the same 15-skill library as Windows

## When you change config later

**On the machine where you edited:**

```bash
# Windows
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.agents\publish-to-dotfiles.ps1"
cd ~/agent-dotfiles && git add -A && git commit -m "Update agent config" && git push

# Mac
bash ~/.agents/publish-to-dotfiles.sh
cd ~/agent-dotfiles && git add -A && git commit -m "Update agent config" && git push
```

**On the other machine:**

```bash
cd ~/agent-dotfiles && git pull
bash ~/agent-dotfiles/install-mac.sh      # Mac
# or
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\agent-dotfiles\install-windows.ps1"
```

## Alternative: no git (quick & dirty)

Copy these folders with AirDrop, USB, or `scp`:

```
C:\Users\schne\.agents\          →  ~/.agents/
C:\Users\schne\.codex\skills\    →  ~/.codex/skills/
C:\Users\schne\.codex\archive-skills.py  →  ~/.codex/
C:\Users\schne\.claude\CLAUDE.md →  ~/.claude/
```

Then on Mac: `bash ~/.agents/setup.sh`

Git is better long-term — you won't forget to copy new skills.
