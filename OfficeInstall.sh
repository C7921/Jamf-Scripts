#!/bin/bash
# Connor Sanders
# Downloads and Installs the latest Version of Office. 
# Requires office apps to close for the install

url="https://go.microsoft.com/fwlink/?linkid=525133"
pkgName="MSOffice_Installer.pkg"
tmpInstallLocation="/tmp/$pkgName"

# Downloads to TMP Directory
	echo "Downloading Office..."
curl -s -L -o "/tmp/MSOffice_Installer.pkg" "$url"
	echo "Download complete. Starting Install"
#Installs from TMP Directory
sudo installer -pkg /tmp/MSOffice_Installer.pkg -target /
	echo "Install complete. Removing TMP file"
sleep 1
rm "$tmpInstallLocation"
	echo "Install Complete."
exit 0