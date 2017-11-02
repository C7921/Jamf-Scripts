#!/bin//bash
# October 207
# Uses Self Service Policy to Create Admin account for end user.
# 

## Creates unique ID

maxid=$(dscl . -list /Users UniqueID | awk '{print $2}' | sort -ug | tail -1)
newid=$((maxid+1))



usernamevar=`/usr/bin/osascript << EOT
tell application "System Events"
    activate 
    set usernamevar to text returned of (display dialog "Enter Username" default answer "")
end tell
EOT`


fullnamevar=`/usr/bin/osascript << EOT
tell application "System Events"
    activate 
    set fullnamevar to text returned of (display dialog "Enter Full Name (Avoid Spaces)" default answer "")
end tell
EOT`


passvar=`/usr/bin/osascript << EOT
tell application "System Events"
    activate 
    set pass to text returned of (display dialog "Enter Password (It will be visible)" default answer "")
end tell
EOT`


echo "Creating account with Admin Rights..."
    sudo dscl . -create /Users/$usernamevar
    sudo dscl . -create /Users/$usernamevar UserShell /bin/bash
    sudo dscl . -create /Users/$usernamevar RealName $fullnamevar
    sudo dscl . -create /Users/$usernamevar PrimaryGroupID 80
    sudo dscl . -create /Users/$usernamevar UniqueID $newid
    sudo dscl . -create /Users/$usernamevar NFSHomeDirectory /Users/$usernamevar
    sudo dscl . -passwd /Users/$usernamevar $passvar
    sudo dscl . -append /Groups/admin GroupMembership $usernamevar
    sudo createhomedir -c > /dev/null
    cp -R /System/Library/User\ Template/English.lproj /Users/$usernamevar
    chown -R $usernamevar:staff /Users/$usernamevar


echo "Account Creation Complete $usernamevar, $fullnamevar, $newid"

exit 0


