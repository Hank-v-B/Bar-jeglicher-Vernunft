# Export-Strategie: Wiki-Links (Zettlr/Obsidian) → Markdown

## Ziel
Dein Manuskript nutzt Wiki-Links wie:

- `[[Kap_1_Thomas]]`
- `[[Kap_1_Thomas|Kapitel 1 – Thomas]]`

Für Pandoc/LaTeX/Word/PDF sollen daraus **normale Markdown-Links** werden:

- `[[Kap_1_Thomas]]` → `[Kap_1_Thomas](Kap_1_Thomas.md)`
- `[[Kap_1_Thomas|Kapitel 1 – Thomas]]` → `[Kapitel 1 – Thomas](Kap_1_Thomas.md)`

## Strategie (robust, ohne Pandoc-Tricks)
Wir machen vor dem Pandoc-Lauf einen **Preprocess-Schritt**, der die Wiki-Links in der *Quelldatei* umwandelt (oder in einer Export-Kopie).

### Schritt 1: Konvertieren
PowerShell:

```powershell
.	ools\Convert-WikiLinks.ps1 -Input .\BJV_Buch.md -Output .\_export\BJV_Buch.md
```

Oder direkt (plattformneutral):

```bash
python tools/convert_wikilinks.py < BJV_Buch.md > _export/BJV_Buch.md
```

### Schritt 2: Pandoc auf die Export-Kopie
Beispiel (PDF):

```powershell
pandoc .\_export\BJV_Buch.md -o .\_export\BJV_Buch.pdf
```

> Wichtig: Die verlinkten Kapiteldateien liegen weiterhin daneben. Pandoc findet sie als Dateien,
> wenn du mit `--resource-path=.` (oder entsprechendem Projektpfad) arbeitest.

## Gate/Test
1. Öffne `._export\BJV_Buch.md` und prüfe: **kein** `[[` kommt mehr vor.
2. Pandoc-Run: Output erzeugt, Links bleiben anklickbar (mind. im HTML/Docx testbar).
3. Optionaler Grep-Test:

```powershell
Select-String -Path .\_export\BJV_Buch.md -Pattern "\[\[" -Quiet
```
Muss **False** liefern.
