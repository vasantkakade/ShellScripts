#!/bin/bash
#
# check for non-existent file, exit status will be 2
#
ls SoMeFiLe.ext  
echo "status: $?"

# create file, and do again, exit status will be 0
touch SoMeFiLe.ext
ls SoMeFiLe.ext  
echo "status: $?"

# remove the file to clean up
rm SoMeFiLe.ext
