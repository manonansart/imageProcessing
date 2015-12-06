all: clean compil

clean:
	rm -f rapport.pdf

compil:
	pdflatex rapport.tex
	pdflatex rapport.tex
	pdflatex rapport.tex
	rm -f *.aux *.log *.out *.bbl *.blg

run: clean compil
	open rapport.pdf
