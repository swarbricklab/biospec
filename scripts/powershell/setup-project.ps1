# BioSpec - Setup Project Structure
# Creates the project directory structure with template copies
# Portions of this file are adapted from GitHub's spec-kit tool.
# Copyright (c) GitHub, Inc.
# Licensed under the MIT License - see THIRD_PARTY_LICENSES.md.

$ErrorActionPreference = "Stop"

# Get script directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent (Split-Path -Parent $ScriptDir)

Write-Host "BioSpec - Project Setup" -ForegroundColor Cyan
Write-Host "========================="
Write-Host ""

# Check if .biospec directory exists
if (-not (Test-Path "$ProjectRoot\.biospec")) {
    Write-Host "Error: .biospec directory not found" -ForegroundColor Red
    Write-Host "Please ensure you're running this from a BioSpec project root"
    exit 1
}

# Create project directory if it doesn't exist
$ProjectDir = "$ProjectRoot\project"
if (-not (Test-Path $ProjectDir)) {
    New-Item -ItemType Directory -Path $ProjectDir | Out-Null
    Write-Host "Created project directory" -ForegroundColor Green
}

# Create subdirectories
$subdirs = @("intents", "datasets", "analyses")
foreach ($subdir in $subdirs) {
    $path = "$ProjectDir\$subdir"
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Path $path | Out-Null
    }
}
Write-Host "Created subdirectories: intents, datasets, analyses" -ForegroundColor Green

# Copy overview templates if they don't exist
$templates = @(
    "project_overview.md",
    "intent_overview.md",
    "dataset_overview.md",
    "analysis_overview.md",
    "project_resources.md",
    "status.md"
)

foreach ($template in $templates) {
    $targetPath = "$ProjectDir\$template"
    $sourcePath = "$ProjectRoot\.biospec\$template"

    if (-not (Test-Path $targetPath)) {
        if (Test-Path $sourcePath) {
            Copy-Item $sourcePath $targetPath
            Write-Host "Copied $template" -ForegroundColor Green
        } else {
            Write-Host "Warning: Template not found: $template" -ForegroundColor Red
        }
    } else {
        Write-Host "Skipped $template (already exists)" -ForegroundColor Cyan
    }
}

Write-Host ""
Write-Host "Project structure setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Edit project\project_overview.md with your project details"
Write-Host "  2. Use 'create-instance.ps1 intent' to create research intents"
Write-Host "  3. Use 'create-instance.ps1 dataset' to add datasets"
Write-Host "  4. Use 'create-instance.ps1 analysis' to define analyses"
Write-Host ""
