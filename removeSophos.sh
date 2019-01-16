#!/usr/bin/env bash
# Connor Sanders Jan 16 2019.
# Stops and removes Sophos Anti-Virus for macOS.

# Checks for root, rejects if not.
if [ "$(id -u)" != "0" ]; then echo "Please run $0 as root." && exit 1; fi

# Finds and Quits all Sophos Processes
function killSophos() {
  sophosPID=$(ps -ax | grep Sophos | awk '{print $1}')
  kill $sophosPID
}

# Killing all processes again
kill $sophosPID

# Removes Files
sudo rm -rf /Library/LaunchAgents/com.sophos.agent.plist
sudo rm -rf /Library/LaunchAgents/com.sophos.uiserver.plist
sudo rm -rf /Library/Sophos\ Anti\ Virus
sudo rm -rf /Applications/Sophos\ Endpoint.app
sudo rm -rf /Applications/Sophos\ Endpoint\ Self\ Help.app
sudo rm -rf /Applications/Remove\ Sophos\ Endpoint.app

#Killing all processes again.
kill $sophosPID
echo "Sophos Files Remove. Restart device before attempting re-install."
