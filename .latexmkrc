# latexmk configuration for en-linalg-2.
#
# With this file present, a bare `latexmk` in the repository root builds the
# book with the right number of passes (the document needs at least two: the
# table of contents and every \cref resolve on the second). `latexmk -c`
# cleans up afterwards, `latexmk -C` also removes the PDF.

$pdf_mode = 1;    # pdflatex, not dvi/ps
$dvi_mode = 0;
$postscript_mode = 0;

# -file-line-error makes errors clickable in an editor; -halt-on-error stops at
# the first one instead of burying it in 450 pages of log.
$pdflatex = 'pdflatex -interaction=nonstopmode -halt-on-error -file-line-error %O %S';

@default_files = ('en-linalg-2.tex');

# Files latexmk should treat as its own droppings when cleaning.
$clean_ext = 'fdb_latexmk fls synctex.gz run.xml';
