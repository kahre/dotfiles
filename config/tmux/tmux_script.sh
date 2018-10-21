#!/bin/bash

BARBLUEC="#[fg=colour74]"
BARGRAYC="#[fg=colour252]"
WARNINGC="#[fg=colour196]"

OUTPUT="";

if [[ `amixer -c 0 get Master | grep Mono: | cut -d " " -f8 | tr -d '[],'` == "on" ]]
then
    OUTPUT=$OUTPUT"$BARBLUEC[ vol $BARGRAYC→ `amixer -c 0 get Master | grep Mono: | cut -d " " -f6 | tr -d '[],'` $BARBLUEC]"
fi

OUTPUT=$OUTPUT"$BARBLUEC[ / $BARGRAYC→ `df -h --output=avail / | sed -n 2p | tr -d " "` $BARBLUEC]"
OUTPUT=$OUTPUT"$BARBLUEC[ / $BARGRAYC→ `df -h --output=avail /home | sed -n 2p | tr -d " "` $BARBLUEC]"

MEMORYPERC=`free -b | grep Mem | awk '{print $3/$2 * 100.0}' | sed "s/\.[0-9]*//g"`
if [[ $MEMORYPERC -lt 70 ]]
then
    OUTPUT=$OUTPUT"$BARBLUEC[ ram $BARGRAYC→ $MEMORYPERC% $BARBLUEC]"
else
    OUTPUT=$OUTPUT"$BARBLUEC[ ram $BARGRAYC→ $WARNINGC$MEMORYPERC% $BARBLUEC]"
fi

CPUPERC=`grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}' | sed "s/\.[0-9]*//g"`
if [[ $CPUPERC -lt 70 ]]
then
    OUTPUT=$OUTPUT"$BARBLUEC[ cpu $BARGRAYC→ $CPUPERC% $BARBLUEC]"
else
    OUTPUT=$OUTPUT"$BARBLUEC[ cpu $BARGRAYC→ $WARNINGC$CPUPERC% $BARBLUEC]"
fi

if [[ `ifconfig | grep enp | grep RUNNING | wc -l` -gt 0 ]]
then
    OUTPUT=$OUTPUT"$BARBLUEC[ net $BARGRAYC→ wired $BARBLUEC]"
elif [[ `ifconfig | grep wlp | grep RUNNING | wc -l` -gt 0 ]]
then
    SSID=`iwgetid | cut -d " " -f5 | sed "s/ESSID://g" | tr -d "\""`
    OUTPUT=$OUTPUT"$BARBLUEC[ ssid $BARGRAYC→ $SSID $BARBLUEC]"
fi

OUTPUT=$OUTPUT"$BARBLUEC[ `date +"%A"` $BARGRAYC`date +"%d/%m-%Y %H:%M:%S"` $BARBLUEC]"

echo $OUTPUT
