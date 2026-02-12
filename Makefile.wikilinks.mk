# Include this file from your Makefile:
#   include Makefile.wikilinks.mk

PANDOC ?= pandoc
INPUT_DIR ?= .

html:
\tpwsh -NoProfile -ExecutionPolicy Bypass -File tools/build_html.ps1 -InputDir "$(INPUT_DIR)" -PandocExe "$(PANDOC)"

convert-wikilinks:
\tpwsh -NoProfile -ExecutionPolicy Bypass -File tools/convert-wikilinks.ps1 -InputDir "$(INPUT_DIR)" -OutputDir ".build/md"

