<#
.SYNOPSIS
Converts wiki-links ([[File]] / [[File|Text]]) to Markdown links for Pandoc export.

.EXAMPLE
  .\tools\Convert-WikiLinks.ps1 -Input .\BJV_Buch.md -Output .\_export\BJV_Buch.md
#>
param(
  [Parameter(Mandatory=$true)][string]$Input,
  [Parameter(Mandatory=$true)][string]$Output
)

$python = "python"
if (-not (Get-Command $python -ErrorAction SilentlyContinue)) {
  throw "Python not found on PATH. Install Python 3 or run the converter via another interpreter."
}

$inDir = Split-Path -Parent $Output
if ($inDir -and -not (Test-Path $inDir)) { New-Item -ItemType Directory -Force -Path $inDir | Out-Null }

Get-Content -Raw -Encoding UTF8 $Input | & $python ".\tools\convert_wikilinks.py" | Set-Content -Encoding UTF8 $Output
Write-Host "Wrote: $Output"
