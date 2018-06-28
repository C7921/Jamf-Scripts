#!/bin/sh
# Finds Excel on the Docked

excelDock=$(defaults read ~/Library/Preferences/com.apple.dock.plist persistent-apps | grep -aRi -C 1 "Microsoft Excel" | awk '{print $5, $6}' | cut -c 2-16 | grep -i Microsoft)

if [ "$excelDock" != "" ]; then
  Docked=True
else
  Docked=False
fi

echo "<result>$Docked</result>"
