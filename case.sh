#!/bin/bash

read -p "Enter a Word: " word
case $word in
[aeiouAEIOU]*)
		echo "Word starts with Vowel."
		;;
[0-9]*)
		echo "Word starts with digit."
		;;
*[0-9])
		echo "Word ends with digit."
		;;
???)
		echo "You entered a 3 letter word."
		;;
*)
		echo "Different."
		;;
esac
