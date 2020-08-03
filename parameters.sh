#!/bin/bash

count=1
if [[ "$#" -eq 0 ]]
then
	echo "No Parameters passed...! Exiting...!"
	exit 1
fi
while [ -n "$*" ]
do
   echo "This is parameter number $count $1"
   shift
   count=`expr $count + 1`
done
