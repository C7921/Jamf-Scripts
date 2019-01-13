#!/bin/bash
# Connor Sanders 9/8/2018
# Downloads and installs the latest version of VLC for macOS.
# Curent Version 3.06

name="VLC"
url="https://get.videolan.org/vlc/3.0.6/macosx/vlc-3.0.6.dmg"
dmgName="vlc-3.0.6.dmg"
volumeName="VLC media player"
# /Volumes/VLC\ media\ player

# Downloads and installs from mounted dmg volume.
	echo "Downloading ${name}"
	curl -s -L -o '/tmp/vlc-3.0.6.dmg' "$url"

	echo "Mounting DMG..."
		hdiutil mount /tmp/vlc-3.0.6.dmg -nobrowse -quiet
	echo "Installing new version"
		sudo cp -r /Volumes/VLC\ media\ player/VLC.app /Applications/
		sleep 10
	echo "Install Complete. Unmounting DMG..."
		hdiutil unmount $(/bin/df | /usr/bin/grep "${volname}" | awk '{print $1}') -quiet
		sleep 5
	echo "Deleting DMG File..."
		rm /tmp/${dmgName}
	echo "Upgrade Complete"
exit 0 
