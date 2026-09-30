# Dual-UI Core Universal Installer (PowerShell for Windows)
# Usage:
#   irm https://raw.githubusercontent.com/MosaabGalmod/dual-ui-core/main/install.ps1 | iex
# or run locally:
#   .\install.ps1 [-Target <antigravity|claude|cursor|windsurf|cline|all|project>]

param(
    [string]$Target = "all"
)

$BaseUrl = "https://raw.githubusercontent.com/MosaabGalmod/dual-ui-core/main"
$LocalDir = $PSScriptRoot

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  Dual-UI Core: Bilingual & Dual-Theme Agent Skill Setup" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

function Get-SourceContent([string]$Filename) {
    if ($LocalDir -and (Test-Path "$LocalDir\$Filename")) {
        return Get-Content "$LocalDir\$Filename" -Raw -Encoding UTF8
    } else {
        return (Invoke-WebRequest -Uri "$BaseUrl/$Filename" -UseBasicParsing).Content
    }
}

# 1. Antigravity & Gemini CLI
if ($Target -in @("all", "antigravity", "gemini")) {
    $AgyDir = "$HOME\.gemini\config\skills\dual-ui-core"
    New-Item -ItemType Directory -Force -Path $AgyDir | Out-Null
    $SkillContent = Get-SourceContent "SKILL.md"
    Set-Content -Path "$AgyDir\SKILL.md" -Value $SkillContent -Encoding UTF8
    Write-Host "[OK] Installed to Antigravity / Gemini CLI: $AgyDir\SKILL.md" -ForegroundColor Green
}

# 2. Claude Code
if ($Target -in @("all", "claude")) {
    $ClaudeSkillsDir = "$HOME\.claude\skills\dual-ui-core"
    New-Item -ItemType Directory -Force -Path $ClaudeSkillsDir | Out-Null
    $SkillContent = Get-SourceContent "SKILL.md"
    Set-Content -Path "$ClaudeSkillsDir\SKILL.md" -Value $SkillContent -Encoding UTF8
    Write-Host "[OK] Installed to Claude Code Skill: $ClaudeSkillsDir\SKILL.md" -ForegroundColor Green

    $ClaudeGlobalMd = "$HOME\.claude\CLAUDE.md"
    if (Test-Path "$HOME\.claude") {
        $Rules = Get-SourceContent "DESIGN_RULES.md"
        if (Test-Path $ClaudeGlobalMd) {
            $Existing = Get-Content $ClaudeGlobalMd -Raw -Encoding UTF8
            if (-not $Existing.Contains("Dual-UI Core")) {
                Add-Content -Path $ClaudeGlobalMd -Value "`n`n$Rules" -Encoding UTF8
                Write-Host "[OK] Appended rules to global Claude instructions: $ClaudeGlobalMd" -ForegroundColor Green
            }
        }
    }
}

# 3. Current Project Setup
if ($Target -in @("all", "project", "cursor", "windsurf", "cline")) {
    $TargetDir = Get-Location

    if ($Target -in @("all", "project", "cursor")) {
        $CursorContent = Get-SourceContent "adapters/.cursorrules"
        Set-Content -Path "$TargetDir\.cursorrules" -Value $CursorContent -Encoding UTF8
        Write-Host "[OK] Generated .cursorrules in: $TargetDir" -ForegroundColor Green
    }

    if ($Target -in @("all", "project", "windsurf")) {
        $WindsurfContent = Get-SourceContent "adapters/.windsurfrules"
        Set-Content -Path "$TargetDir\.windsurfrules" -Value $WindsurfContent -Encoding UTF8
        Write-Host "[OK] Generated .windsurfrules in: $TargetDir" -ForegroundColor Green
    }

    if ($Target -in @("all", "project", "cline")) {
        $ClineContent = Get-SourceContent "adapters/.clinerules"
        Set-Content -Path "$TargetDir\.clinerules" -Value $ClineContent -Encoding UTF8
        Write-Host "[OK] Generated .clinerules in: $TargetDir" -ForegroundColor Green
    }

    if ($Target -in @("all", "project")) {
        $AgentsContent = Get-SourceContent "AGENTS.md"
        Set-Content -Path "$TargetDir\AGENTS.md" -Value $AgentsContent -Encoding UTF8
        Write-Host "[OK] Generated AGENTS.md in: $TargetDir" -ForegroundColor Green

        $RulesContent = Get-SourceContent "DESIGN_RULES.md"
        Set-Content -Path "$TargetDir\DESIGN_RULES.md" -Value $RulesContent -Encoding UTF8
        Write-Host "[OK] Generated DESIGN_RULES.md in: $TargetDir" -ForegroundColor Green
    }
}

Write-Host "`nDual-UI Core installation completed successfully!" -ForegroundColor Cyan
