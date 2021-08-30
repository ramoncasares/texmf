#!/bin/dash

if test "[$1]" = "[]" ; then
   echo "Usage: $0 filename[.tex] [format]"
   echo "       format: use 'tex' for plain; if omited, then it uses esplain"
   echo "       except when '\input RCstyle' is found in the file,"
   echo "          and then it uses plain"
   exit 1
fi

BASEFILE=$(basename "$1" .tex)
TEXFILE="$BASEFILE.tex"

if grep -q '\end{document}' "$BASEFILE.tex" ; then
   dash /home/papa/texmf/exe/sh/wlpdf.sh "$BASEFILE.tex"
   exit
fi

FORMAT="-fmt=$2"
if test "[$2]" = "[]" ; then
   if grep -q '\input RCstyle' "$BASEFILE.tex" ; then
      FORMAT=""
   else
      FORMAT="-fmt=esplain"
   fi
fi

APATH=$(dirname "$(readlink -f "$1")")
if test "$APATH" != "$(pwd)" ; then
   echo "cd \"$APATH\""
   cd "$APATH"
fi

MFFILE="auxiliar.mf"
INDFILE="auxiliar.ind"
INTFILE="auxiliar.int"
NDXFILE="auxiliar.ndx"
ABCFILE="auxiliar.abc"
AUXFILE="auxiliar.aux"
BDBFILE="auxiliar.bdb"
DVIFILE="$BASEFILE.dvi"

if test -f "$BASEFILE.ndx" ; then
   echo "Pass 0"
   echo "iconv -f UTF-8 -t ISO-8859-1 -o $NDXFILE \"$BASEFILE.ndx\""
   iconv -f UTF-8 -t ISO-8859-1 -o $NDXFILE "$BASEFILE.ndx"
fi

if test -f "$BASEFILE.bdb" ; then
   echo "Pass 0"
   echo "iconv -f UTF-8 -t ISO-8859-1 -o $BDBFILE \"$BASEFILE.bdb\""
   iconv -f UTF-8 -t ISO-8859-1 -o $BDBFILE "$BASEFILE.bdb"
fi

PREMF=""
PREAUX=""
PREIND=""
POSTMF=$(md5sum $MFFILE 2>&1)
POSTAUX=$(md5sum $AUXFILE 2>&1)
POSTIND=$(md5sum $INDFILE 2>&1)
i=0
until [ "$POSTMF" = "$PREMF" -a "$POSTAUX" = "$PREAUX" -a "$POSTIND" = "$PREIND" ]
do
   i=$(expr $i + 1)
   echo "Pass $i"
   if test -e $INDFILE -a "$POSTIND" != "$PREIND" ; then
      echo "readtex < $INDFILE > $INTFILE"
            readtex < $INDFILE > $INTFILE
      if test -e $NDXFILE ; then
         echo "index $NDXFILE < $INTFILE > $ABCFILE"
               index $NDXFILE < $INTFILE > $ABCFILE
      else
         echo "iconv -f ISO-8859-1 -t UTF-8 $INTFILE | sort -t} -k 1.10,1 > $ABCFILE"
               iconv -f ISO-8859-1 -t UTF-8 $INTFILE | sort -t} -k 1.10,1 > $ABCFILE
      fi
   fi
   PREMF="$POSTMF"
   PREAUX="$POSTAUX"
   PREIND="$POSTIND"
   echo "tex -interaction nonstopmode \"$FORMAT\" \"$TEXFILE\""
   tex -interaction nonstopmode "$FORMAT" "$TEXFILE"
   POSTMF=$(md5sum $MFFILE 2>&1)
   POSTAUX=$(md5sum $AUXFILE 2>&1)
   POSTIND=$(md5sum $INDFILE 2>&1)
   if test "$POSTMF" != "$PREMF" ; then
      echo "mpost $MFFILE"
      mpost $MFFILE
   fi
done
echo "Final Pass"
echo "dvipdfm \"$DVIFILE\""
dvipdfm "$DVIFILE"

echo "Done on $i pass(es)"

# # Temporal hack until bug on missfont.log is corrected
# echo "Waiting 5s to see if a missfont is generated"
# sleep 5
# if test -f missfont.log ; then
#  echo "File missfont.log found! Deleting it."
#  cat missfont.log
#  mv missfont.log /tmp/
# fi

exit

