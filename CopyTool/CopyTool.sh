#!/bin/bash
# The start of the new and improved Mac Copy Tool
# Created as a test for more complex functions, source scripts and other stuff
# Connor Sanders May 2018.

# GOALS
# - Clear and easy commands
# - Option for user permission after copy complete.

### Check for and download dependencies
utilsFolder=~/Library/macOSCopy
utilsFile=~/Library/macOSCopy/utils.sh

if [ ! -d "${utilsFile}" ]
then
    echo "${utilsFile} not found."
    # Downloading files required.
    mkdir ~/Library/macOSCopy && echo "Created Directory"
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

# Functions

function setSource() {
  e_arrow "Enter source location:" && read -p "" varsource
  e_bold "You have entered:" && e_warning "$varsource"
}

function setDestination() {
  e_arrow "Enter destination location:" && read -p "" vardestination
  e_bold "You have entered:" && e_warning "$vardestination"
}

function checkConfirm() {
  seek_confirmation "Is this correct?"
    if is_confirmed; then
      e_success "Great!"
    else
      seek_confirmation "Re-enter path?"
        if is_confirmed; then
          setSource
        else
          e_error "Goodbye."
          exit
        fi
    fi
}

function copyData() {
  rsync -av --progress $varsource $vardestination
  e_success "Complete."
}

function userPermissions() {
    user=`whoami`
    group=admin
    echo $user
    sudo chown $user:$group $vardestination
    e_success "Permissions have been set."
}

#### Starting tool main ####
clear
e_header "macOS Copy Tool"
# e_bold "          Connor Sanders 2018"
sleep 0.3
e_underline "Starting Copy tool"

# Seeking source
setSource
checkConfirm

# Seeking destination
setDestination
checkConfirm

e_success "Source and destination set! Starting Copy."
sleep 1
copyData

# Check for permission change
seek_confirmation "Change file ownership to you?"
  if is_confirmed; then
    userPermissions
  else
    e_error "Permissions have not been changed."
  fi
