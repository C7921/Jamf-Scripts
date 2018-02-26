#!/bin/bash
################
# Connor Sanders 26/2/18
# Updates Google Chrome to the latest version.
# Only removes and replaces data from the /Applications Folder. Logged in User and bookmark information shouldn't be impacted.
# Mostly taken from the UninstallGoolgeChrome.sh from my same repo. 
################
app="Google Chrome"
dmgName="googlechrome.dmg"
volumeName="Google Chrome"
downloadURL="https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg"

appName="Google Chrome.app"
appInstalled=$(ls /Applications/ | grep -i "${appName}")

if [ "$appInstalled" == "$appName" ]; then
	echo "'Google Chrome' is installed, starting update..."
	  # Quit Google Chrome
	echo "Quitting Chrome"
		osascript -e 'quit app "Google Chrome"'
		sleep 3
	# Remove from Applications Folder
	echo "Removing from Applicaitons Folder"
		rm -rf /Applications/Google\ Chrome.app
	# Downloading new verion of Google Chrome
	echo "Downloading File..."
		curl -s -o "/tmp/${dmg}" "$downloadURL"
	echo "Mounting DMG..."
		hdiutil mount /tmp/${dmgName} -nobrowse -quiet
	echo "Installing new version"
		cp -r /Volumes/"${volumeName}"/"${appName}" /Applications/Google\ Chrome.app
		sleep 10
	echo "Install Complete. Unmounting DMG..."
		hdiutil unmount $(/bin/df | /usr/bin/grep "${volname}" | awk '{print $1}') -quiet
		sleep 5
	echo "Deleting DMG File..."
		rm /tmp/$dmgName
	echo "Upgrade Complete"
		exit 0 

else
	echo "Google Chrome is no installed"
	echo "Starting Install..."
	# Downloading new verion of Google Chrome
	echo "Downloading File..."
		curl -s -o "/tmp/${dmg}" "$downloadURL"
	echo "Mounting DMG..."
		hdiutil mount /tmp/${dmgName} -nobrowse -quiet
	echo "Installing new version"
		cp -r /Volumes/"${volumeName}"/"${appName}" /Applications/Google\ Chrome.app
		sleep 10
	echo "Install Complete. Unmounting DMG..."
		hdiutil unmount $(/bin/df | /usr/bin/grep "${volname}" | awk '{print $1}') -quiet
		sleep 5
	echo "Deleting DMG File..."
		rm /tmp/$dmgName
	echo "Install Complete"
	exit 1

fi

