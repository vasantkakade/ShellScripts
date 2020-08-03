#!/bin/bash
mkdir main
for i in {1..100}
do
	mkdir main/test$i
	echo "This is file$i inside directory main/test$i" >> main/test$i/file$i
done
