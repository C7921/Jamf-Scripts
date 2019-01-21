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

JAMF="/usr/local/jamf/bin/jamf"
ECHO="/bin/echo"
# Checks for root, rejects if not.
if [ "$(id -u)" != "0" ]; then echo "Please run $0 as root." && exit 1; fi
####################################################################################################
# Starting Announcment and trapout
$ECHO "Starting Student Configuration..."
$ECHO "Will Bind to AD and Create Student Admin Account"
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
$ECHO "Started Student Provision..." >> $log
####################################################################################################

# Installating apps.....

### Main Apps ###
# Prompt for Computer Name
$JAMF policy -trigger provision_nameprompt; sleep 5
  $ECHO "Set name to $HOSTNAME $dateStamp" >> $log

# Prompt for Asset Tag // Using script instead of Call. Test to reduce recons.
# /usr/local/jamf/bin/jamf policy -trigger provision_tagprompt
tag=$(osascript -e 'Tell application "System Events" to display dialog "Please enter the Asset Tag of the computer." default answer ""' -e 'text returned of result')
echo "Set tag to: " $tag  $dateStamp>> $log
/usr/local/jamf/bin/jamf recon -assetTag $tag

# Installs Google Chrome
$JAMF policy -trigger provision_googlechrome
  chrome_version=$(mdls -name kMDItemVersion /Applications/Google\ Chrome.app | cut -c 19- | rev | cut -c 2- | rev)
    if [[ $chrome_version == *"could not find"* ]]; then
        # Not Installed
        $ECHO "Google Chrome Install Failed. $dateStamp" >> $log
      else
        # Installed
        $ECHO "Google Chrome $chrome_version installed successfully. $dateStamp" >> $log
      fi

# Installs Vivi
$JAMF policy -trigger provision_vivi
  vivi_version=$(defaults read /Applications/Vivi.app/Contents/Info.plist CFBundleShortVersionString)
    if [[ $vivi_version == "" ]]; then
      # Not Installed
      $ECHO "Vivi install failed. $dateStamp" >> $log
    else
      $ECHO "Vivi $vivi_version installed successfully. $dateStamp">> $log
    fi

# Install MS Office
$JAMF policy -trigger provision_msoffice
  excel_version=$(defaults read /Applications/Microsoft\ Excel.app/Contents/Info.plist CFBundleShortVersionString)
    if [[ $excel_version == "" ]]; then
      # Not installed
      $ECHO "MS Office install Failed. $dateStamp" >> $log
    else
      # Installed
      $ECHO "MS Office $excel_version installed successfully. $dateStamp" >> $log
    fi

# Installs DriveFS
$JAMF policy -trigger provision_drivefs
  drivefs_version=$(defaults read /Applications/Google\ Drive\ File\ Stream.app/Contents/Info.plist CFBundleShortVersionString)
    if [[ $drivefs_version == "" ]]; then
      # Not Installed
      $ECHO "DriveFS install failed. $dateStamp" >> $log
    else
      # Installed
      $ECHO "DriveFS $drivefs_version installed successfully. $dateStamp" >> $log
    fi

# Installs Acrobat Pro
$JAMF policy -trigger provision_acrobatpro
  acrobat_version=$(defaults read /Applications/Adobe\ Acrobat\ DC/Adobe\ Acrobat.app/Contents/Info.plist CFBundleShortVersionString)
    if [[ $acrobat_version == "" ]]; then
      # Not Installed
      $ECHO "Acrobat install failed. $dateStamp" >> $log
    else
      # Installed
      $ECHO "Acrobat Pro $acrobat_version installed successfully. $dateStamp" >> $log
    fi

# Installs PapercutClient
$JAMF policy -trigger provision_pcclient
  pcc_version=$(defaults read /Applications/PCClient.app/Info.plist CFBundleShortVersionString)
    if [[ $pcc_version == "" ]]; then
      # Not Installed
      $ECHO "PCClient install failed. $dateStamp" >> $log
    else
      # installed
      $ECHO "PCClient $pcc_version installed successfully. $dateStamp" >> $log
    fi

# Installs Office icons
$JAMF policy -trigger provision_officeicons
  $ECHO "Office Icons added to Dock. $dateStamp" >> $log

# Installs Oakhill Certificates
$JAMF policy -trigger provision_certs
  $ECHO "Installed Oakhill Certs. $dateStamp" >> $log

# Installs Sophos (Calls Provision which calls both pre-install and post-run script policies)
$JAMF policy -trigger provision_sophosbundle
  $ECHO "Installed Sophos Endpoint. $dateStamp" >> $log

# Set Timezone to Sydney
$JAMF policy -trigger provision_timezone
  $ECHO "Timezone set to Sydney. $dateStamp" >> $log

### Main Apps End ###

####################################################################################################

### Student Features ###
# Binds to AD
$JAMF policy -trigger provision_bind
  $ECHO "Machine bound to AD. $dateStamp" >> $log

# Installs Local Student Account
$JAMF policy -trigger provision_studentlocal
  $ECHO "Local Student Account added. $dateStamp" >> $log

### Student Features End ###

### Final Recon and Checks for last policies
$JAMF recon
$JAMF policy

$ECHO "Setup Complete. Device is now ready." "$dateStamp" >> $log
$ECHO "--------------"
####################################################################################################
