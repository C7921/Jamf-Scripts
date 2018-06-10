#!/bin/bash
# Connor Sanders June 2018 

# App name 
appName="Vivi.app"
appInstalled=$(ls /Applications/ | grep -i "${appName}")

# Vivi file location array
viviFiles=(/Applications/Vivi.app 
		~/Library/Containers/au.com.viviaustralia.mac 
		~/Library/Preferences/au.com.viviaustralia.mac.helper.plist 
		~/Library/Prefernces/au.com.viviaustralia.mac.plist 
		~/Library/Application\ Support/Vivi )

	if [ "$appInstalled" == "$appName" ]; then
		echo "${appName} is installed"
		echo "Starting removing"

			for u in "${viviFiles[@]}"
			do 
				echo "$u is removed" && rm -rf $u
			done
		echo "Removal Completed"


	else
		echo "${appName} not installed"
	fi

