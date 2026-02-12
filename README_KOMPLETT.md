# Bar jeglicher Vernunft – Komplettpaket

Dieses Paket enthält:
- **src/**: Markdown-Quellen (POV: konsequent *Ich* pro Kapitel; **Kap_1_Thomas** bleibt namenfrei).
- **tools/**: PowerShell-Tools zum Konvertieren von `[[WikiLinks]]` → normale Markdown-Links und zum Bauen von HTML via Pandoc.
- **html/**: bereits gebautes HTML (inkl. `index.html`, `site.css`, Prev/Next + Home-Navigation).

## Quickstart (Website lokal öffnen)
1. ZIP entpacken
2. `html/index.html` im Browser öffnen

## Rebuild (Windows PowerShell / pwsh)
### 1) WikiLinks konvertieren → Markdown in `.build/md`
```powershell
pwsh .\tools\convert-wikilinks.ps1 -InputDir .\src -OutputDir .\.build\md
```

### 2) HTML bauen (Pandoc muss im PATH sein)
```powershell
pwsh .\tools\build_html.ps1 -InputDir .\src -PandocExe pandoc
```

Output landet in `.build/html`.

## Konventionen
- Kapitelüberschriften enthalten stabile IDs, z.B. `{#kap-2-2-francine}`.
- WikiLinks können optional Anchors enthalten: `[[Kap_2_Aurelia#kap-2-aurelia|Kapitel 2]]`.
- Maximal **1 Link pro Absatz** (im aktuellen Stand so eingehalten).

