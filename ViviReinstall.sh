#!/bin/bash
# Connor Sanders June 2018 
# Added Reinstall function

# App name 
appName="Vivi.app"
appInstalled=$(ls /Applications/ | grep -i "${appName}")

# Vivi file location array
viviFiles=(/Applications/Vivi.app 
		~/Library/Containers/au.com.viviaustralia.mac 
		~/Library/Preferences/au.com.viviaustralia.mac.helper.plist 
		~/Library/Prefernces/au.com.viviaustralia.mac.plist 
		~/Library/Application\ Support/Vivi )


# Function Start - Reinstall
		url='https://api.vivi.io/mac-pkg'

function viviReinstall {
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
		}
# Function End -  Reinstall

# Script Body Start

	if [ "$appInstalled" == "$appName" ]; then
		echo "${appName} is installed."
		echo "Starting removing."

			for v in "${viviFiles[@]}"
			do 
				echo "$v is removed" && rm -rf $v
			done

		echo "Removal Completed"
			#Poses reinstall
			read -p "Reinstall? (Y Or N)" -n 1 -r
			echo   
		if [[ $REPLY =~ ^[Yy]$ ]]
		then
			#Starts Reinstall
			echo "Confirmed reinstall."
			viviReinstall
		else
			echo "Not Reinstalling."
		fi


	else
		echo "${appName} not installed."
			#Poses reinstall
			read -p "Reinstall? (Y Or N)" -n 1 -r
			echo   
		if [[ $REPLY =~ ^[Yy]$ ]]
		then
			#Starts Reinstall
			echo "Confirmed reinstall."
			viviReinstall
		else
			echo "Not Reinstalling."
	fi
fi
