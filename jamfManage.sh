#!/bin/bash
#
# Connor Sanders 05/09/2017
#
# Script Checks to see if user is root. Then Turns WiFi off, after reminding user to connect Ethernet.
# Tests active network connection.
# Runs Jamf Commands
# Turns WiFi back on.
#####################
#
#
#
#
# Check if User is root
if [[ $EUID -ne 0 ]]; then
	echo "Try again as Root."
	exit

# Pop-up to Connect Ethernet
else
osascript -e 'tell application "Terminal" to display dialog "This script requries Ethernet. Please Connect Now." buttons {"OK"} with icon stop'
if [ $? == 0 ]; then
    echo "Testing Connection"


# Current WiFi
CURRENT_DEVICE=$(networksetup -listallhardwareports | awk '$3=="Wi-Fi" {getline; print $2}')


# Turn off WiFi
echo "Current Wi-Fi Device = '$CURRENT_DEVICE'"
echo "wifi off"
networksetup -setairportpower $CURRENT_DEVICE off
sleep 2

# Test Ethernet or Other Connection
if nc -zw1 google.com 443; then
  echo "we have connectivity"
sleep 2
	jamf removeMDMProfile; jamf mdm; jamf manage; jamf recon
	# Used to have timed sleeps between the commands. Used the above syntax instead. Seems more stable
sleep 2
echo "jamf commands complete"

else
echo "No Connection Detected"
echo "Turning WiFi back on"
networksetup -setairportpower $CURRENT_DEVICE on

fi

# Turn on WiFi
echo "Current Wi-Fi Device = '$CURRENT_DEVICE'"
echo "wifi on"
networksetup -setairportpower $CURRENT_DEVICE on



else
    exit 1
    echo "Incorrect Setup, please try again"

fi
fi

exit 0s
