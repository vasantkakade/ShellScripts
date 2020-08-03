#!/bin/bash
read -p "Enter user name to show details: " uname
if [[ $(cat /etc/passwd | grep $uname) ]]
then
	cat /etc/passwd | grep -w $uname | awk -F':' '{print "Username: "$1", ""UserID: "$3", ""User Home Dir: "$6", ""User Shell: "$7}'
else
	echo "User $uname does not exist...!"
	read -r -p "Do you want to add user $uname? [y/N] " response
	if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
	then
		useradd $uname
        	cat /etc/passwd | grep -w $uname | awk -F':' '{print "Username: "$1", ""UserID: "$3", ""User Home Dir: "$6", ""User Shell: "$7}'
	else
		echo "Exiting...!"
		exit 1
	fi
fi
