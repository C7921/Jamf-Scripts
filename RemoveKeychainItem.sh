#!/bin/bash
# Connor Sanders April 2018
# Looks for and if found removes requested keychain item

##########
# Hardcode Value here
KeychainItem=""
# Grab info for Keychain Item requested
# KeychainItemName=$(security find-internet-password -l $KeychainItem | grep "00000007 <blob>" | cut -c 23-)

# Checks to see if a value has been set in Parameter 4 and if so, assign to KeychainItem
if [ "$KeychainItem" == "" ]; then
	echo "The parameter 'KeychainItem' is blank. Please set a value."
fi
#
if [ "$4" != "" ] && [ "$KeychainItem" == "" ]; then 
	KeychainItem=$4
fi

# Checks for security item and if found removes it. 
if [[ $(security find-internet-password -l $KeychainItem | grep "00000007 <blob>" | cut -c 23- ) != "" ]]; then
	echo "Found Security Item. Starting removal"
	security delete-internet-password -l $KeychainItem
	echo "Item has been removed"
	exit 0

else
	echo "Did not find security item"
	exit 1

fi