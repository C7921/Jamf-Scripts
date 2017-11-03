#!/bin/bash
# Novemeber 2017
# Mounts SMB share using specified Jamf variables. Or Hardcoded options
# Example -- SMB Share: smb://server.company.com/share
#############



sharefolder=

# Get current logged in user
currentuser=$(/usr/bin/who | awk '/console/{ print $1 }')
echo $currentuser

# Checks if share is already mounted

PreMounted=`mount | grep -c "$sharefolder"`

