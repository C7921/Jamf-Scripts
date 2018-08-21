#!/bin/bash
# Thanks to Jamf Nation User ubcoits
# https://www.jamf.com/jamf-nation/discussions/28097/jamf-pro-10-4-and-quick-add-package-bug#responseChild167370

# check for SymLink
if [ -L "/usr/local/bin" ]; then
  rm "/usr/local/bin"
  mkdir "/usr/local/bin"
  ln -s "usr/local/jamf/bin/jamf" "/usr/local/bin/jamf"
  ln -s "/usr/local/jamf/bin/jamfAgent" "/usr/local/bin/jamfAgent"
  chown -R root:wheel "/usr/local/bin"
fi
