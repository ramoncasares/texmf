#!/bin/dash

if test "[$1]" = "[]" ; then
   echo "Usage: $0 filename[.tex]"
   exit 1
fi

NAME=$(basename "$1" ".tex")
APATH=$(dirname "$(readlink -f "$1")")
if test "$APATH" != "$(pwd)" ; then
   echo "cd \"$APATH\""
   cd "$APATH"
fi

DVIFILE="$NAME.dvi"
AUXFILE="auxiliar.dvi"
# echo DVIFILE = $DVIFILE
# echo AUXFILE = $AUXFILE
if test -e $AUXFILE ; then
 echo "rm $AUXFILE"
 rm $AUXFILE
fi
echo "mv $DVIFILE $AUXFILE"
mv $DVIFILE $AUXFILE
echo "dvicopy $AUXFILE $DVIFILE"
dvicopy $AUXFILE $DVIFILE

exit

