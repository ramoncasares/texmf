#!/bin/dash

if test "[$1]" = "[]" ; then
   echo "Usage: $0 filename[.tex]"
   exit 1
fi

BASEFILE=$(basename "$1" .tex)
TEXFILE="$BASEFILE.tex"

APATH=$(dirname "$(readlink -f "$1")")
if test "$APATH" != "$(pwd)" ; then
   echo "cd \"$APATH\""
   cd "$APATH"
fi

MFFILE="auxiliar.mf"
AUXFILE="$BASEFILE.aux"
OUTFILE="$BASEFILE.out"

PREMF=""
PREAUX=""
PREOUT=""
POSTMF=$(md5sum $MFFILE 2>&1)
POSTAUX=$(md5sum $AUXFILE 2>&1)
POSTOUT=$(md5sum $OUTFILE 2>&1)
i=0
until [ "$POSTMF" = "$PREMF" -a "$POSTAUX" = "$PREAUX" -a "$POSTOUT" = "$PREOUT" ]
do
   i=$(expr $i + 1)
   echo "Pass $i"
   echo "pdflatex \"$TEXFILE\""
   PREMF="$POSTMF"
   PREAUX="$POSTAUX"
   PREOUT="$POSTOUT"
   pdflatex "$TEXFILE"
   POSTMF=$(md5sum $MFFILE 2>&1)
   POSTAUX=$(md5sum $AUXFILE 2>&1)
   POSTOUT=$(md5sum $OUTFILE 2>&1)
   if test "$POSTMF" != "$PREMF" ; then
      echo "mpost $MFFILE"
      mpost $MFFILE
   fi
done

echo "Done on $i pass(es)"
exit
