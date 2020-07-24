#!/bin/bash

MAN_CONFIG1="eDP1"

xrandr --output $MAN_CONFIG1 --primary --auto

OUTPUTS=$(xrandr | grep " connected" | sed 's/\(.*\) connected.*/\1/g')

for OUTPUT in $OUTPUTS; do
    echo "Setting up output $OUTPUT"
    if [[ $OUTPUT == "$MAN_CONFIG1" ]]; then
        echo "Manually configured, ignoring"
        continue
    fi
    xrandr --output "$OUTPUT" --auto
done

echo "Reloading i3"
i3-msg restart
echo "Fixing wallpaper"
feh --randomize --bg-fill ~/Pictures/zoefiriwp/
