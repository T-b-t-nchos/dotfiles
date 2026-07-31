#!/usr/bin/env perl

# ----------------------------------------
# LaTeX
# ----------------------------------------

$latex = 'uplatex %O -kanji=utf8 -no-guess-input-enc -synctex=1 -interaction=nonstopmode %S';
$pdflatex = 'pdflatex %O -synctex=1 -interaction=nonstopmode %S';
$lualatex = 'lualatex %O -synctex=1 -interaction=nonstopmode %S';
$xelatex = 'xelatex %O -no-pdf -synctex=1 -shell-escape -interaction=nonstopmode %S';

# ----------------------------------------
# Bibliography
# ----------------------------------------

$biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$bibtex = 'upbibtex %O %B';

# ----------------------------------------
# Index
# ----------------------------------------

$makeindex = 'upmendex %O -o %D %S';

# ----------------------------------------
# DVI / PS / PDF
# ----------------------------------------

$dvipdf = 'dvipdfmx %O -o %D %S';
$dvips  = 'dvips %O -z -f %S | convbkmk -u > %D';

# Windowsのみ使用
$ps2pdf = 'ps2pdf.exe %O %S %D';

# ----------------------------------------
# PDF mode
# ----------------------------------------

# $pdf_mode = 4;

# ----------------------------------------
# PDF Viewer
# ----------------------------------------

if ($^O eq 'MSWin32') {
    # Windows
    $pdf_previewer = 'start %S';
} else {
    # Linux/macOS
    $pdf_previewer = 'evince %S';
}
