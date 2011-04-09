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
   echo "pdftex '&spdflain' \"$TEXFILE\""
   pdftex '&spdflain' "$TEXFILE"
else
   echo "First pass"
   doindex
   echo "pdftex '&spdflain' \"$TEXFILE\""
   pdftex '&spdflain' "$TEXFILE"
   if test -e $MFFILE ; then
      echo "mpost $MFFILE"
      mpost $MFFILE
      echo "Second pass"
      doindex
      echo "pdftex '&spdflain' \"$TEXFILE\""
      pdftex '&spdflain' "$TEXFILE"
   fi
fi
exit

