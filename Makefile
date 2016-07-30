#!/usr/bin/env make

.PHONY: all clean cleanall
.SUFFIXES: .tex .pdf .gnuplot .eps

TEXS = example.tex
PLOTS = plot.gnuplot

all: clean gnuplot tex

.gnuplot.eps:
	-gnuplot $<

.tex.pdf:
	-latexmk -quiet -pdf \
		-pdflatex="pdflatex -shell-escape %O %S" $<

gnuplot: $(patsubst %.gnuplot, %.eps, $(PLOTS))

tex: $(patsubst %.tex, %.pdf, $(TEXS))

clean:
	-latexmk -quiet -c $(TEXS)
	-rm -f $(patsubst %.tex, %.*.*, $(TEXS))

cleanall: clean
	-latexmk -quiet -C $(TEXS)
	-rm -f $(patsubst %.gnuplot, %*.pdf, $(PLOTS))
	-rm -f $(patsubst %.gnuplot, %*.eps, $(PLOTS))
