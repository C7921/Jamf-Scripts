#!/bin/bash
# Checks if Google Chrome is installed and then removes it.
# Best to run as Root for access to log and library files.

# Log File
touch /Library/Logs/ChromeUninstall.log
logfile="/Library/Logs/ChromeUninstall.log"
app="Google Chrome"
appName="Google Chrome.app"
appInstalled=$(ls /Applications/ | grep -i "${appName}")

# Chrome file location array
chromeFiles=(/Applications/Google\ Chrome.app ~/Library/Application\ Support/Google/Chrome)

if [ "$appInstalled" == "$appName" ]; then
	echo "---" >> ${logfile}
		echo "`date`: ${appName} is installed"

  # Quit Google Chrome
		echo "`date`: Quitting Chrome" >> ${logfile}
		echo "Quitting Chrome"
		osascript -e 'quit app "Google Chrome"'
	sleep 3

	# Removing Files
		for c in "${chromeFiles[@]}"
		do 
			echo "$c is removed" && rm -rf $c
		done

# Successfully Uninstalled Google Chrome
		echo "`date`: Successfully Uninstalled Google Chrome" >> ${logfile}
		echo "Successfully Uninstalled Google Chrome"
	exit 0

# Google Chrome not installed.
	else
		echo "---" >> ${logfile}
 		echo "`date`: 'Google Chrome' is not installed, exiting." >> ${logfile}
 	exit 1
fi 