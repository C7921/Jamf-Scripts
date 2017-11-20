#!/bin/bash
# Novemeber 2017
# Adds to .Bash_profile file in the user directory.
# Will be creating something for user friendly with variable options.
# 

# Add alias to ./Bash_profile file. 

echo "alias Recon='sudo jamf recon'" >> ~/.bash_profile
echo "alias Policy='sudo jamf policy'" >> ~/.bash_profile
echo "alias Policy='sudo jamf policy'" >> ~/.bash_profile
echo "alias Apps='sudo jamf policy -event soe'" >> ~/.bash_profile
echo "alias Dock='sudo jamf policy -event dock'" >> ~/.bash_profile

# Set Source


source ~/.bash_profile


exit 0
