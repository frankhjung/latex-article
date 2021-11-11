# LaTeX Article Example

A example LaTeX project.

See also [Dokuwiki
LaTeX](https://github.com/frankhjung/doc-wiki/tree/master/pages/frank/lyx)
documentation.

## LaTeXila

Build command used in [LaTeXila](https://wiki.gnome.org/Apps/LaTeXila):

### LaTeX to PDF

```bash
latexmk -pdf -e "$latex=q/latex -synctex=1 -shell-escape %0 %S/" $filename
```

Alternatively there you can just call
[make](https://www.gnu.org/software/make/):

### Makefile

```bash
make cleanall all
```

## Tables and formatting

Links to PDF documents:

* [pgfplotstable](https://www.latex-tutorial.com/tutorials/advanced/latex-pgfplotstable/)
* [pgfplots](http://pgfplots.sourceforge.net/pgfplots.pdf)
* [siunitx](http://tug.ctan.org/tex-archive/macros/latex/contrib/siunitx/siunitx.pdf)
* [pgfcalendar](http://dickimaw-books.com/latex/admin/html/pgfcalendar.shtml)
