#!/bin/bash
#
#
#
# Set Hardcoded Values Here (Replace)
NewName="$4"
VolumeName=$(diskutil info / | grep "Volume Name" | cut -c 30-)
node=$(diskutil info / | grep "Node" | cut -c 30-)


# Check is value was added in Parameter 4. 
if [ "$4" == "" ]; then
	echo "Please ensure New HDD Name has been specified"
	exit 2
	

elif [[ "$VolumeName" == "$4" ]]; then
	echo "Name already adjusted"
	exit 1

else 
	VolumeName=$(diskutil info / | grep "Volume Name" | cut -c 30-)
    	echo $VolumeName

	node=$(diskutil info / | grep "Node" | cut -c 30-)
		echo $node 
 		sudo diskutil rename $node "$NewName"
 	exit 0

fi


