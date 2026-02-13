---
title: "Kapitel-Template"
lang: de
author: "Hank"
# Optional für Pandoc/EPUB/PDF:
# subtitle: "Bar jeglicher Vernunft"
# date: 2026-02-13
# description: "Kapitelvorlage für Prosa, Songtexte und Gedichte"
# keywords: [Bar, Vernunft, Prosa, Song, Gedicht]
---

<!--
KAPITEL-KONVENTIONEN (KANONISCH / PRAKTISCH)

1) Dateinamen / Kapitel-IDs (dein Parser-Pattern):
   - Kapiteldateien beginnen mit "Chpt_"
   - Nummerierung folgt als Sequenz mit "_" + Zahl:
     Beispiel: Chpt_1_1_Kolbert.md  /  Chpt_2_4_Hank.md
   - Wichtig: Die Nummerierung läuft nur, solange das Pattern "_" + Zahl weitergeht.
     Sobald das endet, beginnt der Kapiteltext/Name-Teil.
   - Der Textteil nach der Nummerierung darf "Kapitel", "Chpt" o.ä. enthalten – maßgebend ist das "_" + Zahl Muster.

2) Sichtbare Kapitelüberschrift:
   - Pro Kapitel genau eine H2 (##) als sichtbarer Kapitelkopf.
   - Format: "Kapitel X.Y – Name" oder "Kapitel X – Name" (wie bei dir).
   - Direkt an die Überschrift einen Pandoc-Anker hängen: {#kap-x-y-name}

3) Anker-Konvention:
   - kleinschreibung, bindestriche, keine umlaute (ä->ae, ö->oe, ü->ue, ß->ss)
   - Beispiel: {#kap-2-4-hank}
-->

## Kapitel X.Y – FIGURNAME {#kap-x-y-figurname}

<!-- OPTIONAL: 1–2 Zeilen Ort/Zeit/Stimmung (trocken, präzise) -->
*Ort/Zeit:* …  
*Stimmung:* …

<!-- OPTIONAL: Bühnen-/Regiehinweise (für Lesefluss getrennt halten) -->
*Hinweis:* (z.B. „Hank spricht ruhig, ohne Pathos.“)

---

### 1) Prosa-Block (Standard)

Hier beginnt der Kapiteltext.  
Absätze klar trennen. Keine Leerzeilen mitten im Satzbau.

**Faustregel Layout:**  
- Pro Absatz 1 Gedanke / 1 Bewegung.  
- Dialoge als eigene Absätze.

**Dialog-Beispiel:**  
„Ein Satz“, sage ich.  
„Und der Raum kippt“, sagt jemand.  
Ich lache nicht. Ich merke nur: Jetzt zählt Abstand.

---

### 2) Song-Layout (Pandoc-sicher)

<!--
Ziel: Zeilenumbrüche müssen IM PDF/EPUB erhalten bleiben.
Dafür entweder:
A) harte Zeilenumbrüche mit zwei Leerzeichen am Ende jeder Zeile, oder
B) ein "Verse"-Block (wenn du LaTeX nutzt), oder
C) Codeblock (monospace – meist NICHT gewünscht für Songs).
Empfohlen: A) harte Zeilenumbrüche.
-->

#### Songtitel: „…“

*Performance-Notiz:* (Tempo, Gefühl, Dynamik)

**[Verse 1]**  
Zeile 1··  
Zeile 2··  
Zeile 3··  

**[Chorus]**  
Zeile 1··  
Zeile 2··  

**[Bridge]**  
Zeile 1··  
Zeile 2··  

<!--
Wichtig:
- Das „··“ steht hier nur als Erinnerung: am Zeilenende zwei Leerzeichen setzen.
- Alternativ kannst du für Songs auch kurze Strophen als einzelne Absätze schreiben,
  aber dann sind Zeilenumbrüche nicht garantiert.
-->

---

### 3) Gedicht-Layout (Pandoc-sicher)

#### Gedichttitel: „…“

Strophe 1, Zeile 1··  
Strophe 1, Zeile 2··  
Strophe 1, Zeile 3··  

(Leerzeile)

Strophe 2, Zeile 1··  
Strophe 2, Zeile 2··  

---

### 4) Minimal-Metadaten pro Kapitel (optional, maschinenlesbar)

<!--
Wenn du pro Kapitel Metadata brauchst, nimm HTML-Kommentare als "Header".
Pandoc ignoriert sie im Output, aber du kannst sie parsen.
-->

<!--
META:
  pov: Hank
  scene: "Abend danach"
  location: "Bar jeglicher Vernunft"
  mood: "ruhig / gespannt"
  tags: ["bar", "vernunft", "chor", "grenze"]
-->

---

### 5) Link-/Wiki-Export-Strategie (kurz & robust)

<!--
Wenn du Wiki-Links nutzt ([[LikeThis]]), entscheide dich für EINE Strategie:

A) Zettlr/Wiki intern behalten, vor Export transformieren:
   - Vor Pandoc per Script:
     [[Name]] -> [Name](Name.md) oder -> [Name](#anker)

B) Direkte Markdown-Links schreiben:
   - [00_Impressum](00_Impressum.md)
   - [Kapitel 2.4 – Hank](Chpt_2_4_Hank.md)

Empfehlung:
- Für Bücher: A) (Transform-Step), weil dein Schreiben sauber bleibt.
-->

<!-- Ende Kapiteltemplate -->
