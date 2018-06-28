#!/bin/sh
# Finds Github Desktop on Dock

gitDock=$( defaults read ~/Library/Preferences/com.apple.dock.plist persistent-apps | grep -aRi -C 1 "Github Desktop" | awk '{print $5, $6}' | cut -c 2-15 | grep -i Github )

if [ "$gitDock" != "" ]; then
	Docked=True
else
  Docked=False
fi
echo "<result>$Docked</result>"
