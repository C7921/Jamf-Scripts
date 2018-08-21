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

# Checks for root, rejects if not.
if [ "$(id -u)" != "0" ]; then echo "Please run $0 as root." && exit 1; fi
####################################################################################################
# Starting Announcment and trapout
/bin/echo "Starting Staff Configuration..."
/bin/echo "Press ctrl+C to cancel..."
/bin/echo "3..."
sleep 1
/bin/echo "2..."
sleep 1
/bin/echo "1..."
sleep 1
/bin/echo "GO!"
####################################################################################################
# Creates Log File
log=~/Desktop/ProvisionLog.txt
/usr/bin/touch $log

dateStamp=$( date "+%a %b %d %H:%M:%S")
/bin/echo "$dateStamp" >> $log
/bin/echo "Started Staff Provision..." >> $log
####################################################################################################

# Installating apps.....

### Main Apps ###
# Prompt for Computer Name
/usr/local/jamf/bin/jamf policy -trigger provision_nameprompt; sleep 5
  /bin/echo "Set name to $HOSTNAME" >> $log

# Prompt for Asset Tag // Using script instead of Call. Test to reduce recons.
# /usr/local/jamf/bin/jamf policy -trigger provision_tagprompt
tag=$(osascript -e 'Tell application "System Events" to display dialog "Please enter the Asset Tag of the computer." default answer ""' -e 'text returned of result')
echo "Set tag to: " $tag >> $log
/usr/local/jamf/bin/jamf recon -assetTag $tag

# Installs Google Chrome
/usr/local/jamf/bin/jamf policy -trigger provision_googlechrome
  # Option for Google Chrome version read out.
  # chrome_version=$(defaults read /Applications/Google\ Chrome.app/Contents/Info.plist CFBundleShortVersionString)
  chrome_version=$(mdls -name kMDItemVersion /Applications/Google\ Chrome.app | cut -c 19- | rev | cut -c 2- | rev)
    if [[ $chrome_version == *"could not find"* ]]; then
        # Not Installed
        /bin/echo "Google Chrome Install Failed." >> $log
      else
        # Installed
        /bin/echo "Google Chrome $chrome_version installed successfully." >> $log
      fi

# Installs Vivi
/usr/local/jamf/bin/jamf policy -trigger provision_vivi
  vivi_version=$(defaults read /Applications/Vivi.app/Contents/Info.plist CFBundleShortVersionString)
    if [[ $vivi_version == "" ]]; then
      # Not Installed
      /bin/echo "Vivi install failed." >> $log
    else
      /bin/echo "Vivi $vivi_version installed successfully.">> $log
    fi

# Install MS Office
/usr/local/jamf/bin/jamf policy -trigger provision_msoffice
  excel_version=$(defaults read /Applications/Microsoft\ Excel.app/Contents/Info.plist CFBundleShortVersionString)
    if [[ $excel_version == "" ]]; then
      # Not installed
      /bin/echo "MS Office install Failed." >> $log
    else
      # Installed
      /bin/echo "MS Office $excel_version installed successfully." >> $log
    fi

# Installs DriveFS
/usr/local/jamf/bin/jamf policy -trigger provision_drivefs
  drivefs_version=$(defaults read /Applications/Google\ Drive\ File\ Stream.app/Contents/Info.plist CFBundleShortVersionString)
    if [[ $drivefs_version == "" ]]; then
      # Not Installed
      /bin/echo "DriveFS install failed." >> $log
    else
      # Installed
      /bin/echo "DriveFS $drivefs_version installed successfully." >> $log
    fi

# Installs Acrobat Pro
/usr/local/jamf/bin/jamf policy -trigger provision_acrobatpro
  acrobat_version=$(defaults read /Applications/Adobe\ Acrobat\ DC/Adobe\ Acrobat.app/Contents/Info.plist CFBundleShortVersionString)
    if [[ $acrobat_version == "" ]]; then
      # Not Installed
      /bin/echo "Acrobat install failed." >> $log
    else
      # Installed
      /bin/echo "Acrobat Pro $acrobat_version installed successfully." >> $log
    fi

# Installs PapercutClient
/usr/local/jamf/bin/jamf policy -trigger provision_pcclient
  pcc_version=$(defaults read /Applications/PCClient.app/Info.plist CFBundleShortVersionString)
    if [[ $pcc_version == "" ]]; then
      # Not Installed
      /bin/echo "PCClient install failed." >> $log
    else
      # installed
      /bin/echo "PCClient $pcc_version installed successfully." >> $log
    fi

# Installs Office icons
/usr/local/jamf/bin/jamf policy -trigger provision_officeicons
  /bin/echo "Office Icons added to Dock." >> $log

# Installs Oakhill Certificates
/usr/local/jamf/bin/jamf policy -trigger provision_certs
  /bin/echo "Installed Oakhill Certs." >> $log

# Installs Sophos (Calls Provision which calls both pre-install and post-run script policies)
/usr/local/jamf/bin/jamf policy -trigger provision_sophosbundle
  /bin/echo "Installed Sophos Endpoint." >> $log

# Set Timezone to Sydney
/usr/local/jamf/bin/jamf policy -trigger provision_timezone
  /bin/echo "Timezone set to Sydney." >> $log

### Main Apps End ###

### Final Recon and Checks for last policies
/usr/local/jamf/bin/jamf recon
/usr/local/jamf/bin/jamf policy

/bin/echo "Setup Complete. Device is now ready." "$dateStamp" >> $log
####################################################################################################
