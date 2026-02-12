<#
.SYNOPSIS
  Builds HTML from Markdown using Pandoc, with WikiLinks converted first.
  Produces:
    .build/md   (converted markdown)
    .build/html (html output)

.EXAMPLE
  pwsh .\tools\build_html.ps1 -InputDir . -PandocExe pandoc

.NOTES
  Requires pandoc on PATH (or pass -PandocExe full path).
#>

[CmdletBinding()]
param(
  [Parameter(Mandatory=$false)]
  [string]$InputDir = ".",
  [Parameter(Mandatory=$false)]
  [string]$PandocExe = "pandoc",
  [Parameter(Mandatory=$false)]
  [string]$BuildDir = ".\.build",
  [Parameter(Mandatory=$false)]
  [string]$From = "markdown+smart",
  [Parameter(Mandatory=$false)]
  [string]$To = "html",
  [Parameter(Mandatory=$false)]
  [string[]]$PandocArgs = @("--standalone","--toc","--metadata","lang=de")
)

$mdDir   = Join-Path $BuildDir "md"
$htmlDir = Join-Path $BuildDir "html"

# 1) Convert wikilinks
pwsh -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "convert-wikilinks.ps1") -InputDir $InputDir -OutputDir $mdDir -LinkExt ".html"

# 2) Build html (1 file -> 1 html)
if (!(Test-Path $htmlDir)) { New-Item -ItemType Directory -Force -Path $htmlDir | Out-Null }

$files = Get-ChildItem -Path $mdDir -Recurse -File -Filter "*.md" | Where-Object { $_.FullName -notmatch [regex]::Escape("\.build\") }

foreach($f in $files) {
  $rel = Resolve-Path -LiteralPath $f.FullName | ForEach-Object {
    $_.Path.Substring((Resolve-Path $mdDir).Path.Length).TrimStart('\','/')
  }
  $outPath = Join-Path $htmlDir ([IO.Path]::ChangeExtension($rel, ".html"))
  $outDir = Split-Path -Parent $outPath
  if (!(Test-Path $outDir)) { New-Item -ItemType Directory -Force -Path $outDir | Out-Null }

  & $PandocExe "--from=$From" "--to=$To" @PandocArgs "-o" $outPath $f.FullName
  Write-Host "HTML: $rel -> $outPath"
}

Write-Host "Done. HTML in: $htmlDir"
