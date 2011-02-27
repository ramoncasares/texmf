#!/bin/sh

PATH=/home/papa/bin:$PATH

CPATH=${1%/*}
CNAME=${1##*/}
CNM=${CNAME%.*}
if test "$1" != "$CPATH" ; then
 echo "cd \"$CPATH\""
 cd "$CPATH"
fi
#echo CPATH = $CPATH, CNAME = $CNAME, CNA = $CNA
#pwd

LOGFILE="$CNM.log"
DVIFILE="$CNM.dvi"
AUXFILES="auxiliar.*"
#echo LOGFILE = $LOGFILE
#echo DVIFILE = $DVIFILE
#echo AUXFILES = $AUXFILES

echo "rm \"$LOGFILE\""
rm "$LOGFILE"
echo "rm \"$DVIFILE\""
rm "$DVIFILE"
echo "rm $AUXFILES"
rm $AUXFILES
