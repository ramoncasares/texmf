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
MFFILE="auxiliar.mf"
INDFILE="auxiliar.ind"
INTFILE="auxiliar.int"
NDXFILE="auxiliar.ndx"
ABCFILE="auxiliar.abc"
AUXFILE="auxiliar.aux"

doindex() {
if test -e $INDFILE ; then
   echo "readtex < $INDFILE > $INTFILE"
         readtex < $INDFILE > $INTFILE
   echo "reindex \"$TEXFILE\""
         reindex "$TEXFILE"
   if test -e $NDXFILE ; then
      echo "index $NDXFILE < $INTFILE > $ABCFILE"
            index $NDXFILE < $INTFILE > $ABCFILE
   else
      echo "texsort < $INTFILE > $ABCFILE"
            texsort < $INTFILE > $ABCFILE
   fi
fi
}

if test -e $MFFILE ; then
   echo "Only one pass!"
   doindex
   echo "tex '&plain' \"$TEXFILE\""
   tex '&plain' "$TEXFILE"
else
   echo "First pass"
   doindex
   echo "tex '&plain' \"$TEXFILE\""
   tex '&plain' "$TEXFILE"
   if test -e $MFFILE ; then
      echo "Second pass"
      mf $MFFILE
      LOGFILE="auxiliar.log"
      GFNAME=$(awk '/^Output written on / {print $4}' $LOGFILE)
      GFFILE="$GFNAME"
      PKFILE=${GFFILE%gf}pk
      echo "gftopk $GFFILE $PKFILE"
      gftopk $GFFILE $PKFILE
      doindex
      echo "tex '&plain' \"$TEXFILE\""
      tex '&plain' "$TEXFILE"
   fi
fi

exit

