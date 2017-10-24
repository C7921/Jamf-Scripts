#!/bin/bash
#
# Connor Sanders October 2017
# Items can be hardcode. However, the script is designed to run with user/admin input to create user account from those items
# Usershell will be /bin/bash and Home Directory will be /Local/Users/Username. 

# Requires Root ## Comment out if not needed
#if [[ $UID -ne 0 ]]; then echo "Please run $0 as root." && exit 1; fi

maxid=$(dscl . -list /Users UniqueID | awk '{print $2}' | sort -ug | tail -1)
newid=$((maxid+1))

#### Collecting User Details ####

read -p 'Username: ' usernamevar

read -p 'FullName: ' fullnamevar

read -p 'Password: ' passvar

# read -p 'UniqueID: ' NextID


### Choice for admin account ###
read -p "Will User be admin? (y or n) " adminvar

if [ "$adminvar" == "y" ]
then
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
 
else
    echo "Creating account without Admin Rights...."
    sudo dscl . -create /Users/$usernamevar
    sudo dscl . -create /Users/$usernamevar UserShell /bin/bash
    sudo dscl . -create /Users/$usernamevar RealName $fullnamevar
    sudo dscl . -create /Users/$usernamevar PrimaryGroupID 20
    sudo dscl . -create /Users/$usernamevar UniqueID $newid
    sudo dscl . -create /Users/$usernamevar NFSHomeDirectory /Users/$usernamevar
    sudo dscl . -passwd /Users/$usernamevar $passvar
    sudo createhomedir -c > /dev/null
    cp -R /System/Library/User\ Template/English.lproj /Users/$usernamevar
    chown -R $usernamevar:staff /Users/$usernamevar
    
fi

echo "Account Creation Complete $usernamevar, $fullnamevar, $newid"

exit 0







