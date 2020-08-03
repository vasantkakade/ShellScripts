#!/bin/bash
# This script captures all html page source of https://www.checkpoint.com and saves it in checkpoint.htm file.
# Then by using grep utility captures all the domain names from html page source file and save it in a checkpointDomains.txt file.
curl https://www.checkpoint.com > checkpoint.htm
echo "##Extracted sub-domain names of checkpoint.com from the website/homepage link.##"
cat checkpoint.htm | grep -Po "[a-zA-z0-9]+\.checkpoint.com" | grep -v www | sort | uniq >> checkpointDomains.txt
