#!/bin/bash
# This Script is to check owner of file or directory and if owner is not root then change owner to root.

read -p "Enter path of file or directory to check it's owner: " path
owner=$(stat -c "%U" $path)

if [[ $owner!="root" ]]
then
	chown root:root $path
fi
