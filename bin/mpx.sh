#!/bin/sh
#not tested!!!
echo mpx %1 %2
echo %1 es auxiliar.mp
echo %2 es auxiliar.mpx
mpto %1 > %2
pdftex '&pdfplain' \pdfoutput=0 \input %2
dvitomp auxiliar.dvi
