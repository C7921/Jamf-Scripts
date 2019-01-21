#!/usr/bin/env bash

####################################################################################################
# PURPOSE
# - Provisioning based on policy to replace imaging.
# HISTORY
#   Version: 1.0.1 - Creation.
#   - Connor Sanders 17 August 2018
#      - Build and structure
#
####################################################################################################

JAMF="/usr/local/jamf/bin/jamf"
ECHO="/bin/echo"

# Checks for root, rejects if not.
if [ "$(id -u)" != "0" ]; then echo "Please run $0 as root." && exit 1; fi
####################################################################################################
# Starting Announcment and trapout
$ECHO "Starting Staff Configuration..."
$ECHO "Press ctrl+C to cancel..."
$ECHO "3..."
sleep 1
$ECHO "2..."
sleep 1
$ECHO "1..."
sleep 1
$ECHO "GO!"
####################################################################################################
# Creates Log File
log=~/Desktop/ProvisionLog.txt
/usr/bin/touch $log

dateStamp=$( date "+%a %b %d %H:%M:%S")
$ECHO "$dateStamp" >> $log
$ECHO "Started Staff Provision..." >> $log
####################################################################################################

# Installating apps.....

### Main Apps ###
# Prompt for Computer Name
$JAMF policy -trigger provision_nameprompt; sleep 5
  $ECHO "Set name to $HOSTNAME" >> $log

# Prompt for Asset Tag // Using script instead of Call. Test to reduce recons.
# $JAMF policy -trigger provision_tagprompt
tag=$(osascript -e 'Tell application "System Events" to display dialog "Please enter the Asset Tag of the computer." default answer ""' -e 'text returned of result')
echo "Set tag to: " $tag >> $log
$JAMF recon -assetTag $tag

# Installs Google Chrome
$JAMF policy -trigger provision_googlechrome
  # Option for Google Chrome version read out.
  # chrome_version=$(defaults read /Applications/Google\ Chrome.app/Contents/Info.plist CFBundleShortVersionString)
  chrome_version=$(mdls -name kMDItemVersion /Applications/Google\ Chrome.app | cut -c 19- | rev | cut -c 2- | rev)
    if [[ $chrome_version == *"could not find"* ]]; then
        # Not Installed
        $ECHO "Google Chrome Install Failed." >> $log
      else
        # Installed
        $ECHO "Google Chrome $chrome_version installed successfully." >> $log
      fi

# Installs Vivi
$JAMF policy -trigger provision_vivi
  vivi_version=$(defaults read /Applications/Vivi.app/Contents/Info.plist CFBundleShortVersionString)
    if [[ $vivi_version == "" ]]; then
      # Not Installed
      $ECHO "Vivi install failed." >> $log
    else
      $ECHO "Vivi $vivi_version installed successfully.">> $log
    fi

# Install MS Office
$JAMF policy -trigger provision_msoffice
  excel_version=$(defaults read /Applications/Microsoft\ Excel.app/Contents/Info.plist CFBundleShortVersionString)
    if [[ $excel_version == "" ]]; then
      # Not installed
      $ECHO "MS Office install Failed." >> $log
    else
      # Installed
      $ECHO "MS Office $excel_version installed successfully." >> $log
    fi

# Installs DriveFS
$JAMF policy -trigger provision_drivefs
  drivefs_version=$(defaults read /Applications/Google\ Drive\ File\ Stream.app/Contents/Info.plist CFBundleShortVersionString)
    if [[ $drivefs_version == "" ]]; then
      # Not Installed
      $ECHO "DriveFS install failed." >> $log
    else
      # Installed
      $ECHO "DriveFS $drivefs_version installed successfully." >> $log
    fi

# Installs Acrobat Pro
$JAMF policy -trigger provision_acrobatpro
  acrobat_version=$(defaults read /Applications/Adobe\ Acrobat\ DC/Adobe\ Acrobat.app/Contents/Info.plist CFBundleShortVersionString)
    if [[ $acrobat_version == "" ]]; then
      # Not Installed
      $ECHO "Acrobat install failed." >> $log
    else
      # Installed
      $ECHO "Acrobat Pro $acrobat_version installed successfully." >> $log
    fi

# Installs PapercutClient
$JAMF policy -trigger provision_pcclient
  pcc_version=$(defaults read /Applications/PCClient.app/Info.plist CFBundleShortVersionString)
    if [[ $pcc_version == "" ]]; then
      # Not Installed
      $ECHO "PCClient install failed." >> $log
    else
      # installed
      $ECHO "PCClient $pcc_version installed successfully." >> $log
    fi

# Installs Office icons
$JAMF policy -trigger provision_officeicons
  $ECHO "Office Icons added to Dock." >> $log

# Installs Oakhill Certificates
$JAMF policy -trigger provision_certs
  $ECHO "Installed Oakhill Certs." >> $log

# Installs Sophos (Calls Provision which calls both pre-install and post-run script policies)
$JAMF policy -trigger provision_sophosbundle
  $ECHO "Installed Sophos Endpoint." >> $log

# Set Timezone to Sydney
$JAMF policy -trigger provision_timezone
  $ECHO "Timezone set to Sydney." >> $log

### Main Apps End ###

### Final Recon and Checks for last policies
$JAMF recon
$JAMF policy

$ECHO "Setup Complete. Device is now ready." "$dateStamp" >> $log
####################################################################################################
