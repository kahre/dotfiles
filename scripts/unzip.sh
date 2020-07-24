#!/bin/bash

if [[ "$1" == "-f" ]]; then
    # Extract to folders
    for f in *; do
        FN=$(echo ${f// /_} | sed 's/\(.*\)\..*/\1/g')
        unzip "$f" -d "$FN" 
        mv "$f" "$FN"
    done
else
    for f in *; do unzip "$f"; done
fi
