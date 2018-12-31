#!/bin/bash

wget -q --spider https://duckduckgo.com

if [ $? -eq 0 ]; then 
    exit
else 
    exit -1
fi
