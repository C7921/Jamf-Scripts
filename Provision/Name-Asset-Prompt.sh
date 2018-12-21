#!/bin/bash
# Found on Jamf Nation. Lost Username unfortunately. 

export PATH=/usr/bin:/bin:/usr/sbin:/sbin

loggedInUser() {
  python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");'
}

### Get Computer Name Function
forComputerName() {
	message=${1:-"Enter Computer Name || MBP-Staff-ASSET#"}
	defaultvalue=${2:-"MACLOAN"}
	user=$(loggedInUser)
    if [[ $user != "" ]]; then
        uid=$(id -u "$user")

	    launchctl asuser $uid /usr/bin/osascript <<-EndOfScript
			text returned of ¬
				(display dialog "$message" ¬
					default answer "$defaultvalue" ¬
					buttons {"OK"} ¬
					default button "OK")
			EndOfScript
	else
	    exit 1
	fi
}

### Get Asset Tag Function
getAssetTag() {
  tagMessage="Enter the Asset Tag"
	tagDefault="ASSET#"
	user=$(loggedInUser)
    if [[ $user != "" ]]; then
        uid=$(id -u "$user")

	    launchctl asuser $uid /usr/bin/osascript <<-EndOfScript
			text returned of ¬
				(display dialog "$tagMessage" ¬
					default answer "$tagDefault" ¬
					buttons {"OK"} ¬
					default button "OK")
			EndOfScript
	else
	    exit 1
	fi
}
#### Functions End ###
### Start Getting and Settings Values ###

# Computer Name
computerName=$(forComputerName)
echo "Settings Computer Name to $computerName"
scutil --set HostName $computerName
scutil --set LocalHostName $computerName
scutil --set ComputerName $computerName
echo "Renaming Completed"


# Asset Tag
assetTag=$(getAssetTag)
echo "Setting Asset Tag to $assetTag"
sudo jamf recon -assetTag $assetTag

# Updating Inventory Records
sudo jamf recon
