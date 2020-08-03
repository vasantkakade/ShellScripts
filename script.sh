#!/bin/bash
var=`/sbin/lsmod | grep -E "^[[:blank:]]*usb(-|_)storage[[:blank:]]" 2>/dev/null`
if [[ -n $var ]]
then 
	echo $var
else
	echo "Not Found"
fi
