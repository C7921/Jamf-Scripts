#!/bin/sh
# Finds Powerpoint on the Dock

powerdock=$(defaults read ~/Library/Preferences/com.apple.dock.plist persistent-apps | grep -aRi -C 1 "Microsoft Powerpoint" | awk '{print $5, $6}' | cut -c 2-21 | grep -i Microsoft)

if [ "$powerdock" != "" ]; then
  Docked=True
else
  Docked=False
fi

echo "<result>$Docked</result>"
