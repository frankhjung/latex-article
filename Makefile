#!/usr/bin/env make

.PHONY: all clean
.SUFFIXES: .tex .pdf

DOCS=example.tex

all:	clean tex

.tex.pdf:
	latexmk -pdf -quiet \
		-pdflatex="pdflatex -shell-escape %O %S" $<

tex:	$(patsubst %.tex, %.pdf, $(DOCS))

clean:
	latexmk -C $(DOCS)
	rm -f *~ *.aux *.bak *.dvi *.fdb_latexmk *.fls \
		*.gnuplot *.gz *.log *.out *.pdf *.table *.toc
