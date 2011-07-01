#!/bin/dash

if test "[$1]" = "[]" ; then
   echo "Usage: $0 filename[.tex]"
   exit 1
fi

APATH=$(dirname "$(readlink -f "$1")")
if test "$APATH" != "$(pwd)" ; then
   echo "cd \"$APATH\""
   cd "$APATH"
fi

TEXFILE=$(basename "$1")
BASEFILE=$(basename "$1" .tex)
MFFILE="auxiliar.mf"
INDFILE="auxiliar.ind"
INTFILE="auxiliar.int"
NDXFILE="auxiliar.ndx"
ABCFILE="auxiliar.abc"
AUXFILE="auxiliar.aux"

if test -f "$BASEFILE.ndx" ; then
   echo "Pass 0"
   echo "iconv -f UTF-8 -t ISO-8859-1 -o $NDXFILE \"$BASEFILE.ndx\""
   iconv -f UTF-8 -t ISO-8859-1 -o $NDXFILE "$BASEFILE.ndx"
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
         echo "texsort < $INTFILE > $ABCFILE"
               texsort < $INTFILE > $ABCFILE
      fi
   fi
   echo "tex '&spplain' \"$TEXFILE\""
   PREMF="$POSTMF"
   PREAUX="$POSTAUX"
   PREIND="$POSTIND"
   tex '&spplain' "$TEXFILE"
   POSTMF=$(md5sum $MFFILE 2>&1)
   POSTAUX=$(md5sum $AUXFILE 2>&1)
   POSTIND=$(md5sum $INDFILE 2>&1)
   if test "$POSTMF" != "$PREMF" ; then
      echo "mf $MFFILE"
      mf $MFFILE
      LOGFILE="auxiliar.log"
      GFNAME=$(awk '/^Output written on / {print $4}' $LOGFILE)
      GFFILE="$GFNAME"
      PKFILE=${GFFILE%gf}pk
      echo "gftopk $GFFILE $PKFILE"
      gftopk $GFFILE $PKFILE
   fi
done

exit

