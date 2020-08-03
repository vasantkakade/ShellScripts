#!/bin/bash

echo $0 $1 $2

case $1 in
-i)
   count=`grep ^i $2 | wc -l`
   echo "The number of lines in $2 that start with an i is $count"
   ;;
-e)
   count=`grep ^e $2 | wc -l`
   echo "The number of lines in $2 that start with an e is $count"
   ;;
*)
   echo "That option is not recognized"
   ;;
esac

# ./wordcount.sh -i filename
# ./wordcount.sh -e filename
