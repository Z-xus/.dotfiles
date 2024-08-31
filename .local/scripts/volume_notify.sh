#!/bin/bash

# Change volume
pactl set-sink-volume @DEFAULT_SINK@ $1

# Get new volume
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | head -n 1 | sed 's/%//')

# Calculate the number of filled blocks for the progress bar
blocks=$(seq -s "─" $(($volume / 5)) | sed 's/[0-9]//g')

# Create the progress bar
progress=$(printf "[%-20s] %3s%%" "$blocks" "$volume")

# Send notification with progress bar
dunstify -a "Volume" -u low -i audio-volume-high -h string:x-dunst-stack-tag:volume -h int:value:"$volume" "$progress" -t 800
