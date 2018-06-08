#!/bin/bash

# Change app name here
appName="Vivi.app"
appInstalled=$(ls /Applications/ | grep -i "${appName}")

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

# viviFiles=(/Applications/Vivi.app 
# 		~/Library/Containers/au.com.viviaustralia.mac 
# 		~/Library/Preferences/au.com.viviaustralia.mac.helper.plist 
# 		~/Library/Prefernces/au.com.viviaustralia.mac.plist 
# 		~/Library/Application\ Support/Vivi )


# echo ${viviFiles[@]}

# for u in "${viviFiles[@]}"
# do
# 	echo "$u is removed" && rm -rf $u
# done
