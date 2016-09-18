NAME := tbd
TEX := tex/preamble-custom.tex tex/abstract.tex tex/ch02.tex tex/ch04.tex
BIB := refs.bib

all: pdf

pdf: $(NAME).pdf

html: $(NAME).html

docx: $(NAME).docx

## Build paper

$(NAME).pdf: $(NAME).tex $(TEX) $(BIB)
	python code/format-bibtex.py $(BIB)
	pdflatex $(NAME)
	bibtex $(NAME)
	pdflatex $(NAME)
	pdflatex $(NAME)

$(NAME).html: $(NAME).tex $(TEX) $(BIB)
	pandoc $< --to html --output $@ --standalone --section-divs --toc --mathjax

$(NAME).docx: $(NAME).tex $(TEX) $(BIB)
	pandoc $< --to docx --output $@

## Miscellaneous

.PHONY: clean clean-deep

clean:
	rm -f *~ *.aux *.blg *.bbl *.lof *.log *.lot *.out *.toc

clean-deep: clean
	rm -f *.pdf *.docx *.html tex/*.aux
