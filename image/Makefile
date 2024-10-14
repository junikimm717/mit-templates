clean:
	rm -rf main-*
	rm -rf main.pdf
	rm -rf *.aux *.auxlock *.fls *.fdb_latexmk *.log *.out *.pre

main.pdf:
	latexmk -pdf

watch:
	latexmk -pdf -pvc

all: main.pdf

.PHONY: watch all clean
