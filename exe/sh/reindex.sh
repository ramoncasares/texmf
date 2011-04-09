#!/bin/dash

if [ "[$1]" = "[]" ] ; then
 echo "Usage: $0 filename[.tex]"
 echo "   If filename.ndx exists, then it generates auxiliar.ndx"
 exit 1
fi

APATH=$(dirname "$(readlink -f "$1")")
NAMEXT=$(basename $1)
NAME=$(basename "$1" ".$(printf '%s\n' "$NAMEXT" | sed 's/.*\.//')")
# echo APATH = $APATH
# exho NAMEXT = $NEMEXT
# echo NAME = $NAME

if test "$APATH" = "$(pwd)" ; then
 NDXFILE="$NAME.ndx"
 AUXFILE="auxiliar.ndx"
else
 NDXFILE="$APATH/$NAME.ndx"
 AUXFILE="$APATH/auxiliar.ndx"
fi
# echo NDXFILE = $NDXFILE
# echo AUXFILE = $AUXFILE

if test -e $NDXFILE ; then
 echo "iconv -f UTF-8 -t ISO-8859-1 -o \"$AUXFILE\" \"$NDXFILE\""
 iconv -f UTF-8 -t ISO-8859-1 -o "$AUXFILE" "$NDXFILE"
else
 echo "file \"$NDXFILE\" not found!"
fi

