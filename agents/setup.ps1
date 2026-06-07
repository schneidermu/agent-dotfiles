# Wire ~/.agents as the shared hub for Cursor, Codex, and Claude Code (Windows)
# Run: powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.agents\setup.ps1"
# Requires: Developer Mode OR elevated shell (for symlinks)

$ErrorActionPreference = "Stop"
$agents = "$env:USERPROFILE\.agents"
$codexSkills = "$env:USERPROFILE\.codex\skills"
$cursorSkills = "$env:USERPROFILE\.cursor\skills"
$claudeSkills = "$env:USERPROFILE\.claude\skills"
$agentsSkills = "$agents\skills"
$archive = "$env:USERPROFILE\.codex\skills-archive"

function Ensure-Link($link, $target) {
    $archiveRoot = $archive
    New-Item -ItemType Directory -Force -Path $archiveRoot | Out-Null

    if (Test-Path $link) {
        $item = Get-Item $link -Force
        if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
            $currentTarget = $item.Target
            if ($currentTarget -eq $target) {
                Write-Host "OK  $link -> $target"
                return
            }
            Remove-Item $link -Force
            Write-Host "REPLACE symlink $link (was -> $currentTarget)"
        } else {
            $stamp = Get-Date -Format "yyyyMMdd-HHmmss"
            $leaf = Split-Path $link -Leaf
            $backup = Join-Path $archiveRoot "leftover-$leaf-$stamp"
            Move-Item $link $backup
            Write-Host "MOVED $link -> $backup"
        }
    }

    New-Item -ItemType SymbolicLink -Path $link -Target $target | Out-Null
    Write-Host "LINK $link -> $target"
}

# Canonical skill library stays in ~/.codex/skills
Ensure-Link $agentsSkills $codexSkills
Ensure-Link $cursorSkills $codexSkills
Ensure-Link $claudeSkills $codexSkills

Write-Host ""
Write-Host "Done. Skill library: $codexSkills"
Write-Host "Templates: $agents\templates\"
Write-Host "Profile:   $agents\profile\PROFILE.md"
