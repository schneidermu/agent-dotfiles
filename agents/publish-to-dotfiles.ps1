# Copy local agent config into ~/agent-dotfiles for git push.
# Prereq: git clone https://github.com/YOU/agent-dotfiles.git to %USERPROFILE%\agent-dotfiles
# Run: powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.agents\publish-to-dotfiles.ps1"

$ErrorActionPreference = "Stop"
$userRoot = $env:USERPROFILE
$repo = Join-Path $userRoot "agent-dotfiles"

if (-not (Test-Path $repo)) {
    Write-Error "Create the repo first: git clone https://github.com/schneidermu/agent-dotfiles.git `"$repo`""
}

function Copy-Tree($src, $dest) {
    if (-not (Test-Path $src)) {
        Write-Warning "SKIP missing $src"
        return
    }
    if (Test-Path $dest) { Remove-Item $dest -Recurse -Force }
    Copy-Item $src $dest -Recurse
    Write-Host "COPY $src -> $dest"
}

# agents/ without skills symlink (skills published separately)
$agentsDest = Join-Path $repo "agents"
New-Item -ItemType Directory -Force -Path $agentsDest | Out-Null
$agentsSrc = Join-Path $userRoot ".agents"
Get-ChildItem $agentsSrc -Exclude "skills" | ForEach-Object {
    $target = Join-Path $agentsDest $_.Name
    if ($_.PSIsContainer) { Copy-Tree $_.FullName $target }
    else { Copy-Item $_.FullName $target -Force; Write-Host "COPY $($_.FullName)" }
}

# User skills only — skip Codex .system internals (reinstalled by Codex on each machine)
$codexSkillsDest = Join-Path $repo "codex-skills"
if (Test-Path $codexSkillsDest) { Remove-Item $codexSkillsDest -Recurse -Force }
New-Item -ItemType Directory -Force -Path $codexSkillsDest | Out-Null
Get-ChildItem (Join-Path $userRoot ".codex\skills") -Directory | Where-Object { $_.Name -ne ".system" } | ForEach-Object {
    Copy-Tree $_.FullName (Join-Path $codexSkillsDest $_.Name)
}
Copy-Item (Join-Path $userRoot ".codex\archive-skills.py") (Join-Path $repo "archive-skills.py") -Force
Copy-Item (Join-Path $userRoot ".codex\archive-skills.sh") (Join-Path $repo "archive-skills.sh") -Force -ErrorAction SilentlyContinue

$claudeDest = Join-Path $repo "claude"
New-Item -ItemType Directory -Force -Path $claudeDest | Out-Null
Copy-Item (Join-Path $userRoot ".claude\CLAUDE.md") (Join-Path $claudeDest "CLAUDE.md") -Force -ErrorAction SilentlyContinue

# Install scripts in repo root
Copy-Item (Join-Path $userRoot ".agents\install-mac.sh") (Join-Path $repo "install-mac.sh") -Force -ErrorAction SilentlyContinue
Copy-Item (Join-Path $userRoot ".agents\install-windows.ps1") (Join-Path $repo "install-windows.ps1") -Force -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "Ready to commit from: $repo"
