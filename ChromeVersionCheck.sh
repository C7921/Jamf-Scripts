#!/usr/bin/env bash
chromePath="/Applications/Google Chrome.app"
chromeVersion=$( defaults read /Applications/Google\ Chrome.app/Contents/Info.plist KSVersion)
installerVersion=67.0.3396.99

if [ -x "$chromePath" ]; then
  echo "Chrome installed"
  echo "Installed Chrome Version is $chromeVersion"
    if [ "$chromeVersion" == "$installerVersion" ]; then
      echo "Installed Chrome up to date."
      UpdateNeeded=False
    else
      echo "Chrome requires update."
    UpdateNeeded=True
    fi
else
  echo "Chrome not installed"
  UpdateNeeded=True
fi
