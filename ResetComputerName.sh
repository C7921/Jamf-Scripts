#!/bin/bash
# Connor Sanders 14/2/18
# Resets Computer Name to variable of asset Tag Number
# Variable to be set in JSS Policy, ensure that variable is set. Option for hardcoding.
#
#
# HARDCODED VALUE FOR "NewMachineName" IS SET HERE
NewMachineName=""

# CHECK TO SEE IF A VALUE WAS PASSED IN PARAMETER 4 AND, IF SO, ASSIGN TO "NewMachineName"
if [ "$4" != "" ] && [ "$NewMachineName" == "" ]; then
	NewMachineName=$4
fi

if [ "$NewMachineName" == "" ]; then
	echo "Error:  The parameter 'NewMachineName' is blank.  Please specify a value."
	exit 1
# Setting New Computer Name
else
	echo $NewMachineName
		scutil --set HostName $NewMachineName
		scutil --set LocalHostName $NewMachineName
		scutil --set ComputerName $NewMachineName
	echo "Renaming Completed!"
# Run Recon    # Comment out/remove if not being used with Jamf Pro
	# sudo jamf recon
fi
	exit 0
