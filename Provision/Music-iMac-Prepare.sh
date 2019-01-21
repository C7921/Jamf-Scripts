#!/usr/bin/env bash

###################################################################################################
# PURPOSE
# - Configuration for Music iMacs 2019
# HISTORY:
#   Version: 1.0.0 - Creation.
#   - Connor Sanders 15 Jan 2019
#      - Build and structure
#
#	Version: 1.05 - Modified
#  	- Connor Sanders 17 Jan 2019
#   	- Added Re-enroll
#     - Added admin password reset
#     - Better OS Comparison
#
# Version: 1.0.9 - Modified
#    - Connor Sanders 18 Jan 2019
#     - Added better removal of Google Chrome.
#     - Added better but slower removal of Office apps and data.
#
############################ Items to be Removed & Prepared ########################################
# Ensure macOS Mojave is installed (download installer if not.)
# Ensure Administrator account password is set correctly.
# Adobe Creative Cloud
# Google Chrome
# Vivi
# VLC Media Player
# Office 365
# Sophos Anti-Virus
# Timezone - Sydney
# Remove "SSIDNAME" from known wireless networks
####################################################################################################
# Checks for root, rejects if not.
if [ "$(id -u)" != "0" ]; then /bin/echo "Please run $0 as root." && exit 1; fi
#####################################################################################################
# Creates Log File
log=~/Desktop/PrepareLog.txt
/usr/bin/touch $log

dateStamp=$( date "+%a %b %d %H:%M:%S")
/bin/echo "$dateStamp" >> $log
  /bin/echo "Started Music Preparation..." >> $log
