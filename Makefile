#!/usr/bin/env make

.PHONY: all lint clean cleanall
.SUFFIXES:
.SUFFIXES: .tex .pdf .gnuplot .eps
.DEFAULT: all

TARGET = article.pdf
TEXS   = $(patsubst %.pdf, %.tex, $(TARGET)) attachment.tex
PLOTS  = plot.gnuplot
TABLES = table.csv

.gnuplot.eps:
	-gnuplot $<

.tex.pdf:
	-latexmk -f \
		-quiet \
		-pdf \
		-shell-escape \
		-interaction=nonstopmode $<

gnuplot := $(patsubst %.gnuplot, %.eps, $(PLOTS))

all: lint $(gnuplot) $(TARGET)

lint:
	-lacheck $(TEXS)

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
