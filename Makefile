.PHONEY: all
MMARK=mmark
XML2RFC=xml2rfc
PATCH=patch

all: judsys-spec.md
	$(MMARK) -2 judsys-spec.md > judsys-spec.xml
	$(XML2RFC) judsys-spec.xml --html --text
	$(PATCH) judsys-spec.html css.patch
