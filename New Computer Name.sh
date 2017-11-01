#!/bin/bash
#October 2017 
# Prompt for Computer Name
# Current Naming Convention for new Staff Macbook Pros MBP-Staff-ASSETTAG##
# 

 
NewMachineName=`/usr/bin/osascript << EOT
tell application "System Events"
    activate 
    set NewMachineName to text returned of (display dialog "New Computer Name" default answer "")
end tell
EOT`

#Set New Computer Name
echo $NewMachineName
scutil --set HostName $NewMachineName
scutil --set LocalHostName $NewMachineName
scutil --set ComputerName $NewMachineName

echo "Renaming Completed!"

exit 0