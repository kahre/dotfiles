#!/bin/bash

for f in *; do 
	if [[ $f == *.zip ]]; then
		unzip "$f" -d "${f}folder"
		mv "$f" "${f}folder"
	else
		echo "$f is not a zip archive, skipping"
	fi
done
