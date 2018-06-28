#!/bin/sh
#  Looks for Self Service on the Dock

selfDock=$(defaults read ~/Library/Preferences/com.apple.dock.plist persistent-apps | grep -aRi -C 1 "Self Service" | awk '{print $5, $6}' | cut -c 2-13 | grep -i Self)

if [ "$selfDock" != "" ]; then
  Docked=True
else
  Docked=False
fi

echo "<result>$Docked</result>"
