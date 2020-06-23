#!/usr/bin/env make

.PHONY: all lint clean cleanall
.SUFFIXES:
.SUFFIXES: .tex .pdf .gnuplot .eps
.DEFAULT: all

TARGET := article.pdf
TEXS   := $(patsubst %.pdf, %.tex, $(TARGET)) attachment.tex
PLOT   := plot.gnuplot
EPS    := $(patsubst %.gnuplot, %.eps, $(PLOT))
TABLES := table.csv

.gnuplot.eps:
	-gnuplot $<

.tex.pdf:
	-latexmk \
		-f \
		-quiet \
		-pdf \
		-shell-escape \
		-interaction=nonstopmode $<

all: lint $(EPS) $(TARGET)

lint:
	-chktex -v2 $(TEXS)

clean:
	-latexmk -quiet -c $(TEXS)
	@$(RM) *~
	@$(RM) $(patsubst %.tex, %.*.*, $(TEXS))
	@$(RM) __latexindent_temp.tex
	@$(RM) *.pyg
	@$(RM) -rf _minted-article/

cleanall: clean
	-latexmk -quiet -C $(TEXS)
	@$(RM) $(patsubst %.gnuplot, %*.pdf, $(PLOT))
	@$(RM) $(patsubst %.gnuplot, %*.eps, $(PLOT))
	@$(RM) $(patsubst %.csv, %.pdf, $(TABLES))
	@$(RM) $(patsubst %.csv, %.tex, $(TABLES))
