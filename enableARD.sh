#!/bin/bash

# Connor Sanders Jan 2018


# Option to enable to disable ARD Remote Mangement. 
# Can be used with JSS policy with variables, or values and variables can be hardcoded.
# There are many options that be enabled and set the ARD Kickstart application, however only full access will be given or removed with this script.
# Requires Mac OS X 10.3 or later.

# $4 variable will be used to have the option to set the ARD access at particular user level.
##########################################

# Hardcode User value here
ARDUser=""


# Check that value has been entered inot variable $4

if [ "$4" != "" ] && [ "$ARDUser" == "" ]; then
	ARDUser=$4
fi 

# Start of script

if [ "$ARDUser" != "" ];then
	echo "Starting ARD Config"
	sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -allowAccessFor -specifiedUsers
	echo "Settings Priviledges"
	sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/contents/resources/kickstart -configure -users $ARDUser -access -on -privs -all
	echo "ARD Enabled for User $ARDUser"
	exit 0 # Completed Successfully 

else
	echo "Please enter a username into the $4 Variable"
	exit 1 # No Variable Specified

fi