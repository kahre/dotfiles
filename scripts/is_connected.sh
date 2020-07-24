#!/bin/sh

if wget -q --spider https://duckduckgo.com; then 
    exit
else 
    exit 1
fi
