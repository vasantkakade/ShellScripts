#!/bin/bash
# This script captures all html page source of https://www.paltalk.com and saves it in paltalk.htm file.
# Then by using grep utility captures all the domain names from html page source file.
curl https://www.paltalk.com > paltalk.htm
echo "##Extracted sub-domain names of palktalk.com from the website/homepage link.##"
cat paltalk.htm | grep -Po "[a-zA-z0-9]+\.paltalk.com" | grep -v www | uniq | sort 
