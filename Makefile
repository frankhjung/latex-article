#!/usr/bin/env make

.PHONY: all clean cleanall
.SUFFIXES: .tex .pdf .gnuplot .eps

TEXS = example.tex
GNUPLOTS = normal.gnuplot

all: clean gnuplot tex

.gnuplot.eps:
	gnuplot $<

.tex.pdf:
	latexmk -pdf -quiet \
		-pdflatex="pdflatex -shell-escape %O %S" $<

gnuplot: $(patsubst %.gnuplot, %.eps, $(GNUPLOTS))

tex: $(patsubst %.tex, %.pdf, $(TEXS))

clean:
	rm -f *~ *.aux *.bak *.dvi *.eps *.fdb_latexmk *.fls \
		example.*.gnuplot *.gz *.lo? *.out *.table *.toc

cleanall: clean
	latexmk -C $(TEXS)
	rm -f normal*.pdf
