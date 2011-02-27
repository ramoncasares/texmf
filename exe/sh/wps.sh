#!/bin/sh

#PATH=/home/papa/bin:$PATH

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

function doindex() {
 if test -e $INDFILE ; then
  echo "readtex < $INDFILE > $INTFILE"
  readtex < $INDFILE > $INTFILE
  if test -e $NDXFILE ; then
   echo "index $NDXFILE < $INTFILE > $ABCFILE"
   index $NDXFILE < $INTFILE > $ABCFILE
  else
   echo "sort $INTFILE > $ABCFILE"
   sort $INTFILE > $ABCFILE
  fi
 fi
}

AUXFILE="auxiliar.aux"
echo "touch $AUXFILE"
touch $AUXFILE

MFFILE="auxiliar.mf"
doindex
if test -e $MFFILE ; then
 echo "Only one pass!"
 tex '&spplain' "$TEXFILE"
else
 echo "First pass"
 tex '&spplain' "$TEXFILE"
 if test -e $MFFILE ; then
  mpost $MFFILE
  doindex
  echo "Second pass"
  tex '&spplain' "$TEXFILE"
 fi
fi
echo "dvips -o -j -K -M $DVIFILE"
dvips -o -j -K -M "$DVIFILE"
exit
