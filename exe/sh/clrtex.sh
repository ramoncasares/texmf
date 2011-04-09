#!/bin/dash

if test "[$1]" = "[]" ; then
   APATH=$(pwd)
elif test -d "$1" ; then
   APATH=$(readlink -f "$1")
else
   APATH=$(dirname $(readlink -f "$1"))
fi

if test "$APATH" != "$(pwd)" ; then
   echo "cd \"$APATH\""
   cd "$APATH"
fi

echo 'rm auxiliar.*'
rm auxiliar.*
if test "[$1]" != "[]" ; then
   NAMEXT=$(basename $1)
   NAME=$(basename "$1" ".$(printf '%s\n' "$NAMEXT" | sed 's/.*\.//')")
   echo "rm \"$NAME.log\""
   rm "$NAME.log"
   echo "rm \"$NAME.dvi\""
   rm "$NAME.dvi"
fi

exit

