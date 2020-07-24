#!/bin/bash

MAN_CONFIG1="DisplayPort-2"
MAN_CONFIG2="HDMI-A-0"

xrandr --output $MAN_CONFIG1 --primary --auto
xrandr --output $MAN_CONFIG2 --auto --left-of $MAN_CONFIG1

OUTPUTS=$(xrandr | grep " connected" | sed 's/\(.*\) connected.*/\1/g')

for OUTPUT in $OUTPUTS; do
    echo "Setting up output $OUTPUT"
    if [[ $OUTPUT == "$MAN_CONFIG1" ]]; then
        echo "Manually configured, ignoring"
        continue
    fi
    if [[ $OUTPUT == "$MANCONFIG2" ]]; then
        echo "Manually configured, ignoring"
        continue
    fi
    xrandr --output "$OUTPUT" --auto
done

echo "Reloading i3"
i3-msg restart
echo "Fixing wallpaper"
feh --randomize --bg-fill ~/Pictures/zoefiriwp/
