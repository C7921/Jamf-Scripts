#!/usr/bin/env bash
# # Connor Sanders
# # Downloads the  latest Version of Office.
# # Requires office apps to close for the install
# # Best used with Office 365 Logins
# Amazing spinner while loop from https://goo.gl/GatKpK
#
source ~/Library/init/utils.sh
#
url="https://go.microsoft.com/fwlink/?linkid=525133"
# pkgName="MSOffice_Installer.pkg"
#
e_arrow "Enter save location with /:" && read -p "" saveLocation
#
# # echo "${url}"
# # echo "${pkgName}"
# # echo "${saveLocation}"
#
# # Downloads to specified Directory
# 	echo "Downloading Office..."
# curl -s -L -o "${saveLocation}${pkgName}" "$url"
# 	echo "Download Complete."
# exit 0

# First method above!
# url="https://go.microsoft.com/fwlink/?linkid=525133"
pkgName="MSOffice_Installer.pkg"
echo "Starting Download..."
curl -s -L -o "${saveLocation}${pkgName}" "https://go.microsoft.com/fwlink/?linkid=525133" &
pid=$! # Process Id of the previous running command

spin='-\|/'

i=0
while kill -0 $pid 2>/dev/null
do
  i=$(( (i+1) %4 ))
  printf "\r${spin:$i:1}"
  sleep .1
done

echo "Download Complete."
