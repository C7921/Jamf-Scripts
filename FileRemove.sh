#!/bin/bash
# Simple script to delete files and folders entered as variables

# Hardcode Item Values here
fileLocation="/Users/csanders/Desktop/file4.txt"
fileLocation5="/Users/csanders/Desktop/file5.txt"
fileLocation6="/Users/csanders/Desktop/file6.txt"
fileLocation7="/Users/csanders/Desktop/file7.txt"
fileLocation8="/Users/csanders/Desktop/file8.txt"

# Checks to see if a value has been set in Parameter 4 and if so, assign to fileLocation
# Requires at least Parameter 4 to have value set.
if [ "$fileLocation" == "" ]; then
	echo "'fileLocation' is blank. Please set a value."
fi
#
if [ "$4" != "" ] && [ "$fileLocation" == "" ]; then
fileLocation=$4
fi

echo "Starting Removal."
echo $fileLocation && rm -rf $fileLocation
echo $fileLocation5 && rm -rf $fileLocation5
echo $fileLocation6 && rm -rf $fileLocation6
echo $fileLocation7 && rm -rf $fileLocation7
echo $fileLocation8 && rm -rf $fileLocation8

echo "Files removed."
