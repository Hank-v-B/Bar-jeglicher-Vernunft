<#
.SYNOPSIS
  Converts Obsidian/Zettlr-style WikiLinks ([[Target]] or [[Target|Text]]) into normal Markdown links
  while preserving anchors ([[Target#anchor|Text]]).
  Skips fenced code blocks (``` ... ```).

.EXAMPLE
  pwsh .\tools\convert-wikilinks.ps1 -InputDir . -OutputDir .\.build\md

.NOTES
  Assumes UTF-8 files. Designed for Pandoc pipelines (HTML output by default uses .html).
#>

[CmdletBinding()]
param(
  [Parameter(Mandatory=$false)]
  [string]$InputDir = ".",
  [Parameter(Mandatory=$false)]
  [string]$OutputDir = ".\.build\md",
  [Parameter(Mandatory=$false)]
  [string]$LinkExt = ".html",
  [Parameter(Mandatory=$false)]
  [string[]]$Include = @("*.md"),
  [Parameter(Mandatory=$false)]
  [string[]]$Exclude = @(".build", "node_modules", ".git")
)

function ShouldSkipPath([string]$path) {
  foreach($e in $Exclude) {
    if ($path -match [regex]::Escape($e)) { return $true }
  }
  return $false
}

function NormalizeTarget([string]$t) {
  # Strip surrounding whitespace
  $t = $t.Trim()

  # Strip .md if present
  if ($t.ToLower().EndsWith(".md")) { $t = $t.Substring(0, $t.Length - 3) }

  # Use forward slashes for URLs
  $t = $t -replace "\\", "/"

  # Encode spaces
  $t = $t -replace " ", "%20"

  return $t
}

function ReplaceWikiLinksInText([string]$text) {
  # Pattern 1: [[Target#anchor|Text]]
  $pattern1 = '\[\[([^\]\|#]+)(#[^\]\|]+)?\|([^\]]+)\]\]'
  $text = [regex]::Replace($text, $pattern1, {
    param($m)
    $target = NormalizeTarget($m.Groups[1].Value)
    $anchor = $m.Groups[2].Value
    $label  = $m.Groups[3].Value
    return "[${label}](${target}${LinkExt}${anchor})"
  })

  # Pattern 2: [[Target#anchor]]
  $pattern2 = '\[\[([^\]\|#]+)(#[^\]\|]+)?\]\]'
  $text = [regex]::Replace($text, $pattern2, {
    param($m)
    $target = NormalizeTarget($m.Groups[1].Value)
    $anchor = $m.Groups[2].Value
    $label  = $m.Groups[1].Value.Trim()
    return "[${label}](${target}${LinkExt}${anchor})"
  })

  return $text
}

function ConvertOutsideFencedCode([string]$content) {
  # Split by fenced code blocks. Keep delimiters by capturing.
  $re = [regex]'(?s)(```.*?```)'  # non-greedy fenced block
  $parts = $re.Split($content)

  for ($i=0; $i -lt $parts.Length; $i++) {
    $part = $parts[$i]
    if ($part.StartsWith("```")) {
      continue # leave code blocks untouched
    } else {
      $parts[$i] = ReplaceWikiLinksInText $part
    }
  }
  return ($parts -join "")
}

if (!(Test-Path $OutputDir)) { New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null }

$files = @()
foreach($inc in $Include) {
  $files += Get-ChildItem -Path $InputDir -Recurse -File -Filter $inc -ErrorAction SilentlyContinue
}

foreach($f in $files) {
  if (ShouldSkipPath $f.FullName) { continue }

  $rel = Resolve-Path -LiteralPath $f.FullName | ForEach-Object {
    $_.Path.Substring((Resolve-Path $InputDir).Path.Length).TrimStart('\','/')
  }

  $outPath = Join-Path $OutputDir $rel
  $outDir = Split-Path -Parent $outPath
  if (!(Test-Path $outDir)) { New-Item -ItemType Directory -Force -Path $outDir | Out-Null }

  $raw = Get-Content -LiteralPath $f.FullName -Raw -Encoding UTF8
  $converted = ConvertOutsideFencedCode $raw
  Set-Content -LiteralPath $outPath -Value $converted -Encoding UTF8
  Write-Host "Converted: $rel"
}

Write-Host "Done. Output in: $OutputDir"
