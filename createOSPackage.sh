#!/usr/bin/env bash
# Connor Sanders Jan 21 2019
################################################################################
# PURPOSE: This script is designed to create an OS PKG installer.
# NOTES: Startosinstall binary appears to require a logged in user.
# Policy to be run by IT staff through Self Service. Will then output file to desktop.
# This could easily be modified to place the PKG in /Users/Shared.
####################### VARIABLES ##############################################
# Jamf Var
JAMF="/usr/local/jamf/bin/jamf"

# Echo
ECHO="/bin/echo"

# Default Location
destination_location="/Applications"

# Default Source location
sourceFile="/Applications/Install macOS Mojave.app"

# Installer Downoad trigger
download_installer_trigger="cache_mojave"

# Output Location
logged_in=$(ls -l /dev/console | awk '{print $3}')


################################################################################
### FUNCTIONS ###

# Download macOS.app Installer
function Installer_dl() {
  $ECHO "Downloading macOS Installer...."
  $JAMF policy -trigger $download_installer_trigger
  $ECHO "Installer downloaded."
}

# Create OSPackage
function createPackage() {

# nameVersion=$(defaults read /Applications/Install\ macOS/ Mojave.app/Contents/Info.plist CFBundleDisplayName | awk '{print $3}')
# nameVersion=$(/bin/echo $sourceFile | /usr/bin/sed -E 's/(.+)?Install(.+)\.app\/?/\2/' | /usr/bin/xargs | awk '{print $2}')
InstallerVersion=$(/usr/libexec/Plistbuddy -c 'Print :"System Image Info":version' "$sourceFile/Contents/SharedSupport/InstallInfo.plist")


# Final Output local. Shared Directory. 
# output_location="/Users/SharedShared/macOS-$InstallerVersion.pkg"
output_location="/Users/$logged_in/Desktop/macOS-$InstallerVersion.pkg"


$ECHO "Creating Packing to $output_location"
# pkgbuild --install-location $destination_location --component "$sourceFile" "/Users/Shared/macOS-${fileName}.pkg"
pkgbuild --install-location $destination_location --component "$sourceFile" "$output_location"
}

### Main ###
if [ -e "$sourceFile" ]; then
  $ECHO "Installer Found. Checking version..."
  $ECHO "Installer Version is $InstallerVersion"
  createPackage
else
  $ECHO "Installer Not found..."
  sleep 2
  Installer_dl
  sleep 2
  createPackage
fi
