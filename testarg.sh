#!/bin/bash
#
# check for an argument, print a usage message if not supplied.
#
if [ $# -eq 0 ] ; then
      echo "Usage: $0 argument"
      exit 1
fi
echo "Argument passed is: "$1
exit 0

# ./testarg.sh Hello
