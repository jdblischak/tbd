NAME := tbd

all: pdf

html: $(NAME).html

docx: $(NAME).docx

pdf: $(NAME).pdf

## Build paper

$(NAME).html: $(NAME).tex
	pandoc $^ --to html --output $@ --standalone --section-divs --toc --mathjax

$(NAME).docx: $(NAME).tex
	pandoc $^ --to docx --output $@

$(NAME).pdf: $(NAME).tex
	pdflatex $^


## Miscellaneous

.PHONY: clean clean-deep

clean:
	rm -f *~ *.aux *.log *.lof *.lot *.toc

clean-deep: clean
	rm -f *.pdf *.docx *.html

