#!/bin/bash

COL="\e[0m"
RESET="\e[0m"
ALIGN_LEFT="false"

CHAR="#"

while getopts "c:d:a" arg; do
  case $arg in
    c) COL=$OPTARG;;
    d) CHAR=${OPTARG:0:1};;
    a) ALIGN_LEFT="true";;
    *) echo "Invalid option $arg, supported are -c {COLOUR} -d {CHARACTER}."
        exit 1;;
  esac
done
shift $((OPTIND -1))

LONGEST=0
for str in "$@"; do
    LENGTH=$(echo "$str" | sed 's/\\e\[[0-9]*m//g' | wc -c)
    if [[ "$LENGTH" -gt $LONGEST ]]; then
        LONGEST=$LENGTH
    fi
done

EDGE=$(printf "%0.s$CHAR" $(seq 1 $(( LONGEST + 3 ))))
echo -e "$COL$EDGE$RESET"
for str in "$@"; do
    LENGTH=$(echo "$str" | sed 's/\\e\[[0-9]*m//g' | wc -c)
    DIFF=$(( LONGEST - LENGTH ))
    if [[ "$ALIGN_LEFT" == "true" ]]; then
        START=1
        END=$(seq 0 $(( DIFF )))
    else
        START=$(seq 0 $(( DIFF / 2 )))
        if [ $(( DIFF % 2 )) -eq 0 ]; then
            END=$START
        else
            END=$(seq 0 $(( DIFF / 2 + 1 )))
        fi
    fi
    echo -ne "$COL$CHAR$RESET"
    printf "%0.s " $START
    echo -ne "$str"
    printf "%0.s " $END
    echo -e "$COL$CHAR$RESET"
done
echo -e "$COL$EDGE$RESET"
