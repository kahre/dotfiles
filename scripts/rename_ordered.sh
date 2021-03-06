#!/bin/bash

EXTENSION="NO_EXT"
PREFIX="NO_PREF"
PAD=0
START=1
NUMERICAL_ORDER=0

while getopts hndl:p:e:s: option
do
case "${option}"
in
h) echo -e "Usage: \n-h display this help message\n-p resulting file prefix\n-e file extension to look for\n-l pad with leading zeroes" && exit;;
p) PREFIX=${OPTARG};;
e) EXTENSION=${OPTARG};;
d) DRY_RUN="true";;
l) PAD=${OPTARG};;
n) NUMERICAL_ORDER="true";;
s) START=${OPTARG};;
*) echo "Invalid flag $option" && exit;;
esac
done

if [[ "$PREFIX" == "NO_PREF" ]]; then
   PREFIX="" 
fi

if [[ "$EXTENSION" == "NO_EXT" ]]; then
    echo "Extension required, define with -e"
    exit 1
fi

if [[ $NUMERICAL_ORDER == "true" ]]; then
    echo "Numerical"
    ALL=$(ls -v | grep ".*\.${EXTENSION}")
else
    ALL=*${EXTENSION}
fi

var=$START
for FILE in $ALL; do
    printf -v FILENAME "${PREFIX}%0${PAD}d.${EXTENSION}" $var 
    var=$((var + 1))
    if [[ "$DRY_RUN" == "true" ]]; then
        echo "Dry run, would have moved $FILE to ${FILENAME}"
        continue
    fi
        
    echo "Moving $FILE to ${FILENAME}"
    mv "$FILE" "$FILENAME"
done
