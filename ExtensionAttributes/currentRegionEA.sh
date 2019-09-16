#!/bin/bash

# Current the current Region. Read NSGlobalDomain AppleLocale key. AUD = en_AU@curreny=AUD.
# Get currentRegion
currentRegion=$(defaults read NSGlobalDomain | grep -aRi -C 1 "AppleLocale" | awk '{print $5}' | cut -c 2-18 | grep currency)

# Print Result - AUD expected should be en_AU@currency=AUD.
echo "<result>$currentRegion</result>"
