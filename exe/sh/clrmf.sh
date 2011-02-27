#!/bin/sh

CPATH=${1%/*}
if test "$1" != "$CPATH" ; then
 echo "cd \"$CPATH\""
 cd "$CPATH"
fi
#echo "pwd = `pwd`"

echo "rm auxiliar.mf"
rm auxiliar.mf
