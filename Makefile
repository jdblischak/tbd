NAME := tbd
TEX := ch02.tex

all: pdf

pdf: $(NAME).pdf

html: $(NAME).html

docx: $(NAME).docx

## Build paper

$(NAME).pdf: $(NAME).tex $(TEX)
	pdflatex $(NAME)
	bibtex $(NAME)
	pdflatex $(NAME)
	pdflatex $(NAME)

$(NAME).html: $(NAME).tex $(TEX)
	pandoc $< --to html --output $@ --standalone --section-divs --toc --mathjax

$(NAME).docx: $(NAME).tex $(TEX)
	pandoc $< --to docx --output $@

## Miscellaneous

.PHONY: clean clean-deep

clean:
	rm -f *~ *.aux *.log *.lof *.lot *.toc *.bbl *.blg

clean-deep: clean
	rm -f *.pdf *.docx *.html

