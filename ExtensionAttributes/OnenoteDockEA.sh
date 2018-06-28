#!/bin/sh
# Checks for Onenote in the Dock


onenoteDock=$(defaults read ~/Library/Preferences/com.apple.dock.plist persistent-apps | grep -aRi -C 1 "Microsoft Onenote" | awk '{print $5, $6}' | cut -c 2-18 | grep -i Microsoft)

if [ "$onenoteDock" != "" ]; then
  Docked=True
else
  Docked=False
fi

echo "<result>$Docked</result>"
