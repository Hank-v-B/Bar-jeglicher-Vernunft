#!/usr/bin/env python3
"""
Convert Obsidian/Zettlr-style wiki-links to standard Markdown links.

Patterns:
  [[File]] -> [File](File.md)
  [[File|Text]] -> [Text](File.md)

Notes:
- If File already ends with an extension (.md, .pdf, etc.), we keep it.
- If File contains an anchor like File#Heading, we append .md before the # (File.md#Heading).
- Leaves non-matching text untouched.

Usage:
  python tools/convert_wikilinks.py input.md > output.md
"""
from __future__ import annotations
import re
import sys
from pathlib import Path

WIKI = re.compile(r"\[\[([^\]]+)\]\]")

def normalize_target(raw: str) -> str:
    # Split anchor if present
    if "#" in raw:
        base, anchor = raw.split("#", 1)
        base = base.strip()
        anchor = anchor.strip()
        ext = Path(base).suffix
        if ext == "":
            base = base + ".md"
        return f"{base}#{anchor}"
    base = raw.strip()
    ext = Path(base).suffix
    if ext == "":
        base = base + ".md"
    return base

def repl(match: re.Match[str]) -> str:
    inner = match.group(1).strip()
    if "|" in inner:
        target, text = inner.split("|", 1)
        target = normalize_target(target.strip())
        text = text.strip()
        return f"[{text}]({target})"
    target = normalize_target(inner)
    text = inner
    return f"[{text}]({target})"

def main() -> int:
    data = sys.stdin.read()
    out = WIKI.sub(repl, data)
    sys.stdout.write(out)
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
