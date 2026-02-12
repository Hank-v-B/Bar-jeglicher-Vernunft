# WikiLink-Converter (Zettlr/Obsidian → Pandoc)

## What this does
- Converts `[[Target]]` and `[[Target|Text]]` into normal Markdown links.
- Preserves anchors: `[[Target#anchor|Text]]` → `[Text](Target.html#anchor)`
- Skips fenced code blocks (``` ... ```), so code examples stay untouched.
- Then builds HTML via Pandoc (optional script).

## Files
- `tools/convert-wikilinks.ps1`  → produces `.build/md/**.md` (converted)
- `tools/build_html.ps1`         → produces `.build/html/**.html`

## Usage (PowerShell)
From the project root:

### 1) Convert only
```powershell
pwsh .\tools\convert-wikilinks.ps1 -InputDir . -OutputDir .\.build\md
```

### 2) Convert + HTML build (Pandoc)
```powershell
pwsh .\tools\build_html.ps1 -InputDir . -PandocExe pandoc
```

## Expected authoring style (recommended)
- `[[Kap_2_2_Francine|Kapitel 2.2]]`
- `[[Kap_2_2_Francine#kap-2-2-francine|Sprung]]`

## Gate test
After running `build_html.ps1`, open one generated HTML file and verify:
1) Links resolve (`.html` targets exist)
2) Anchors jump correctly (`#kap-...`)
3) No broken links in browser console
