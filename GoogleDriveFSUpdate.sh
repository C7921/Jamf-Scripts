#!/bin/bash
##############
# Connor Sanders 26/2/18
# Downloads and Silent installs the latest Version of Google Drive File Stream
##############

dmgName="GoogleDriveFileStream.dmg"
VolumeName="Install Google Drive File Stream"
targetDrive="/Volumes/Macintosh HD"
downloadURL="https://dl.google.com/drive-file-stream/GoogleDriveFileStream.dmg"

# Downloading File
echo "Downloading DMG File..."
	curl -s -L -o "/tmp/$dmgName" "$downloadURL"
### Below commands installs DMG in silent mode ### 
# Mounts DMG File
echo "Mounting DMG FIle..."
	hdiutil mount /tmp/$dmgName -nobrowse -quiet
# Installs pkg contained inside DMG
echo "Installing DMG..."
	sudo installer -pkg /Volumes/"${VolumeName}"/GoogleDriveFileStream.pkg -target "$targetDrive"
# Unmount DMG
echo "Unmounting DMG..."
	hdiutil unmount /Volumes/"${VolumeName}"
	sleep 5
# Deletes tmp file
echo "Deleting DMG File"
	rm /tmp/$dmgName

echo "Install Complete."
	exit 0