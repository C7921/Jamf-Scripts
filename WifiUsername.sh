#!/bin/sh
# Gets the username of 802.1X Password removes label, whitespaces and ""


username=$(security find-generic-password -D "802.1X Password" | grep "acct" | tr -d ""\" | awk '{$1=$1};1' | cut -c 12- )

echo $username
# echo "<result>$username</result>"
