## Location of Pandoc support files.
PREFIX = /home/rejuvyesh/.pandoc

# ## Markdown extension (e.g. md, markdown, mdown).
# MEXT = md

# ## All markdown files in the working directory
# SRC = $(wildcard *.$(MEXT))
SRC = report.md
PDFS=$(SRC:.md=.pdf)
HTML=$(SRC:.md=.html)
TEX=$(SRC:.md=.tex)

all:	$(PDFS) $(HTML) $(TEX)

pdf:	clean $(PDFS)
html:	clean $(HTML)
tex:	clean $(TEX)

%.html:	%.md
	pandoc -r markdown+simple_tables+table_captions+yaml_metadata_block+tex_math_dollars -w html -S --template=$(PREFIX)/templates/html.template --css=css/healy-paper.css -o $@ $<

%.tex:	%.md
	pandoc -r markdown+simple_tables+table_captions+yaml_metadata_block+tex_math_dollars -w latex -s -S --latex-engine=pdflatex --template=$(PREFIX)/templates/latex.template  -o $@ $<

%.pdf:	%.md
	pandoc -r markdown+simple_tables+table_captions+yaml_metadata_block+tex_math_dollars -s -S --latex-engine=xelatex -o $@ $<

plot:
	matlab -nojvm -nodisplay -nosplash -r "plotres"

clean:
	rm -f *.html *.pdf *.tex

