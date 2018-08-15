# Required Tools
# - pandoc: https://pandoc.org/
# - htmlark: https://pypi.org/project/HTMLArk/

PANDOC=pandoc
HTMLARK=python3 -m htmlark

.PHONEY: all

all: spec.html

spec.draft.html: spec.md Makefile res/*
	$(PANDOC) --number-sections --toc --template res/template.html -s $< -o $@

spec.html: spec.draft.html
	$(HTMLARK) -o $@ $<