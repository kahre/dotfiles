#!/bin/bash

res=`ping duckduckgo.com -c 1 -q -W 2 -w 2 | grep 'trans' | wc -l`
#echo ">>> $res"
if [ "$res" -eq "1" ]
then exit
else exit -1
fi
