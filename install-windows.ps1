# Install agent dotfiles on Windows after: git clone ... %USERPROFILE%\agent-dotfiles
# Run: powershell -ExecutionPolicy Bypass -File install-windows.ps1

$ErrorActionPreference = "Stop"
$repo = if ($args[0]) { $args[0] } else { "$env:USERPROFILE\agent-dotfiles" }
$agents = "$env:USERPROFILE\.agents"
$codexSkills = "$env:USERPROFILE\.codex\skills"

if (-not (Test-Path $repo)) {
    Write-Error "Repo not found: $repo"
}

Get-ChildItem "$repo\agents" | Where-Object { $_.Name -ne "skills" } | ForEach-Object {
    $dest = Join-Path $agents $_.Name
    if (Test-Path $dest) { Remove-Item $dest -Recurse -Force }
    Copy-Item $_.FullName $dest -Recurse
    Write-Host "COPY agents\$($_.Name)"
}

if (Test-Path $codexSkills) { Remove-Item $codexSkills -Recurse -Force }
Copy-Item "$repo\codex-skills" $codexSkills -Recurse
Write-Host "COPY codex-skills -> ~/.codex/skills"

Copy-Item "$repo\archive-skills.py" "$env:USERPROFILE\.codex\archive-skills.py" -Force -ErrorAction SilentlyContinue
Copy-Item "$repo\claude\CLAUDE.md" "$env:USERPROFILE\.claude\CLAUDE.md" -Force -ErrorAction SilentlyContinue

& "$agents\setup.ps1"
Write-Host "Done."
