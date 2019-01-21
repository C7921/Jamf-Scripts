#!/usr/bin/env bash

####################################################################################################
# PURPOSE
# - Configuration for Art iMacs 2019
# HISTORY
#   Version: 1.0.0 - Creation.
#   - Connor Sanders 14 Jan 2019
#      - Build and structure
#
############################ Items Installed #######################################################
# Adobe Creative Cloud
# Timezone - Sydney
# Office 365 (Serialised)
# Google Chrome
# VLC Media Player
# Vivi
# Papercut
# Sophos Anti-Virus
# Certficaites
# Disable Airport & Final Checks
####################################################################################################
# Checks for root, rejects if not.
if [ "$(id -u)" != "0" ]; then echo "Please run $0 as root." && exit 1; fi
####################################################################################################
# Starting Announcment and trapout
/bin/echo "Starting Art iMac Configuration..."
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
  /bin/echo "Started Art Provision..." >> $log
####################################################################################################
### Main Apps ###
# Prompt for Computer Name
/usr/local/jamf/bin/jamf policy -trigger provision_nameprompt; sleep 5
  /bin/echo "Set name to $HOSTNAME - $dateStamp" >> $log

# Prompt for Asset Tag // Using script instead of Call. Test to reduce recons.
# /usr/local/jamf/bin/jamf policy -trigger provision_tagprompt
tag=$(osascript -e 'Tell application "System Events" to display dialog "Please enter the Asset Tag of the computer." default answer ""' -e 'text returned of result')
  /bin/echo "Set tag to: $tag - $dateStamp" >> $log
  /usr/local/jamf/bin/jamf recon -assetTag $tag

# Installs Master Adobe Package
/bin/echo "Starting Adobe Install - $dateStamp" >> $log
/usr/local/jamf/bin/jamf policy -trigger adobe_master
  /bin/echo "Adobe Install complete. Checking version" >> $log
  acrobat_version=$(defaults read /Applications/Adobe\ Acrobat\ DC/Adobe\ Acrobat.app/Contents/Info.plist CFBundleShortVersionString)
    if [[ acrobat_version == "" ]]; then
      # Not installed/unable to get version
      /bin/echo "Adobe install appears to have failed" >> $log
    else
      /bin/echo "Adobe version $acrobat_version appears to have installed" >> $log
    fi

# Set Timezone to Sydney
/usr/local/jamf/bin/jamf policy -trigger provision_timezone
  /bin/echo "Timezone set to Sydney. - $dateStamp" >> $log

# Install Office Serailised Bundle
/usr/local/jamf/bin/jamf policy -trigger office_multibundle
	/bin/echo "Installing Serialised Office - $dateStamp" >> $log
	/bin/echo "Attempting to check installed version" >> $log
excel_version=$(defaults read /Applications/Microsoft\ Excel.app/Contents/Info.plist CFBundleShortVersionString)
    if [[ $excel_version == "" ]]; then
      # Not installed
      /bin/echo "MS office may not have installed" >> $log
    else
      # Installed
      /bin/echo "MS Office $excel_version appears to have installed." >> $log
    fi

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
      /bin/echo "Vivi install failed. - $dateStamp" >> $log
    else
      /bin/echo "Vivi $vivi_version installed successfully. - $dateStamp" >> $log
    fi

# Installs VLC (V3.0.4)
/usr/local/jamf/bin/jamf policy -trigger provision_vlc
	vlc_version=$(defaults read /Applications/VLC.app/Contents/Info.plist CFBundleShortVersionString)
		if [[ $vlc_version == "" ]]; then
			#Not Installed
			/bin/echo "VLC install failed - $dateStamp" >> $log
		else
			/bin/echo "VLC $vlc_version installed successfully - $dateStamp" >> $log
		fi

# Installs PapercutClient
/usr/local/jamf/bin/jamf policy -trigger provision_papercut
  pcc_version=$(defaults read /Applications/PCClient.app/Info.plist CFBundleShortVersionString)
    if [[ $pcc_version == "" ]]; then
      # Not Installed
      /bin/echo "PCClient install failed. - $dateStamp" >> $log
    else
      # installed
      /bin/echo "PCClient $pcc_version installed successfully. - $dateStamp" >> $log
    fi

# Installs Sophos (Calls Provision which calls both pre-install and post-run script policies)
/usr/local/jamf/bin/jamf policy -trigger provision_sophosbundle
  /bin/echo "Installed Sophos Endpoint. - $dateStamp" >> $log

# Installs Oakhill Certificates
/usr/local/jamf/bin/jamf policy -trigger provision_certs
  /bin/echo "Installed Oakhill Certs. - $dateStamp" >> $log

### Main Apps End ###

# Turns off Airport and Requires Admin Password for change
# Wifi Off
networksetup -setairportpower $(networksetup -listallhardwareports | awk '/AirPort|Wi-Fi/{getline; print $NF}') off
# Require Admin Changes
/usr/libexec/airportd prefs RequireAdminIBSS=YES RequireAdminNetworkChange=YES RequireAdminPowerToggle=YES
  /bin/echo "Restricted Wifi settings to Administrators only - $dateStamp" >> $log

# Installs Papercut Login Hook
/usr/local/jamf/bin/jamf policy -trigger papercut_maclab
  /bin/echo "Installed Papercut Login Hook - $dateStamp" >> $log

# Binds to AD
/usr/local/jamf/bin/jamf policy -trigger provision_bind
	/bin/echo "Binding to AD. - $dateStamp" >> $log

# Restricts Self Service to Local Admin
/usr/local/jamf/bin/jamf policy -trigger restrict_selfservice
  /bin/echo "Settings Self Service Restrictions - $dateStamp" >> $log

### Final Recon and Checks for last policies before restart
/usr/local/jamf/bin/jamf recon && /usr/local/jamf/bin/jamf policy
/bin/echo "Setup Complete. Device is now ready." "$dateStamp" >> $log
/bin/echo "Requesting reboot policy - $dateStamp" >> $log

# Reboots Computer
/usr/local/jamf/bin/jamf policy -trigger reboot_now
####################################################################################################
