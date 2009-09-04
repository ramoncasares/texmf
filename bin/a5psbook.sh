#!/bin/sh
PATH=/home/papa/bin:$PATH
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
PSFILE="$CPATH/$CNM.ps"
PSXFILE="$CPATH/$CNM.x.ps"
PSEFILE="$CPATH/$CNM.e.ps"
PSOFILE="$CPATH/$CNM.o.ps"
psbook -s32 $PSFILE $PSXFILE
pstops 4:0L(29.7cm,0)+1L(29.7cm,14.85cm) $PSXFILE $PSEFILE
pstops 4:2L(29.7cm,0)+3L(29.7cm,14.85cm) $PSXFILE $PSOFILE
#rm $PSXFILE
