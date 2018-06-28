#!/bin/sh
# Checks if Vivi is installed on the dock.

dockItem=Vivi
GitTest=$( defaults read ~/Library/Preferences/com.apple.dock.plist persistent-apps | grep -i vivi | awk '{print $3}' | cut -c 1-4 | grep -i vivi)

if [ "$GitTest" == "$dockItem" ]; then
	viviInDock=True
else
  viviInDock=False
fi
# echo $viviInDock
# echo "<result>$GitTest</result>"
echo "<result>$viviInDock</result>"
