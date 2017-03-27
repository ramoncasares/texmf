#!/bin/dash

if test "[$1]" = "[]" ; then
   echo "Usage: $0 filename[.tex] [format]"
   echo "       Default format: spplain; use tex for plain"
   exit 1
fi

BASEFILE=$(basename "$1" .tex)
TEXFILE="$BASEFILE.tex"

FORMAT="$2"
if test "[$2]" = "[]" ; then
   if grep -q '\input RCstyle' "$TEXFILE" ; then
      FORMAT="tex"
   else
      FORMAT="spplain"
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
         echo "sort < $INTFILE > $ABCFILE"
               sort < $INTFILE > $ABCFILE
      fi
   fi
   echo "tex \"&$FORMAT\" \"$TEXFILE\""
   PREMF="$POSTMF"
   PREAUX="$POSTAUX"
   PREIND="$POSTIND"
   tex "&$FORMAT" "$TEXFILE"
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

echo "Done on $i pass(es)"
exit
