# One-time fix for existing non-symlink skill folders.
# Archives leftover skills, then re-runs setup.
# Run: powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.agents\fix-skills-links.ps1"

$archive = "$env:USERPROFILE\.codex\skills-archive"
New-Item -ItemType Directory -Force -Path $archive | Out-Null

$moves = @(
    @{ From = "$env:USERPROFILE\.agents\skills\graphify"; To = "$archive\graphify" },
    @{ From = "$env:USERPROFILE\.claude\skills\frontend-design"; To = "$archive\frontend-design" }
)

foreach ($m in $moves) {
    if (Test-Path $m.From) {
        if (Test-Path $m.To) {
            Write-Warning "SKIP $($m.From) (archive target exists)"
        } else {
            Move-Item $m.From $m.To
            Write-Host "ARCHIVE $($m.From) -> $($m.To)"
        }
    }
}

& "$env:USERPROFILE\.agents\setup.ps1"
