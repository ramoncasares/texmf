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
NDXFILE="$CPATH/$CNM.ndx"
AUXFILE="$CPATH/auxiliar.ndx"
#echo NDXFILE = $NDXFILE
#echo AUXFILE = $AUXFILE
#exit
if test -e $NDXFILE ; then
 echo "cp $NDXFILE $AUXFILE"
 cp $NDXFILE $AUXFILE
else
 echo "file $NDXFILE not found!"
fi
