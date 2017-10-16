#!/bin/sh

NewName="$4"

if [ "$4" == "" ]; then
	echo "Attention: Please ensure that the New HDD Name has been specified."
	exit 1
fi

if $VolumeName == "$4"
then [echo "Already Correct Name"] 
    exit 2
else
VolumeName=$(diskutil info / | grep "Volume Name" | cut -c 30-)
    echo $VolumeName

node=$(diskutil info / | grep "Node" | cut -c 30-)
	echo $node 
 sudo diskutil rename $node "$NewName"
fi
