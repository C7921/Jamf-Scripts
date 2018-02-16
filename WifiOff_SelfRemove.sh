#!/bin/bash
# Jan 2018 Connor Sanders
# Script gets current Wi-Fi device and turns it off. 
# Script then deletes itself.

# Get Current Wifi Device
CURRENT_DEVICE=$(networksetup -listallhardwareports | awk '$3=="Wi-Fi" {getline; print $2}')

# Turn off WiFi
echo "Current Wi-Fi Device = '$CURRENT_DEVICE'"
echo "wifi off"
networksetup -setairportpower $CURRENT_DEVICE off
sleep 2

rm -- $0

