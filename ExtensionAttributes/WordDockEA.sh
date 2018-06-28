#!/bin/sh
# Checks for Word on the Dock

wordDock=$(defaults read ~/Library/Preferences/com.apple.dock.plist persistent-apps | grep -aRi -C 1 "Microsoft Word" | awk '{print $5, $6}' | cut -c 2-15 | grep -i Microsoft)

if [ "$wordDock" != "" ]; then
  Docked=True
else
  Docked=False
fi
echo "<result>$Docked</result>"
