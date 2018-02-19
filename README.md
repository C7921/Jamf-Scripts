# Jamf-Tools-Scripts


##### Scripts and Utilities with Jamf Pro


Slowly adding collection of helpful scripts and commands that can be used with the JSS.
Some can be used without, however most are design to interact with the JSS.
The Development branch is mainly for odd ideas and experiments.


## Scripts Breakdown

### AliasInstall.sh
Installs basic Jamf Commands into the current users .Bash_profile to create alias.
Currently adds;
  - jamf recon
  - jamf policy
  - jamf manage
  - A few other custom calls for JSS policies.

#### Planned Updates
- More Jamf commands
- Able to add custom calls for other JSS policies by JSS Policy ID

--------------------------

### enableARD.sh
Can enable or disable ARD Remote Managment for a specified user.
Grants full or removes all privileges for the specified user.

#### Planned Updates
- Be able to select user from a list of users {OPTIONAL}
- Be able to set varying levels of access for the selected users.
- Sets ARD on for all users.

---------------------------

### jamfAdminAccount.sh
Creates an admin accout with GUI. Initally created for rollout with replacement laptop program.
Runs easily from Jamf Pro Self Service.

#### Planned Updates
- Better GUI {MAYBE PYTHON variable?}
- Using JSS API if created user is present in JSS, asign machine to that user. If not found, create user in JSS?
	1. The above makes it easier than using the built in Apple System Prefs
- Can handle spaces in the FullName
- Hash/block out password when entered.

---------------------------

### JamfManage.sh
Created to resolve profiles and certificate issue with certain Macs.
Turns off Wifi and checks connection to ensure no dropouts. Runs several Jamf commands that collectivly resolves most jamf related issue.
(Not jamfs fault!)

#### Planned Updates
- Be able to resolve Binary issues 
- Check and remove expired certificate
- Better option to check for internet connection

---------------------------

### MacCopy.sh
Creates terminal options to tranfer files between devices or directories.

#### Planned Updates
- If changing user accouts or different computers set permission to current parent directory new owner. If not parent directory set as root.
- Option for GUI?
- Option for tranfer variables to be set in JSS Policy.

---------------------------

### NewComputerName.sh
Displays Popup Window for new hostname of machine.
Changes the localname, hostname, and computername.
If being used with JSS, would suggest using the Maintenance Tab to update inventory rather than adding it at the end of script.
Partly for sanity and partly for log sake.

#### Updates Planned 
- Option to use AssetTag field in JSS as Suxfix or Prefix in hostname
- 

---------------------------

### NewUser.sh
Similar to Jamf Admin Account. Create New User (option to create admin) in termial windows. 
Handy with SSH or Recon Tab. 

#### Planned Updates
- Can have the variables set in the JSS. (Optional though? Have the script still run without being set)

---------------------------

### RenameHDDVariable.sh
Checks with JSS to see if a variable has been entered, also checks if the name has already been changed.

#### Planned Updates
- Check functionality with High Sierra
- Improved syntax and flow to script

---------------------------

### ResetComputerNames.sh
Resets computer name of machine based on JSS policy variable.
Hostname able to be hardcoded, also checks to make sure a variable is entered. Similar to the New Computer Name.sh

#### Planned Updates
- Finds the old hostname in JSS, then updatse and re-assigns new hostname to user of old hostname. (Might already occur due to how JSS updates the hostnames)
- Improved flow and variable syntax

---------------------------

### UninstallGoogleChrome.sh
Completetly removes Google Chrome. Handy for a clean re-install or just to ensure that is removed.

#### Planned Updates
- Better Log File
- Able to use script to update Chrome rather than clean re-install
- Able to carry the same logged in user into new Chrome intall (This and above idea might be different script altogether)

---------------------------

### ViviInstall.sh
Silent download and installs lastest verion of Vivi.pkg from enterprise site.
Handy for update rollouts. 
NOTE: Used this rather than an App Store app so that Apple ID's aren't required and using the JSS Policy features there is more flexability when deploying

#### Planned Updates
- Improved syntax
- Add loading bar to download. (May not be required as download is so small)
- Add loading bar for the install (Might require python?)

---------------------------

### WifiOff.sh
Simple. Gets the current Wifi Device and turns it off. Originally created with computer lab setup.
Script would run to disable Wifi, then would install a config profile to restrict access to System Preferences.

#### Planned Updates
- List of Network Interfaces to print off.
- Easy access to turn wifi back on again.
- Check High Sierra support






