#!/bin/sh

for LINE in $(cat $1); do
    $2 $LINE
done

#while read LINE; do
#    echo "----"
#    echo $LINE
#done << $2
