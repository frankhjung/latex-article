#!/usr/bin/env make

.PHONY: all clean cleanall
.SUFFIXES: .tex .pdf .gnuplot .eps
.DEFAULT: all

DOCS = article attachment
PLOTS = plot.gnuplot
TEXS = $(patsubst %, %.tex, $(DOCS))
TABLES = table.csv

.gnuplot.eps:
	-gnuplot $<

.tex.pdf:
	-latexmk -f -quiet -pdf -dvi- -ps- \
		-interaction=nonstopmode -shell-escape \
		-pdflatex="pdflatex %O %S" $<

gnuplot := $(patsubst %.gnuplot, %.eps, $(PLOTS))

tex := $(patsubst %.tex, %.pdf, $(TEXS))

all: $(gnuplot) $(tex)

clean:
	-latexmk -quiet -c $(TEXS)
	@$(RM) $(patsubst %.tex, %.*.*, $(TEXS))

cleanall: clean
	-latexmk -quiet -C $(TEXS)
	@$(RM) $(patsubst %.gnuplot, %*.pdf, $(PLOTS))
	@$(RM) $(patsubst %.gnuplot, %*.eps, $(PLOTS))
	@$(RM) $(patsubst %.csv, %.pdf, $(TABLES))
	@$(RM) $(patsubst %.csv, %.tex, $(TABLES))
	@$(RM) *~
