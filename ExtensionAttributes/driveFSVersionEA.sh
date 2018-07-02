#!/usr/bin/env bash
# Checks which version of Google Drive File Stream is installed. If at all. 
driveFSVersion=$(defaults read /Applications/Google\ Drive\ File\ Stream.app/Contents/Info.plist CFBundleShortVersionString )

if [ -e /Applications/Google\ Drive\ File\ Stream.app/Contents/Info.plist ]
then
  echo "<result>$driveFSVersion</result>"
else
  echo "<result>NOT INSTALLED</result>"
fi
