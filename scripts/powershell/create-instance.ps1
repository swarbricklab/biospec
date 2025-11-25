# BioSpec - Create Instance
# Creates a new intent, dataset, or analysis instance from templates
# Portions of this file are adapted from GitHub's spec-kit tool.
# Copyright (c) GitHub, Inc.
# Licensed under the MIT License - see THIRD_PARTY_LICENSES.md.

param(
    [Parameter(Mandatory=$true, Position=0)]
    [ValidateSet("intent", "dataset", "analysis")]
    [string]$Type,

    [Parameter(Position=1)]
    [int]$Number = 0
)

$ErrorActionPreference = "Stop"

# Get script directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent (Split-Path -Parent $ScriptDir)

# Set paths based on type
$Template = "$ProjectRoot\.biospec\subtemplates\$Type.md"
$TargetDir = "$ProjectRoot\project\${Type}s"

# Check template exists
if (-not (Test-Path $Template)) {
    Write-Host "Error: Template not found: $Template" -ForegroundColor Red
    exit 1
}

# Ensure target directory exists
if (-not (Test-Path $TargetDir)) {
    New-Item -ItemType Directory -Path $TargetDir | Out-Null
    Write-Host "Created directory: $TargetDir" -ForegroundColor Green
}

# Auto-detect next number if not specified
if ($Number -eq 0) {
    $Number = 1
    while (Test-Path "$TargetDir\$Type-$Number.md") {
        $Number++
    }
}

$TargetFile = "$TargetDir\$Type-$Number.md"

# Check if file already exists
if (Test-Path $TargetFile) {
    Write-Host "Error: File already exists: $TargetFile" -ForegroundColor Red
    Write-Host "Specify a different number or remove the existing file"
    exit 1
}

# Copy template
Copy-Item $Template $TargetFile

# Read content and replace placeholders
$content = Get-Content $TargetFile -Raw

# Replace {n} with the instance number
$content = $content -replace '\{n\}', $Number

# Update last_updated date
$today = Get-Date -Format "yyyy-MM-dd"
$content = $content -replace 'YYYY-MM-DD', $today

# Write back
Set-Content $TargetFile $content -NoNewline

Write-Host "Created: $TargetFile" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Open $TargetFile in your editor"
Write-Host "  2. Fill in the template fields"
Write-Host "  3. Update the ${Type}_overview.md to include this instance"
Write-Host ""
