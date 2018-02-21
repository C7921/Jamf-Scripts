#!/bin/bash
# Jan 2018 Connor Sanders
# Script gets current Wi-Fi device and turns it off.
# Script then deletes itself.
# Comment "rm == $0" is being used with JSS or not required to be removed.

# Get Current Wifi Device
CURRENT_DEVICE=$(networksetup -listallhardwareports | awk '$3=="Wi-Fi" {getline; print $2}')

# Turn off WiFi
echo "Current Wi-Fi Device = '$CURRENT_DEVICE'"
echo "Wi-Fi is now off"
networksetup -setairportpower "$CURRENT_DEVICE" off
sleep 2
exit 0
# rm -- $0
