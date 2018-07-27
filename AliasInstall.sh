#!/bin/bash
# Novemeber 2017
# Adds to .Bash_profile file in the user directory.
# Will be creating something for user friendly with variable options.
#

# Add alias to ./Bash_profile file.

echo "alias recon='sudo jamf recon'" >> ~/.bash_profile
echo "alias policy='sudo jamf policy'" >> ~/.bash_profile
echo "alias manage='sudo jamf manage'" >> ~/.bash_profile
echo "alias AppsTest='sudo jamf policy -event soe'" >> ~/.bash_profile
echo "alias Dock='sudo jamf policy -event dock'" >> ~/.bash_profile
echo "alias c='clear'" >> ~/.bash_profile
echo "alias ce='clear && exit'" >> ~/.bash_profile
echo "alias bh='bash ~/Library/Init/brewMaintenance.sh'" >> ~/.bash_profile
echo "alias nomad='open -a NoMad'" >> ~/.bash_profile
echo "alias cdgit='cd ~/Documents/Github %% pwd; sleep .2 && clear'" >> ~/.bash_profile
echo "alias gj='cd ~/Documents/Github/Jamf-Scripts/'" >> ~/.bash_profile
echo "alias dp='cd ~/Desktop/'" >> ~/.bash_profile
echo "alias dl='cd ~/Downloads/'" >> ~/.bash_profile
echo "alias do='cd ~/Documents/'" >> ~/.bash_profile
echo "alias appcheck='bash ~/Library/init/checkApps.sh'" >> ~/.bash_profile
 
# Set Source

source ~/.bash_profile


exit 0
