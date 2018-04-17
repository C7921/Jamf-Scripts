#!/bin/bash
#
# Connor Sanders October 2017
#
# Data tranfer between sources. Set Locations and then confirm. 
# Originally made for data tranfer between two macs via thunderbolt connection. 
# 
#
#Checks if Root. Needed for permissions, depending on the files
if [[ $EUID -ne 0 ]]; then
	echo "Try again as Root."
	exit 1
else

#Source & destination
read -p 'Source Location:' varsource
read -p 'Destionation Location:' vardestination

#Check if correct.
	read -p "Confirm Correct?(Y Or N) $varsource $vardestination " -n 1 -r
		echo   
		if [[ $REPLY =~ ^[Yy]$ ]]
		then
		#Starts copy
	echo "Confirmed... Continuing...."
	# rsync -av --progess /source/ /destination
	rsync -av --progress $varsource $vardestination
	echo "Copy Complete"

else 
	echo "Exiting. User Cancelled?!"
	exit 2
	
   
	fi

fi



