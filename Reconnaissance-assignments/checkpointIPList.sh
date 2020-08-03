#!/bin/bash
# This script reads domain names line by line from checkpointDomains.txt file and using host command finds IP address(es) of that domain name.
# Also using grep utility the only IP address(es) of that domain name are captured and saved in a checkpointIPList.txt file. 
file="checkpointDomains.txt"
while IFS= read -r line
## Loop to Find IP address of each domain name from checkpointDomains.txt file.
do
  host "$line" 8.8.8.8
done < "$file" | grep "has address" | awk '{print $4}' >> checkpointIPList.txt
