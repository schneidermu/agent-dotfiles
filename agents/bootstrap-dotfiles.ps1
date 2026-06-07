# One-shot: clone agent-dotfiles, publish config, commit, push.
# Run: powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.agents\bootstrap-dotfiles.ps1"

$ErrorActionPreference = "Stop"
$repoUrl = "https://github.com/schneidermu/agent-dotfiles.git"
$repo = Join-Path $env:USERPROFILE "agent-dotfiles"
$agents = Join-Path $env:USERPROFILE ".agents"

if (-not (Test-Path $repo)) {
    git clone $repoUrl $repo
    Write-Host "Cloned $repoUrl"
}

& (Join-Path $agents "publish-to-dotfiles.ps1")

Copy-Item (Join-Path $agents "dotfiles-README.md") (Join-Path $repo "README.md") -Force

$gitignore = @(
    ".DS_Store"
    "Thumbs.db"
    "*.pyc"
    "__pycache__/"
)
Set-Content -Path (Join-Path $repo ".gitignore") -Value $gitignore -Encoding UTF8

Set-Location $repo
git add -A
$status = git status --porcelain
if (-not $status) {
    Write-Host "Nothing to commit - repo already up to date."
    exit 0
}

git commit -m "Initial agent dotfiles from Windows." -m "Sync Cursor/Codex/Claude skills, templates, profile, and install scripts."

git push -u origin main
if ($LASTEXITCODE -ne 0) {
    git push -u origin master
}

Write-Host ""
Write-Host "Published: $repoUrl"
