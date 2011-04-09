#!/bin/dash

if test "[$1]" = "[]" ; then
   echo "rm auxiliar.mf"
   rm auxiliar.mf
elif test -d "$1" ; then
   echo "rm \"$1/auxiliar.mf\""
   rm "$1/auxiliar.mf"
else
   APATH=$(dirname "$(readlink -f "$1")")
   if test "$APATH" != "$(pwd)" ; then
      echo "rm auxiliar.mf"
      rm auxiliar.mf
   else
      echo "rm \"$APATH/auxiliar.mf\""
      rm "$APATH/auxiliar.mf"
   fi
fi

