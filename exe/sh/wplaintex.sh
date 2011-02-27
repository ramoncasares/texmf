#!/bin/sh
CPATH=${1%/*}
CNAME=${1##*/}
CNM=${CNAME%.*}
if test "$1" = "$CPATH" ; then
 CPATH="."
else
 cd $CPATH
fi
#echo CPATH = $CPATH, CNAME = $CNAME, CNA = $CNA
#pwd
TEXFILE="$CPATH/$CNM.tex"
DVIFILE="$CPATH/$CNM.dvi"
AUXFILE="$CPATH/auxiliar.aux"
MFFILE="$CPATH/auxiliar.mf"
#LOGFILE="$CPATH/auxiliar.log"
echo DVIFILE = $DVIFILE
echo AUXFILE = $AUXFILE
#echo LOGFILE= $LOGFILE
#GFNAME=`awk '/^Output written on / {print $4}' $LOGFILE`
#GFFILE="$CPATH/$GFNAME"
#PKFILE=${GFFILE%gf}pk
#echo GFFILE = $GFFILE
#echo PKFILE = $PKFILE
#exit

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
 tex '&plain' $TEXFILE
else
 echo "First pass"
 doindex
 tex '&plain' $TEXFILE
 if test -e $MFFILE ; then
  echo "Second pass"
  #if exist auxiliar.mpx del auxiliar.mpx
  mf $MFFILE
  LOGFILE="$CPATH/auxiliar.log"
  GFNAME=`awk '/^Output written on / {print $4}' $LOGFILE`
  GFFILE="$CPATH/$GFNAME"
  PKFILE=${GFFILE%gf}pk
  gftopk $GFFILE $PKFILE
  doindex
  tex '&plain' $TEXFILE
 fi
fi
