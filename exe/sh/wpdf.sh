#!/bin/dash

if [ "[$1]" = "[]" ] ; then
 echo "Usage: $0 filename[.tex]"
 exit 1
fi

CPATH=${1%/*}
CNAME=${1##*/}
#echo "CPATH = $CPATH"
#echo "CNAME = $CNAME"

if test "$1" = "$CPATH" ; then
 CPATH="."
else
 # Quoted (it can contain spaces)
 cd "$CPATH"
fi
#pwd

# It should be quoted also when used,
# because it can contain spaces
TEXFILE="$CNAME"

INDFILE="auxiliar.ind"
INTFILE="auxiliar.int"
NDXFILE="auxiliar.ndx"
ABCFILE="auxiliar.abc"
AUXFILE="auxiliar.aux"

doindex() {
 if test -e $INDFILE ; then
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
}

MFFILE="auxiliar.mf"
if test -e $MFFILE ; then
 echo "Only one pass!"
 doindex
 echo "pdftex '&spdflain' $TEXFILE"
 pdftex '&spdflain' "$TEXFILE"
else
 echo "First pass"
 doindex
 echo "pdftex '&spdflain' $TEXFILE"
 pdftex '&spdflain' "$TEXFILE"
 if test -e $MFFILE ; then
  echo "mpost $MFFILE"
  mpost $MFFILE
  echo "Second pass"
  doindex
  echo "pdftex '&spdflain' $TEXFILE"
  pdftex '&spdflain' "$TEXFILE"
 fi
fi
exit
