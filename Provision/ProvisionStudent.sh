#!/usr/bin/env bash

####################################################################################################
# PURPOSE
# - Provisioning based on policy to replace imaging.
# HISTORY
#   Version: 1.0
#   - Connor Sanders 9 August 2018
#      - Build and structure
#   Version: 1.1
#   - Connor Sanders 14 August 2018
#      - Added version install checks
#   Version: 1.2
#   - Connor Sanders 15 August 2018
#      - Fixed error with Version Checks
#      - Cleaned up apps without CFBundleShortVersionString (PCClient & Vivi)
#
#
####################################################################################################

# Checks for root, rejects if not.
if [ "$(id -u)" != "0" ]; then echo "Please run $0 as root." && exit 1; fi
####################################################################################################
# Starting Announcment and trapout
/bin/echo "Starting Student Configuration..."
/bin/echo "Will Bind to AD and Create Student Admin Account"
/bin/echo "Press ctrl+C to cancel..."
/bin/echo "3..."
sleep 1
/bin/echo "2..."
sleep 1
/bin/echo "1..."
sleep 1
####################################################################################################
# Creates Log File
log=~/Desktop/log.txt
/usr/bin/touch $log

dateStamp=$( date "+%a %b %d %H:%M:%S")
/bin/echo "$dateStamp" >> $log
/bin/echo "Started Student Provision..." >> $log
####################################################################################################

# Installating apps.....

### Main Apps ###
# Prompt for Computer Name
/usr/local/jamf/bin/jamf policy -trigger provision_nameprompt
  /bin/echo "Set name to $HOSTNAME" >> $log

# Prompt for Asset Tag
/usr/local/jamf/bin/jamf policy -trigger provision_tagprompt

# Installs Google Chrome
/usr/local/jamf/bin/jamf policy -trigger provision_googlechrome
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
  vivi_version=$( defaults read /Applications/Vivi.app/Contents/Info.plist CFBundleShortVersionString )
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

####################################################################################################

### Student Features ###
# Binds to AD
/usr/local/jamf/bin/jamf policy -trigger provision_bind
  /bin/echo "Machine bound to AD." >> $log

# Installs Local Student Account
/usr/local/jamf/bin/jamf policy -trigger provision_studentlocal
  /bin/echo "Local Student Account added." >> $log

### Student Features End ###

### Final Recon and Checks for last policies
/usr/local/jamf/bin/jamf recon
/usr/local/jamf/bin/jamf policy

/bin/echo "Setup Complete. Device is now ready." "$dateStamp" >> $log
####################################################################################################
