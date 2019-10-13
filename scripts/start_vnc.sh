#!/bin/sh

stty -echo
printf "Remote password:"
read -r PASSWORD
stty echo
printf "\n"

sudo x11vnc -wait 50 -noxdamage -passwd "${PASSWORD}" -display :0 -forever -o /var/log/x11vnc.log -bg
