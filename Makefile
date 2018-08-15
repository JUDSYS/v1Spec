# Required Tools
# - pandoc: https://pandoc.org/
# - htmlark: https://pypi.org/project/HTMLArk/

PANDOC=pandoc
HTMLARK=python3 -m htmlark

.PHONEY: all

all: spec.html

tmp/spec.md: spec/*.md
	-mkdir tmp
	-rm $@
	ls $^ | sort | xargs cat > $@

tmp/spec.html: tmp/spec.md Makefile res/*
	$(PANDOC) --number-sections --toc --template res/template.html -s $< -o $@

spec.html: tmp/spec.html
	$(HTMLARK) -o $@ $<