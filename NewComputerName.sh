#!/bin/bash
#October 2017
# Prompt for Computer Name
# Feel free to change the default text. This was added for the deployment here. Leave the 2x Double Quotes for blank input.


NewMachineName=`/usr/bin/osascript << EOT
tell application "System Events"
    activate
    set NewMachineName to text returned of (display dialog "New Computer Name" default answer "HOST-NAME-ASSET#")
end tell
EOT`

#Set New Computer Name
echo $NewMachineName
scutil --set HostName $NewMachineName
scutil --set LocalHostName $NewMachineName
scutil --set ComputerName $NewMachineName

echo "Renaming Completed!"

# Run Recon    # Comment out/remove if not being used with Jamf Pro
sudo jamf recon

exit 0
