#!/bin/dash

if test "[$1]" = "[]" ; then
 echo "Usage: $0 filename[.tex]"
 exit 1
fi

CPATH=${1%/*}
CNAME=${1##*/}
CNM=${CNAME%.*}
if test "$1" = "$CPATH" ; then
 CPATH="."
else
 # Quoted (it can contain spaces)
 cd "$CPATH"
fi
#echo CPATH = $CPATH, CNAME = $CNAME, CNA = $CNA
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
 tex '&spplain' $TEXFILE
else
 echo "First pass"
 doindex
 tex '&spplain' $TEXFILE
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
  tex '&spplain' $TEXFILE
 fi
fi
