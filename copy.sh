#!/bin/bash
#
#
#
# Trying to automate a copy of user data between macs.
# 
#
#Checks if Root. Needed for permissions
if [[ $EUID -ne 0 ]]; then
	echo "Try again as Root."
	exit
else

#Source & destination

echo "Enter Source Location"
	read varsource

echo "Enter Destination Location"
	read vardestination
#Check if correct.
	read -p "Confirm Correct?(Y Or N) $varshortname $varsource $vardestination" -n 1 -r
		echo   
		if [[ $REPLY =~ ^[Yy]$ ]]
		then
		#Starts copy
	echo "Confirmed... Continuing...."
	# rsync -av --progess /source/ /destination
	rsync -av --progress $varsource $vardestination
   echo "Copy Complete"

else 
	exit 1
	echo "Unable to Complete. Please try again."
   
fi

fi



