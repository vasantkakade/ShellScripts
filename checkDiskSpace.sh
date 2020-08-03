#!/bin/bash
read -p "Enter the partition name to check disk space status: " partition
dspace=$(df -kH | grep $partition | awk '{print($5)}' | cut -d'%' -f1)
echo $dspace"%"

if [[ $dspace -ge 0 && $dspace -le 70 ]]
then
	echo "Normal"
	exit 0
elif [[ $dspace -ge 71 && $dspace -le 80 ]]
then
        echo "Warning"
        exit 1
elif [[ $dspace -ge 81 && $dspace -le 99 ]]
then
        echo "Critical"
        exit 2
elif [[ $dspace -eq 100 ]]
then
        echo "Full"
        exit 3
fi

<<COMMENT1
case $dspace in
	[0-5]*)
		echo "Normal"
		exit 0
		;;
	[6-7]*)
		echo "Warning"
		exit 1
		;;
	[8-9]*)
		echo "Critical"
		exit 2
		;;
	100)
		echo "Full"
		exit 3
		;;
esac
COMMENT1
