# BioSpec - Validate Templates
# Checks template integrity and reports missing or incomplete files
# Portions of this file are adapted from GitHub's spec-kit tool.
# Copyright (c) GitHub, Inc.
# Licensed under the MIT License - see THIRD_PARTY_LICENSES.md.

$ErrorActionPreference = "Stop"

# Get script directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent (Split-Path -Parent $ScriptDir)

Write-Host "BioSpec - Template Validation" -ForegroundColor Cyan
Write-Host "=============================="
Write-Host ""

$errors = 0
$warnings = 0

# Check master templates
Write-Host "Checking master templates (.biospec/)..." -ForegroundColor Cyan
$masterTemplates = @(
    ".biospec\project_overview.md",
    ".biospec\intent_overview.md",
    ".biospec\dataset_overview.md",
    ".biospec\analysis_overview.md",
    ".biospec\project_resources.md",
    ".biospec\status.md",
    ".biospec\subtemplates\intent.md",
    ".biospec\subtemplates\dataset.md",
    ".biospec\subtemplates\analysis.md"
)

foreach ($template in $masterTemplates) {
    $path = "$ProjectRoot\$template"
    if (Test-Path $path) {
        Write-Host "  OK $template" -ForegroundColor Green
    } else {
        Write-Host "  MISSING $template" -ForegroundColor Red
        $errors++
    }
}

Write-Host ""

# Check GitHub Copilot files
Write-Host "Checking GitHub Copilot configuration..." -ForegroundColor Cyan
$copilotFiles = @(
    ".github\copilot-instructions.md",
    ".github\agents\BioSpec.agent.md"
)

foreach ($file in $copilotFiles) {
    $path = "$ProjectRoot\$file"
    if (Test-Path $path) {
        Write-Host "  OK $file" -ForegroundColor Green
    } else {
        Write-Host "  MISSING $file" -ForegroundColor Red
        $errors++
    }
}

Write-Host ""

# Check prompts directory
Write-Host "Checking prompt files..." -ForegroundColor Cyan
$promptsDir = "$ProjectRoot\.github\prompts"
if (Test-Path $promptsDir) {
    $promptCount = (Get-ChildItem -Path $promptsDir -Filter "*.prompt.md" -File).Count
    if ($promptCount -gt 0) {
        Write-Host "  OK Found $promptCount prompt files" -ForegroundColor Green
    } else {
        Write-Host "  WARNING No prompt files found" -ForegroundColor Yellow
        $warnings++
    }
} else {
    Write-Host "  MISSING .github\prompts directory" -ForegroundColor Red
    $errors++
}

Write-Host ""

# Check project directory if it exists
$ProjectDir = "$ProjectRoot\project"
if (Test-Path $ProjectDir) {
    Write-Host "Checking project instances..." -ForegroundColor Cyan

    # Count instances
    $intentCount = 0
    $datasetCount = 0
    $analysisCount = 0

    if (Test-Path "$ProjectDir\intents") {
        $intentCount = (Get-ChildItem -Path "$ProjectDir\intents" -Filter "intent-*.md" -File -ErrorAction SilentlyContinue).Count
    }
    if (Test-Path "$ProjectDir\datasets") {
        $datasetCount = (Get-ChildItem -Path "$ProjectDir\datasets" -Filter "dataset-*.md" -File -ErrorAction SilentlyContinue).Count
    }
    if (Test-Path "$ProjectDir\analyses") {
        $analysisCount = (Get-ChildItem -Path "$ProjectDir\analyses" -Filter "analysis-*.md" -File -ErrorAction SilentlyContinue).Count
    }

    Write-Host "  Intents: $intentCount"
    Write-Host "  Datasets: $datasetCount"
    Write-Host "  Analyses: $analysisCount"

    # Check for placeholder values in project files
    Write-Host ""
    Write-Host "Checking for unfilled placeholders..." -ForegroundColor Cyan
    $placeholderFiles = Get-ChildItem -Path $ProjectDir -Filter "*.md" -File |
        Where-Object { (Get-Content $_.FullName -Raw) -match "YYYY-MM-DD|\{n\}|\{Short|\{Name|\{Descriptor" }

    if ($placeholderFiles) {
        Write-Host "  WARNING Files with placeholders:" -ForegroundColor Yellow
        foreach ($file in $placeholderFiles) {
            Write-Host "    - $($file.Name)"
        }
        $warnings++
    } else {
        Write-Host "  OK No obvious placeholders found" -ForegroundColor Green
    }
} else {
    Write-Host "Note: project\ directory not yet created" -ForegroundColor Yellow
    Write-Host "  Run setup-project.ps1 to create the project structure"
}

Write-Host ""
Write-Host "=============================="
if ($errors -eq 0 -and $warnings -eq 0) {
    Write-Host "Validation passed!" -ForegroundColor Green
} elseif ($errors -eq 0) {
    Write-Host "Validation passed with $warnings warning(s)" -ForegroundColor Yellow
} else {
    Write-Host "Validation failed with $errors error(s) and $warnings warning(s)" -ForegroundColor Red
    exit 1
}
