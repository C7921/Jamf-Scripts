#!/usr/bin/env bash
# Connor Sanders 21 Jan 2019
#
# Enter the names of the adobe programs you wish to uninstall. Either hardcoded or using Param Values.
# Script will call uninstall policies. Using the naming convention "uninstall_$AdobeName".
# If using creative cloud, easiest method is to use the Unistallers linked to the uninstall policy.
# RESTRICTION: Only able to uninstall 4 programs at a time.
# Feel free to add more but due to size of packages. It's not recommended.
################################################################
# Checks for root, rejects if not.
if [ "$(id -u)" != "0" ]; then echo "Please run $0 as root." && exit 1; fi
################################################################

### Variable Checking ###

# HARDCODED VALUE FOR "Adobe1" IS SET HERE
Adobe1=""
# Checking if a value was passed to Param 4 and give to "Adobe1"
if [ "$4" != "" ] && [ "$Adobe1" == "" ]; then
	Adobe1=$4
fi
if [ "$Adobe1" == "" ]; then
	echo "Error:  The parameter 'Adobe1' is blank.  Please specify a value."
fi
################################################################
# HARDCODED VALUE FOR "Adobe2" IS SET HERE
Adobe2=""
# Checking if a value was passed to Param 4 and give to "Adobe2"
if [ "$4" != "" ] && [ "$Adobe2" == "" ]; then
	Adobe2=$4
fi
if [ "$Adobe2" == "" ]; then
	echo "Error:  The parameter 'Adobe2' is blank.  Please specify a value."
fi
################################################################
# HARDCODED VALUE FOR "Adobe3" IS SET HERE
Adobe3=""
# Checking if a value was passed to Param 4 and give to "Adobe3"
if [ "$4" != "" ] && [ "$Adobe3" == "" ]; then
	Adobe3=$4
fi
if [ "$Adobe3" == "" ]; then
	echo "Error:  The parameter 'Adobe3 is blank.  Please specify a value."
fi
################################################################
# HARDCODED VALUE FOR "Adobe4" IS SET HERE
Adobe4=""
# Checking if a value was passed to Param 4 and give to "Adobe4"
if [ "$4" != "" ] && [ "$Adobe4" == "" ]; then
	Adobe4=$4
fi
if [ "$Adobe4" == "" ]; then
	echo "Error:  The parameter 'Adobe4 is blank.  Please specify a value."
fi
################################################################
# Settings other variables.
JAMF=/usr/local/jamf/bin/jamf
ECHO=/bin/echo

### Main ####

$ECHO "Starting Removal of $Adobe1"
$JAMF policy -trigger uninstall_$Adobe1

$ECHO "Starting Removal of $Adobe2"
$JAMF policy -trigger uninstall_$Adobe2

$ECHO "Starting Removal of $Adobe3"
$JAMF policy -trigger uninstall_$Adobe3

$ECHO "Starting Removal of $Adobe4"
$JAMF policy -trigger uninstall_$Adobe4

$ECHO "Selected Programs have now been removed."

$ECHO "The remainging Adobe apps and directories are: "
for dir in /Applications/Adobe*/
do
    dir=${dir%*/}
    echo ${dir##*/}
done

$ECHO "Script completed."
exit 0
