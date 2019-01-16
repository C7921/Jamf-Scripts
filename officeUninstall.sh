#!/usr/bin/env bash
# Completely uninstalls Office (365/2016 for MacOS)
# Connor Sanders Jan 16 2019. File locations take from https://support.office.com/en-us/article/uninstall-office-for-mac-eefa1199-5b58-43af-8a3d-b73dc1a8cae3

# Does not check for files before removing them, too many files or folders to check every one.
####################################################################################################
# Checks for root, rejects if not.
if [ "$(id -u)" != "0" ]; then echo "Please run $0 as root." && exit 1; fi
####################################################################################################
# Quitting apps
echo "Quitting office applications now"
pkill -Microsoft

# Console & Current User
myUser=$(ls -l /dev/console | awk '{print $3}')
echo "You are logged in as $myUser. This will also delete data from all other uers. Included outlook data. Cancel in 5 seconds to abort"
sleep 5
echo "Starting removal..."


# Removing from /Applications folder
officeApps=( Excel.App OneNote.app Outlook.app PowerPoint.app Word.app OneDrive.app )
for app in "${officeApps}"
do
  echo "Removing app ${app}"
  sudo rm -rf "${app}"
done

# Remove from myUser Library folders
officeLib=( com.microsoft.errorreporting com.microsoft.Excel com.microsoft.netlib.shipassertprocess com.microsoft.Office365ServiceV2 com.microsoft.Outlook com.microsoft.Powerpoint com.microsoft.RMS-XPCService com.microsoft.Word com.microsoft.onenote.mac )
for dir in "${officeLib}"
do
  echo "Removing /Users/$myUser/Library/Containers/${dir}"
  sudo rm -rf "${dir}"
done

# Remove myUser Outlook files
officeOutlook=( UBF8T346G9.ms UBF8T346G9.Office UBF8T346G9.OfficeOsfWebHost )
for dir in "${officeOutlook}"
do
  echo "Removing /Users/$myUser/Library/Group Containers/${dir}"
  sudo rm -rf "${dir}"
done

# Loop through all folders in /Users directory
for u in /Users/*;
  do
     [ -d $u ] && cd "$u" && echo "Entering into $u and removing Office."
		rm $u/Library/Containers/com.microsoft.errorreporting
    rm $u/Library/Containers/com.microsoft.Excel
    rm $u/Library/Containers/com.microsoft.netlib.shipassertprocess
    rm $u/Library/Containers/com.microsoft.Office365ServiceV2
    rm $u/Library/Containers/com.microsoft.Outlook
    rm $u/Library/Containers/com.microsoft.Powerpoint
    rm $u/Library/Containers/com.microsoft.RMS-XPCService
    rm $u/Library/Containers/com.microsoft.Word
    rm $u/Library/Containers/com.microsoft.onenote.mac
    rm $u/Library/Group ContainersUBF8T346G9.ms
    rm $u/Library/Group ContainersUBF8T346G9.Office
		rm $u/Library/Group ContainersUBF8T346G9.OfficeOsfWebHost
  done;
echo "Removed files from Other Users"

# Removing System Folders
sudo rm -rf "/Library/Application Support/Microsoft/MAU2.0"
sudo rm  -rf "/Library/Fonts/Microsoft"
sudo rm /Library/LaunchDaemons/com.microsoft.office.licensing.helper.plist
sudo rm /Library/LaunchDaemons/com.microsoft.office.licensingV2.helper.plist
sudo rm /Library/Preferences/com.microsoft.Excel.plist
sudo rm /Library/Preferences/com.microsoft.office.plist
sudo rm /Library/Preferences/com.microsoft.office.setupassistant.plist
sudo rm /Library/Preferences/com.microsoft.outlook.databasedaemon.plist
sudo rm /Library/Preferences/com.microsoft.outlook.office_reminders.plist
sudo rm /Library/Preferences/com.microsoft.Outlook.plist
sudo rm /Library/Preferences/com.microsoft.PowerPoint.plist
sudo rm /Library/Preferences/com.microsoft.Word.plist
sudo rm /Library/Preferences/com.microsoft.office.licensingV2.plist
sudo rm /Library/Preferences/com.microsoft.autoupdate2.plist
sudo rm -rf /Library/Preferences/ByHost/com.microsoft
sudo rm -rf /Library/Receipts/Office2016_*
sudo rm /Library/PrivilegedHelperTools/com.microsoft.office.licensing.helper
sudo rm /Library/PrivilegedHelperTools/com.microsoft.office.licensingV2.helper

# Forget about Office 2016 - Thanks to PiraFrank on Github for this.
pkgutil --forget com.microsoft.package.Fonts
pkgutil --forget com.microsoft.package.Microsoft_AutoUpdate.app
pkgutil --forget com.microsoft.package.Microsoft_Excel.app
pkgutil --forget com.microsoft.package.Microsoft_OneNote.app
pkgutil --forget com.microsoft.package.Microsoft_Outlook.app
pkgutil --forget com.microsoft.package.Microsoft_PowerPoint.app
pkgutil --forget com.microsoft.package.Microsoft_Word.app
pkgutil --forget com.microsoft.package.Proofing_Tools
pkgutil --forget com.microsoft.package.licensing
