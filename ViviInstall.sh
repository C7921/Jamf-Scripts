#!/bin/bash
# Connor Sanders 14/2/18
# Download and Installs the Latest Version of Vivi from Vivi Site
# Steps -  Silent download and install latest Vivi.pkg. Removes Tmp files.

url='https://api.vivi.io/mac-pkg'

# Downloads to TMP Directory
	echo "Downloading Vivi pkg"
curl -s -L -o '/tmp/Vivi.pkg' "$url" 
	echo "Download complete. Installing"
# Installs from TMP Directory
sudo installer -pkg /tmp/Vivi.pkg -target /
	echo "Install complete. Removing Tmp File"
sleep 1
rm /tmp/Vivi.pkg
	echo "Update Complete."
	# rm $0
exit 0
