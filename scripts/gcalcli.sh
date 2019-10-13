#!/bin/sh

START=$(date +%Y-%m-%dT%H:%M);
END=$(date --date='tomorrow 00:00' +%Y-%m-%dT%H:%M);

if [ "$(date +%u)" = 1 ]; then
    if [ "$(exec gcalcli --tsv=true agenda "$START" "$END" | wc -l)" -gt 1 ]; then
        GCALRES="$(gcalcli --tsv=true agenda "$START" "$END" | sed -n 2p | sed 's/[[:digit:]]\{4\}-[0-9][0-9]-[0-9][0-9]//g' | tr '\t' ' ' | sed 's/  /-/g' | tr -d '*' | tr -d '*\\' | sed 's/nSe beskrivning//g')"
        echo "{\"full_text\":\"[ \",\"color\":\"#6095C5\",\"separator\":false,\"separator_block_width\":1},\
{\"full_text\":\"\",\"color\":\"#6095C5\",\"separator\":false,\"separator_block_width\":3},\
{\"full_text\":\" →\",\"color\":\"#A0A0A0\",\"separator\":false,\"separator_block_width\":10},\
{\"full_text\":\"$GCALRES\",\"color\":\"#A0A0A0\",\"separator\":false,\"separator_block_width\":1},\
{\"full_text\":\" ]\",\"color\":\"#6095C5\",\"separator\":false,\"separator_block_width\":1},"
    fi
else
    if [ $(exec gcalcli --tsv=true agenda "$START" "$END" | wc -l) -gt 0 ]; then
        GCALRES=$(gcalcli --tsv=true agenda "$START" "$END" | sed -n 1p | sed 's/[[:digit:]]\{4\}-[0-9][0-9]-[0-9][0-9]//g' | tr '\t' ' ' | sed 's/  /-/g' | tr -d '*\\' | sed 's/nSe beskrivning//g')
        echo "{\"full_text\":\"[ \",\"color\":\"#6095C5\",\"separator\":false,\"separator_block_width\":1},\
{\"full_text\":\"\",\"color\":\"#6095C5\",\"separator\":false,\"separator_block_width\":3},\
{\"full_text\":\" →\",\"color\":\"#A0A0A0\",\"separator\":false,\"separator_block_width\":10},\
{\"full_text\":\"$GCALRES\",\"color\":\"#A0A0A0\",\"separator\":false,\"separator_block_width\":1},\
{\"full_text\":\" ]\",\"color\":\"#6095C5\",\"separator\":false,\"separator_block_width\":1},"
    fi
fi
