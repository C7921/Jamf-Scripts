#!/bin/sh
# Checks if MS Office Outlook is installed on the dock
outlookDock=$(defaults read ~/Library/Preferences/com.apple.dock.plist persistent-apps | grep -aRi -C 1 "Microsoft Outlook" | awk '{print $5, $6}' | cut -c 2-18 | grep -i Microsoft)

if [ "$outlookDock" != "" ]; then
  Docked=True
else
  Docked=False
fi
echo "<result>$Docked</result>"
