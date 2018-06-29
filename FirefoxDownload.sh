#!/usr/bin/env bash
# Connor Sanders June 2018
# Downloads latest version of Firefox

### Check for and download dependencies
utilsFolder=~/Library/downloadFF
utilsFile=~/Library/downloadFF/utils.sh

if [ ! -d "${utilsFile}" ]
then
    echo "${utilsFile} not found."
    # Downloading files required.
    mkdir ~/Library/downloadFF && echo "Created Directory"
    # wget -P -b ${utilsFolder} https://github.com/C7921/Jamf-Scripts/raw/master
    # Dont be mad. Using cURl as not every mac has wget.
    cd ${utilsFolder} && { curl -L -O https://raw.githubusercontent.com/C7921/Jamf-Scripts/master/CopyTool/utils.sh ; cd -; }
    echo "Download Complete. Setting source links"
    source ${utilsFile}
    # echo ${utilsFile}
  else
    echo "${utilsFile} found."
    source ${utilsFile}
fi
########
# Firefox variables, file names and paths.
dmgName="Firefox.dmg"
VolumeName="Firefox"
targetDrive="/Volumes/Macintosh HD"
downloadURL="https://download.mozilla.org/?product=firefox-latest-ssl&os=osx&lang=en-US"
appName="Firefox.app"
############

### Function defining ###
function setDestination() {
  e_arrow "Enter destination location:" && read -p "" vardestination
  e_bold "You have entered:" && e_warning "$vardestination"
}

function downloadFF() {
  e_success "Downloading DMG File..."
    curl -s -L -o "$vardestination $dmgName" "$downloadURL"
}

function scriptLink() {
  mkdir /tmp/ffInstall
  cd /tmp/ffInstall && { curl -L -O https://raw.githubusercontent.com/C7921/Jamf-Scripts/master/CopyTool/utils.sh ; cd -; }
  e_note "Require Admin access to install"
  sudo bash FirefoxInstall.sh
}

function installFF() {
  seek_confirmation "Install Firefox?"
  if is_confirmed; then
    e_success "Starting install process"
    scriptLink
  else
    e_error "Not Installing."
  fi
}
# Set destination and download
setDestination
downloadFF

e_header "Firefox download complete."
