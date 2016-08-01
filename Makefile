#!/usr/bin/env make

.PHONY: all clean cleanall
.SUFFIXES: .tex .pdf .gnuplot

DOCS=example plot
PLOTS = plot.gnuplot
TEXS = $(patsubst %, %.tex, $(DOCS))
TABLES = table.csv

all: gnuplot tex

.gnuplot.tex:
	gnuplot $<

.tex.pdf:
	-latexmk -f -quiet -pdf -dvi- -ps- \
		-interaction=nonstopmode -shell-escape \
		-pdflatex="pdflatex %O %S" $<

gnuplot: $(patsubst %.gnuplot, %.tex, $(PLOTS))

tex: $(patsubst %.tex, %.pdf, $(TEXS))

clean:
	-latexmk -quiet -c $(TEXS)
	@rm -f $(patsubst %.tex, %.*.*, $(TEXS))

cleanall: clean
	-latexmk -quiet -C $(TEXS)
	@rm -f $(patsubst %.csv, %.pdf, $(TABLES))
	@rm -f $(patsubst %.csv, %.tex, $(TABLES))
	@rm -f $(patsubst %.gnuplot, %.tex, $(PLOTS))
	@rm -f *~
