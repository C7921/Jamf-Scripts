#!/bin/sh
#
#
# Connor Sanders October 2017 
#########################################
#
# Script allows the "Macintosh HD" Partitio to be renamed to another value, if needed.
# This can be usful for data tranfers that use similar or the same paths for the  source and 
# destination.
# 
# Values can be hardcoded, however this is designed to be set by parameter 4 in the JSS Policy.
# 


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

exit 0