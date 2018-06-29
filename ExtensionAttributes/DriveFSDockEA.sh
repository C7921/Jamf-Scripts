#!/bin/sh
# Checks is DriveFS is on the Dock

driveDock=$(defaults read ~/Library/Preferences/com.apple.dock.plist persistent-apps | grep -aRi -C 1 "Google Drive File Stream" | awk '{print $5, $6}' | cut -c 2-14 | grep -i "Google")
if [ "$driveDock" != "" ]; then
  Docked=True
else
  Docked=False
fi
echo "<result>$Docked</result>"
