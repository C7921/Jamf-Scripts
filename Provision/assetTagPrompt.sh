#!/usr/bin/env bash
# Prompt for Asset Tag

tag=$(osascript -e 'Tell application "System Events" to display dialog "Please enter the Asset Tag of the Computer." default answer ""' -e 'text returned of result')
echo $tag
sudo jamf recon -assetTag $tag
