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
DVIFILE="$CPATH/$CNM.dvi"
AUXFILE="$CPATH/auxiliar.dvi"
echo DVIFILE = $DVIFILE
echo AUXFILE = $AUXFILE
exit
if test -e $AUXFILE ; then
 echo "rm $AUXFILE"
 rm $AUXFILE
fi
echo "mv $DVIFILE $AUXFILE"
mv $DVIFILE $AUXFILE
echo "dvicopy $AUXFILE $DVIFILE"
dvicopy $AUXFILE $DVIFILE
