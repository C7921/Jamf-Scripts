#!/bin/bash
# The start of the new and improved Mac Copy Tool
# Created as a test for more complex functions, source scripts and other stuff
# Connor Sanders May 2018.

# GOALS
# - Single file only. No dependencies aside from the obvious (intel mac etc).
# - If other files or things are required, ability to download install, without needing to rerun.
# - Clear and easy commands
# - Clear and easy method for selecting source and destination locations

# NOTES
# - Yes, this can be made really easy using Automator.
# - This will hopefully become a command line tool for mac.

# To Do:
# - Functions/ inital check for intel mac etc -- System Requirements
# - Notate the steps required and assign dependencies
# - Easy to read ReadME

# source ~/Library/init/utils.sh

### Check for and download dependencies
utilsFolder=~/Library/macOSCopy/
utilsFile=~/Library/macOSCopy/utils.sh

if [ ! -d "${utilsFile}" ]
then
    echo "${utilsFile} not found."
    # Downloading files required.
    mkdir ~/Library/macOSCopy
    wget https://raw.githubusercontent.com/C7921/Jamf-Scripts/master/CopyTool/utils.sh
    echo "Download Complete. Setting source links"
    source ${utilsFile}
fi


# Starting tool
# Heading
clear
e_header "macOS Copy Tool"
# e_bold "          Connor Sanders 2018"
sleep 1

e_success "Starting Copy tool"
# Seeking source
e_arrow "Enter source location:" && read -p "" varsource
e_bold "You have entered:" && e_warning "$varsource"
