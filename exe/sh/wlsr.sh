#!/bin/sh
if [ $(whoami) == 'root' ] ; then
 echo 'Sorry, but the root user cannot do this'
 exit 1
fi
echo "mktexlsr ~/texmf"
mktexlsr ~/texmf