###################### Functions & Variables ########################################################
# Functions for Current OS Versions
function version { echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'; }
OSVersion=$(sw_vers | grep ProductVersion | awk '{print $2}')
# Current Latest OS Release
LatestMojave="10.14.2"

# Set jamf with Symlink here
JAMF="/usr/local/jamf/bin/jamf"

# Current User
myUser=$(ls -l /dev/console | awk '{print $3}')

# Installed Adobe Apps before Removal
preInstalledAdobe=$(ls /Applications/ | grep Adobe)

# Confirmation Functions.
seek_confirmation() {
  printf "\n"
  read -p " (y/n) " -n 1
  printf "\n"
}

is_confirmed() {
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  return 0
fi
return 1
}

# Uninstall Adobe Programs. Expects to have uninstaller policies able to call with syntax "uninstall_$appName"
function uninstallAdobe() {
  for dir in /Applications/Adobe*/
  do
      dir=${dir%*/}
      # echo ${dir##*/}
      app=$(echo ${dir##*/} | awk '{$1=$1};1' | awk '{print $2}')
  		echo $app "is being uninstalled $dateStamp" >> $log
  		/usr/local/jamf/bin/jamf policy -trigger uninstall_$app
       # sudo rm -rf /Applications/Adobe\ $app* -- Untested.
  done
}

# Installed Adobe CC Cleaner Tool and run to remove other Adobe programs that may have been missed
function cleanUpAdobe() {
  $JAMF policy -trigger adobe_cleaner
  /bin/echo "Installed Adobe CC Cleaner. Running... $dateStamp" >> $log
  sudo /Applications/Adobe/Adobe\ Creative\ Cloud\ Cleaner\ Tool.app/Contents/MacOS/Adobe\ Creative\ Cloud\ Cleaner\ Tool --removeAll=All
  /bin/echo "Adobe Cleanup should now be complete $dateStamp" >> $log
}

# Force remove Adobe from applications folder
function forceAdobe() {
  sudo rm -rf /Applications/Adobe*
  /bin/echo "Forcibly remove adobe folders from /Applications $dateStamp" >> $log
}

# Remove Installed Google Chrome
function removeChrome() {
  /bin/cho "Starting Google Chrome Removal $dateStamp" >> $log
  /bin/echo "Removing Chrome.app $dateStamp" >> $log
  sudo rm -rf /Applications/Google\ Chrome.app
  /bin/echo "Removing current user library files $dateStamp" >> $log
  sudo rm -rf ~/Library/Application\ Support/Google/Chrome
  /bin/echo "Removing Remaining User Library Files $dateStamp" >> $log
  # Loop through all Users
   for u in /Users/*
      do
      	cd /Users/
         	[ -d $u ] && cd "$u" && /bin/echo "Entering into $u and removing Chrome. $dateStamp" >> $log
    		rm -rf $u/Library/Application\ Support/Google/Chrome
      done
  /bin/echo "All Google Chrome files have now been removed. $dateStamp" >> $log
}

# Uninstalls Vivi from /Applications
function removeVivi() {
  sudo killall Vivi
  viviName="Vivi.app"
  viviInstalled=$(ls /Applications/ | grep -i "${viviName}")
  # Vivi file location array
  viviFiles=(/Applications/Vivi.app
  ~/Library/Containers/au.com.viviaustralia.mac
  ~/Library/Preferences/au.com.viviaustralia.mac.helper.plist
  ~/Library/Prefernces/au.com.viviaustralia.mac.plist
  ~/Library/Application\ Support/Vivi )
  if [ "$viviInstalled" == "$viviName" ]; then
  /bin/echo "${viviName} is installed $dateStamp" >> $log
  /bin/echo "Starting removing $dateStamp" >> $log
  for u in "${viviFiles[@]}"
  do
    /bin/echo "$u is removed" && rm -rf $u
  done
    # Loop through all Users
     for d in /Users/*
        do
        	cd /Users/
           	[ -d $d ] && cd "$d" && /bin/echo "Entering into $d and removing Vivi. $dateStamp" >> $log
            rm -rf $d/Library/Containers/au.com.viviaustralia.mac
            rm -rf $d/Library/Preferences/au.com.viviaustralia.mac.helper.plist
            rm -rf $d/Library/Preferences/au.com.viviaustralia.mac.plist
            rm -rf $d/Library/Application\ Support/Vivi
        done
    /bin/echo "Removal Completed. All User and system files gone. $dateStamp" >> $log
  else
    /bin/echo "${viviName} not installed $dateStamp" >> $log
  fi
}

# Remove VLC from /applications
function removeVLC() {
  vlcPID=$(ps -ax | grep /Applicaitons/VLC.app | awk '{print $1}')
  killall $vlcPID
  /bin/echo "VLC Quit with PID as $vlcPID. Removing files... $dateStamp" >> $log
  rm -rf /Applications/VLC.app
  /bin/echo "Removed VLC from /Appliations $dateStamp" >> $log
}

# Remove Office 2016/365 completly from the system
function removeOffice() {
  /bin/echo "Downloading required files...$dateStamp" >> $log
  cd /private/var/tmp

  /bin/echo "Running File #1 $dateStamp" >> $log
  # Silent Uninstall Office - Appears to be the only one required.
  curl https://gist.githubusercontent.com/sheagcraig/61710f548e9be8a8db2cbc4ba8f2b6a6/raw/6d460c1add055cc135ce5dc02156f3b1c00ac8aa/uninstall_office2016.py | sudo python

  /bin/echo "Running File #2 $dateStamp" >> $log
  # Unlicense Office
  curl -O https://raw.githubusercontent.com/pbowden-msft/Unlicense/master/Unlicense
  cd /Users/Admin/ && sudo bash Unlicense --All

  /bin/echo "Running file #3 $dateStamp" >> $log
  # Nuke Office Keychain
  curl -O https://raw.githubusercontent.com/pbowden-msft/NukeOffKeychain/master/NukeOffKeychain.sh
  sudo bash NukeOffKeychain --All

  /bin/echo "All Office files and licenses should now be removed. Running Cleanup $dateStamp" >> $log
  cd && rm /private/var/tmp/*
}

# Sophos
function killSophos() {
  sophosPID=$(ps -ax | grep Sophos | awk '{print $1}')
  # Killing all processes
  /bin/echo "Ending Sophos Processes $dateStamp" >> $log
  kill $sophosPID
  # Removes Files
  sudo rm -rf /Library/LaunchAgents/com.sophos.agent.plist
  sudo rm -rf /Library/LaunchAgents/com.sophos.uiserver.plist
  sudo rm -rf /Library/Sophos\ Anti\ Virus
  sudo rm -rf /Applications/Sophos\ Endpoint.app
  sudo rm -rf /Applications/Sophos\ Endpoint\ Self\ Help.app
  sudo rm -rf /Applications/Remove\ Sophos\ Endpoint.app
  #Killing all processes again.
  /bin/echo "Ending Sophos processes again $dateStamp" >> $log
  kill $sophosPID
  /bin/echo "Sophos Files Remove. Restart device before attempting re-install. $dateStamp" >> $log
}

# Forget Oakhill College SSID
function removeSSID() {
  # Get WirelessPort ID
  WirelessPort=$(networksetup -listallhardwareports | awk '/Wi-Fi|AirPort/{getline; print $NF}')
  WirelessSSID="SSID_NAME_HERE"
    /bin/echo "WirelessPort detected as $WirelessPort $dateStamp" >> $log
    /bin/echo "Removing Prefered SSID of $WirelessSSID $dateStamp" >> $log
  # Remove SSID if present.
    networksetup -remove preferedwirelessnetwork $WirelessPort $WirelessSSID 2>/dev/null
    /bin/echo "$WirelessSSID has been removed.  $dateStamp" >> $log
}

####################################################################################################
# Checking for macOS Mojave. Skip to bottom for if not running Latest Mojave.
if [ $(version $OSVersion) -ge $(version $LatestMojave) ]; then

  ### Starting Main ###
  /bin/echo "Mojave Installed. Beginning preparations... $dateStamp" >> $log

  # Creative Cloud
  /bin/echo "Current Installed Creative Cloud Software $dateStamp" >> $log
  /bin/echo "$preInstalledAdobe $dateStamp" >> $log
  /bin/echo "Starting Removal of Creative Cloud Software" $dateStamp >> $log
  uninstallAdobe
  /bin/echo "All Adobe Program should now be uninstalled. Running Cleanup. $dateStamp" >> $log
  cleanUpAdobe
  sudo rm -rf /Applications/Adobe && /bin/echo "Removed Cleaner Tool $dateStamp" >> $log
  /bin/echo "Adobe Section Completed. Starting other applications $dateStamp" >> $log

  # Google Chrome
  /bin/echo "Starting Chrome Removal $dateStamp"  >> $log
  removeChrome

  # Vivi
  /bin/echo "Starting Vivi Removal $dateStamp" >> $log
  removeVivi

  # VLC
  /bin/echo "Starting VLC Removal $dateStamp" >> $log
  removeVLC

  # Office 365
  /bin/echo "Starting Office Removal $dateStamp" >> $log
  removeOffice

  # Sophos
  /bin/echo "Starting Sophos Removal $dateStamp" >> $log
  removeSophos

  # Set Timezone to Sydney
  $JAMF policy -trigger provision_timezone
    /bin//bin/echo "Timezone set to Sydney. - $dateStamp" >> $log

  ###################
  ### Ending Main ###
  ###################

  /bin/echo "Main Applications and files have been removed. $dateStamp" >> $log

  # Resets Administrator/Oakadmin User Account password
  /bin/echo "Resetting admin account password. $dateStamp" >> $log
  $JAMF policy -trigger reset_adminpw
  /bin/echo "Admin Account password reset $dateStamp" >> $log

  # Removes Student Admin account
  /bin/echo "Removing Student Admin Account $dateStamp" >> $log
  $JAMF policy -trigger remove_studentAdmin
  /bin/echo/ "Student Admin Account removed. $dateStamp" >> $log

  # Erases all bash history.
  for d in /Users/*
     do
       cd /Users/
         [ -d $d ] && cd "$d" && /bin/echo "Entering into $d and clearing bash history. $dateStamp" >> $log
         rm $d/.bash_history
     done
    /bin/echo "Cleared Bash History. $dateStamp" >> $log

  # Re-enrolls Computer with MDM Profile
  /bin/echo "Re-enrolling Computer. MDM Profile will probably need to be verifed $dateStamp" >> $log
  $JAMF policy -trigger adrian-reenroll
  /bin/echo "Computer has been reenrolled... $dateStamp" >> $log

  ### Final Recon and Checks for last policies before restart
  /bin//bin/echo "Prepation Complete. Running Final Checks and Recon before reboot. $dateStamp" >> $log
  $JAMF recon && $JAMF policy

  # Reboots Computer
  sleep 8
  $JAMF policy -trigger reboot_now

  #############################
  # If not running LatestMojave
  #############################
else
  /bin/echo "Not Running Lateset Mojave. Downloading Installer... $dateStamp" >> $log
  $JAMF policy -trigger cache_mojave
  /bin/echo "Installer Downloaded. Please Run and re-try script. $dateStamp" >> $log
fi
