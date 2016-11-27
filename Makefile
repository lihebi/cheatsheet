LATEX		= latex

DVIPS		= dvips
PSNUP		= psnup -W4.25in -H11in -pletter -2
PSBOOK		= psbook
PS2PDF		= ps2pdf -dPDFSETTINGS=/prepress

RM		= rm -f -v
MV		= mv -f -v

all: cheatsheet-single.pdf cheatsheet-double.pdf cheatsheet-booklet.pdf
cheatsheet-single.dvi: cheatsheet.tex cs-*.tex
	$(LATEX) cheatsheet.tex
	$(LATEX) cheatsheet.tex
	$(MV) cheatsheet.dvi $@

cheatsheet-single.ps: cheatsheet-single.dvi
	$(DVIPS) -o $@ $<

cheatsheet-single.pdf: cheatsheet-single.ps
	$(PS2PDF) $< $@

cheatsheet-double.pdf: cheatsheet-single.ps
	$(PSNUP) $< double.ps
	$(PS2PDF) double.ps $@

cheatsheet-booklet.pdf: cheatsheet-single.ps
	$(PSBOOK) $< booklet.ps
	$(PSNUP) booklet.ps > booklet-letter.ps
	$(PS2PDF) -sPAPERSIZE=letter booklet-letter.ps $@



clean:
	$(RM) *.dvi *.toc *.aux *.log *.idx *.ilg *.ind *.out *.ps *.pdf *~
	$(RM) -r gh-pages

