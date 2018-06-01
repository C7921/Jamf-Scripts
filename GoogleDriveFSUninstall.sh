#!/bin/bash
# Connor Sanders May 2018
# Completley Uninstalls Google Drive File Stream
# Suggested to run as root, to avoid permission issues.

appName="Google Drive File Stream.app"
appInstalled=$(ls /Applications/ | grep -i "${appName}")
shortName=DriveFS

# Log File 
touch /Library/Logs/${shortName}.log
logfile="/Library/Logs/${shortName}.log"


# Checking for install 
if [ "$appInstalled" == "$appName" ]; then
	echo "'${appName}' is installed. Starting process." 
	# >> ${logfile}

# # Quit DriveFS
		echo "`date`: Quitting ${shortName}" >> ${logfile}
		echo "Quitting ${shortName}"
		osascript -e 'quit app "Google Drive File Stream"'
	sleep 3
# # Remove from Applications Folder
		echo "`date`: Removing from Applications Folder" >> ${logfile}
		echo "Removing from Applicaitons Folder"
	rm -rf /Applications/Google\ Drive\ File\ Stream.app

# Removing Library Files
		echo "`date`: Removing Library Files" >> ${logfile}
		echo "Removing Library Files"
	rm -rf ~/Library/Application\ Support/Google/DriveFS

# Successfully Uninstalled Google Drive File Stream
		echo "`date`: Successfully Uninstalled ${shortName}" >> ${logfile}
		echo "Successfully Uninstalled ${shortName}"

# Google DriveFS not installed.
else
		echo "'${appName}' is not installed" >> ${logfile}

fi
