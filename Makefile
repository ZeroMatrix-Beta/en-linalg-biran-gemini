# Build the book and check the sources. Needs TeX Live (latexmk, pdflatex).
#
#   make            build the PDF, then run the source checks
#   make pdf        build the PDF only
#   make check      run the source checks only (reads the existing .aux)
#   make clean      remove build artefacts, keep the PDF
#   make distclean  remove build artefacts and the PDF
#
# `make` is not part of TeX Live. Without it, the same two steps are:
#
#   latexmk                  (configured by .latexmkrc)
#   bash tools/check.sh

MAIN    := en-linalg-2
LATEXMK := latexmk

# pdflatex leaves a pdflatex<PID>.fls stub behind when a run is started from
# the wrong directory and aborts. Neither latexmk nor .gitignore's *.fls rule
# gets them out of the working tree, so sweep them here.
STRAY := pdflatex*.fls content/texput.log

.PHONY: all pdf check clean distclean help
.DEFAULT_GOAL := all

# Recursive rather than `all: pdf check`, so the checks still run after the
# build under `make -j`.
all:
	$(MAKE) pdf
	$(MAKE) check

pdf:
	$(LATEXMK) $(MAIN).tex

check:
	bash tools/check.sh

clean:
	-$(LATEXMK) -c $(MAIN).tex
	rm -f $(STRAY)

distclean:
	-$(LATEXMK) -C $(MAIN).tex
	rm -f $(STRAY)

help:
	@sed -n '2,13p' $(firstword $(MAKEFILE_LIST)) | sed 's/^# \{0,1\}//'
