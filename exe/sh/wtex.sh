#!/bin/sh

CPATH=${1%/*}
CNAME=${1##*/}
CNM=${CNAME%.*}
if test "$1" = "$CPATH" ; then
 CPATH="."
else
 cd $CPATH
fi
TEXFILE="$CPATH/$CNM.tex"
MFFILE="$CPATH/auxiliar.mf"
#AUXFILE="$CPATH/auxiliar.aux"
#echo AUXFILE = $AUXFILE

INDFILE="$CPATH/auxiliar.ind"
INTFILE="$CPATH/auxiliar.int"
NDXFILE="$CPATH/auxiliar.ndx"
ABCFILE="$CPATH/auxiliar.abc"

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

touch $AUXFILE
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
  #if exist auxiliar.mpx del auxiliar.mpx
  mf $MFFILE
  LOGFILE="$CPATH/auxiliar.log"
  GFNAME=`awk '/^Output written on / {print $4}' $LOGFILE`
  GFFILE="$CPATH/$GFNAME"
  PKFILE=${GFFILE%gf}pk
  echo "gftopk $GFFILE $PKFILE"
  gftopk $GFFILE $PKFILE
  doindex
  tex '&spplain' $TEXFILE
 fi
fi
