# #!/bin/bash
# # Connor Sanders June 2018
# # Reinstall GoogleDriveFS

# # App name
# appName="Google Drive File Stream.app"
# appInstalled=$(ls /Applications/ | grep -i "${appName}")

# Locations Array
driveFiles=("/Applications/Google\ Drive\ File\ Stream.app" "~/Library/Application\ Support/Google/DriveFS")

# for ((i = 0; i < ${#driveFiles[@]}; i++))
# do
#     echo "${driveFiles[$i]}"
#     rm -rf "${drifveFiles[$i]}"
# done




# # Install Utils
# dmgName="GoogleDriveFileStream.dmg"
# VolumeName="Install Google Drive File Stream"
# targetDrive="/Volumes/Macintosh HD"
# downloadURL="https://dl.google.com/drive-file-stream/GoogleDriveFileStream.dmg"

# # Function Start - Reinstall
# function reinstallDriveFS {
# 		echo "Downloading DMG File..."
# 			curl -s -L -o "/tmp/$dmgName" "$downloadURL"
# 		echo "Mounting DMG FIle..."
# 			hdiutil mount /tmp/$dmgName -nobrowse -quiet
# 		echo "Installing DMG..."
# 			sudo installer -pkg /Volumes/"${VolumeName}"/GoogleDriveFileStream.pkg -target "$targetDrive"
# 		echo "Unmounting DMG..."
# 			hdiutil unmount /Volumes/"${VolumeName}"
# 			sleep 5
# 		echo "Deleting DMG File"
# 			rm /tmp/$dmgName
# 		echo "Install Complete."
# }
# # Function End - Reinstall

# # Checks if installed
# if [ "$appInstalled" == "$appName" ]; then
# 		echo "${appName} is installed"
# 		echo "Starting removing"

		for d in "${driveFiles[@]}"
			do 
				echo "$d is removed" && rm -rf $d
			done
# 		echo "Removal Completed"
# 		#Poses reinstall
# 		read -p "Reinstall? (Y Or N)" -n 1 -r
# 		echo   
# 		if [[ $REPLY =~ ^[Yy]$ ]]
# 		then
# 			echo "Confirmed Reinstall"
# 			reinstallDriveFS
# 		else
# 			echo "Reinstall Declined"
# 		fi

# 	else
# 		echo "${appName} not installed"
# 		#Poses reinstall
# 		read -p "Reinstall? (Y Or N)" -n 1 -r
# 		echo   
# 		if [[ $REPLY =~ ^[Yy]$ ]]
# 		then
# 			echo "Confirmed Reinstall"
# 			reinstallDriveFS
# 		else
# 			echo "Reinstall Declined"
# 	fi
# fi
