#!/usr/bin/env make

.PHONY: all clean cleanall
.SUFFIXES: .tex .pdf .gnuplot .eps

DOCS = example
PLOTS = plot.gnuplot
TEXS = $(patsubst %, %.tex, $(DOCS))
TABLES = table.csv

all: gnuplot tex

.gnuplot.eps:
	gnuplot $<

.tex.pdf:
	-latexmk -f -quiet -pdf -dvi- -ps- \
		-interaction=nonstopmode -shell-escape \
		-pdflatex="pdflatex %O %S" $<

gnuplot: $(patsubst %.gnuplot, %.eps, $(PLOTS))

tex: $(patsubst %.tex, %.pdf, $(TEXS))

clean:
	-latexmk -quiet -c $(TEXS)
	@rm -f $(patsubst %.tex, %.*.*, $(TEXS))

cleanall: clean
	-latexmk -quiet -C $(TEXS)
	@rm -f $(patsubst %.gnuplot, %*.pdf, $(PLOTS))
	@rm -f $(patsubst %.gnuplot, %*.eps, $(PLOTS))
	@rm -f $(patsubst %.csv, %.pdf, $(TABLES))
	@rm -f $(patsubst %.csv, %.tex, $(TABLES))
	@rm -f *~
