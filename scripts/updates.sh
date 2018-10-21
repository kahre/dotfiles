#!/bin/bash
pac=$(checkupdates 2> /dev/null | wc -l)
aur=$(checkupdates-aur 2> /dev/null | wc -l)

if [[ "$(expr $pac + $aur)" != "0" ]]; then
    echo "$pac / $aur"
else
    echo " "
fi
