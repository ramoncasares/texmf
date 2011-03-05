#!/bin/dash

if [ "[$1]" = "[]" ] ; then
 echo "Usage: $0 filename[.tex]"
 exit 1
fi

CPATH=${1%/*}
CNAME=${1##*/}
CNA=${CNAME%.*}
if test "$1" = "$CPATH" ; then
 CPATH="."
else
 # Quoted (it can contain spaces)
 cd "$CPATH"
fi
#echo CPATH = $CPATH, CNAME = $CNAME, CNA = $CNA
#pwd

# These two should be quoted also when used
# because they can contain spaces
TEXFILE="$CNAME"
DVIFILE="$CNA.dvi"

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
 tex '&spplain' "$TEXFILE"
else
 echo "First pass"
 doindex
 tex '&spplain' "$TEXFILE"
 if test -e $MFFILE ; then
  mpost $MFFILE
  doindex
  echo "Second pass"
  tex '&spplain' "$TEXFILE"
 fi
fi
echo 'dvips -o -j -K -M "$DVIFILE"'
      dvips -o -j -K -M "$DVIFILE"
exit
