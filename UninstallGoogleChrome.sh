#!/bin/bash
# Checks if Google Chrome is installed and then removes it.
# Best to run as Root for access to log and library files.

# Log File
touch /Library/Logs/ChromeUninstall.log
logfile="/Library/Logs/ChromeUninstall.log"
app="Google Chrome"

if open -Ra "$app" ; then
	echo "---" >> ${logfile}
  	echo "`date`: 'Google Chrome' is installed, starting removal..."

  # Quit Google Chrome
		echo "`date`: Quitting Chrome" >> ${logfile}
		echo "Quitting Chrome"
		osascript -e 'quit app "Google Chrome"'
	sleep 3

# Remove from Applications Folder
		echo "`date`: Removing from Applications Folder" >> ${logfile}
		echo "Removing from Applicaitons Folder"
	rm -rf /Applications/Google\ Chrome.app

# Removing Library Files
		echo "`date`: Removing Library Files" >> ${logfile}
		echo "Removing Library Files"
	rm -rf ~/Library/Application\ Support/Google/Chrome

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
