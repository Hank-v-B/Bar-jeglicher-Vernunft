param(
    [Parameter(Mandatory = $true)]
    [string]$InputPath,

    [Parameter(Mandatory = $true)]
    [string]$OutputPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Ensure output folder exists
$outDir = Split-Path -Parent $OutputPath
if ($outDir -and -not (Test-Path $outDir)) {
    New-Item -ItemType Directory -Path $outDir | Out-Null
}

# Resolve python
$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) { $python = Get-Command py -ErrorAction SilentlyContinue }
if (-not $python) { throw "Python nicht gefunden. Installiere Python oder nutze 'py'." }

# Converter script location (prefer tools\convert_wikilinks.py next to this script)
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$converter = Join-Path $scriptRoot "tools\convert_wikilinks.py"
if (-not (Test-Path $converter)) {
    throw "Converter nicht gefunden: $converter"
}

# Read -> convert -> write
$content = Get-Content -Raw -Encoding UTF8 $InputPath
$converted = $content | & $python $converter
Set-Content -Path $OutputPath -Value $converted -Encoding UTF8

Write-Host "OK: $InputPath -> $OutputPath"
