# Required Tools
# - pandoc: https://pandoc.org/
# - htmlark: https://pypi.org/project/HTMLArk/
# - htmlmin: https://www.npmjs.com/package/html-minifier-cli
# - uglifycss: https://www.npmjs.com/package/uglifycss

PANDOC=pandoc
HTMLARK=python3 -m htmlark

.PHONEY: all

all: spec.html

tmp/spec.md: spec/*.md
	-mkdir tmp
	-rm $@
	ls $^ | sort | xargs cat > $@

tmp/unified.min.css: res/*.css
	uglifycss $^ > $@

tmp/spec.html: tmp/spec.md tmp/unified.min.css Makefile res/*
	$(PANDOC) --number-sections --toc --template res/template.html $< -o $@

spec.html: tmp/spec.html
	$(HTMLARK) -o tmp/spec.standalone.html $<
	htmlmin tmp/spec.standalone.html -o $@
