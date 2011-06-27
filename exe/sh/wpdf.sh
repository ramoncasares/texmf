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

PREMF=""
PREAUX=""
POSTMF=$(md5sum $MFFILE 2>&1)
POSTAUX=$(md5sum $AUXFILE 2>&1)
i=0
while test "$POSTMF" != "$PREMF" -o "$POSTAUX" != "$PREAUX" ; do
   i=$(expr $i + 1)
   echo "Pass $i"
   PREMF="$POSTMF"
   PREAUX="$POSTAUX"
   doindex
   echo "pdftex '&spdflain' \"$TEXFILE\""
   pdftex '&spdflain' "$TEXFILE"
   POSTMF=$(md5sum $MFFILE 2>&1)
   POSTAUX=$(md5sum $AUXFILE 2>&1)
   if test "$POSTMF" != "$PREMF" ; then
      echo "mpost $MFFILE"
      mpost $MFFILE
   fi
done

