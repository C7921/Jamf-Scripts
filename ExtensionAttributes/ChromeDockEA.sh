#!/bin/sh
# Finds Google Chrome in the Dock

chromeDock=$(defaults read ~/Library/Preferences/com.apple.dock.plist persistent-apps | grep -aRi -C 1 "Google Chrome" | awk '{print $5, $6}' | cut -c 2-14 | grep -i Google)

if [ "$chromeDock" != "" ]; then
  Docked=True
else
  Docked=False
fi
echo "<result>$Docked</result>"
