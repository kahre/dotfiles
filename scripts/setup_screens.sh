#!/bin/bash

xrandr --output DP-5 --primary --auto
xrandr --output HDMI-2 --auto --left-of DP-5

OUTPUTS=$(xrandr | grep " connected" | sed 's/\(.*\) connected.*/\1/g')

for OUTPUT in $OUTPUTS; do
    echo "Setting up output $OUTPUT"
    if [[ $OUTPUT == "DP-5" ]]; then
        echo "Manually configured, ignoring"
        continue
    fi
    if [[ $OUTPUT == "HDMI-2" ]]; then
        echo "Manually configured, ignoring"
        continue
    fi
    xrandr --output "$OUTPUT" --auto
done

echo "Reloading i3"
i3-msg restart
echo "Fixing wallpaper"
feh --randomize --bg-fill ~/Pictures/zoefiriwp/
