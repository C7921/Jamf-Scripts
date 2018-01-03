#!/bin/bash
# Jan 2018 Connor Sanders
# This script is nice and simple, it gets the current Wi-Fi Device, turns if off and then removes itself.




# Get Current Wifi Device
CURRENT_DEVICE=$(networksetup -listallhardwareports | awk '$3=="Wi-Fi" {getline; print $2}')


# Turn off WiFi
echo "Current Wi-Fi Device = '$CURRENT_DEVICE'"
echo "wifi off"
networksetup -setairportpower $CURRENT_DEVICE off
sleep 2


rm -- $0

