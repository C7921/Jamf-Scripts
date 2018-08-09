#!/bin/bash
################
# Connor Sanders 9/8/18
# Updates Google Chrome to the latest version.
# Only removes and replaces data from the /Applications Folder. Logged in User and bookmark information not impacted.
# Mostly taken from the UninstallGoolgeChrome.sh and UpdateGoogleChrome.sh
################
app="Google Chrome"
dmgName="googlechrome.dmg"
volumeName="Google Chrome"
downloadURL="https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg"

appName="Google Chrome.app"
appInstalled=$(ls /Applications/ | grep -i "${appName}")

# Chrome file location array
chromeFiles=("/Applications/Google\ Chrome.app" "~/Library/Application\ Support/Google/Chrome")

# Function Start - Reinstall
function reinstallChrome {

	# Remove from Applications Folder
	echo "Removing from Applicaitons Folder"
		rm -rf /Applications/Google\ Chrome.app
	# Downloading new verion of Google Chrome
	echo "Downloading File..."
		curl -s -o "/tmp/${dmgName}" "$downloadURL"
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
}

# Script Body Start
if [ "$appInstalled" == "$appName" ]; then
		echo "${appName} is installed"
		echo "Starting removing"
		echo "Quitting Chrome"
			osascript -e 'quit app "Google Chrome"'
			sleep 3
		reinstallChrome

		exit 0

else
	echo "Google Chrome is not installed"
	echo "Starting Install..."
	reinstallChrome

	exit 1

fi
