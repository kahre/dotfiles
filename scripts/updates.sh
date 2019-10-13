#!/bin/sh
pac=$(checkupdates 2> /dev/null | wc -l)
aur=$(checkupdates-aur 2> /dev/null | wc -l)

RES=$(("$pac" + "$aur"))

if [ "$RES" != "0" ]; then
    echo "$pac / $aur"
else
    echo " "
fi
