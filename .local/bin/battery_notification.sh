#!/bin/bash

# Set the threshold for low battery
THRESHOLD=100

# Get the battery information
BATTERY_INFO=$(acpi -b)
BATTERY_LEVEL=$(echo "$BATTERY_INFO" | grep -P -o '[0-9]+(?=%)')
BATTERY_STATUS=$(echo "$BATTERY_INFO" | awk '{print $3}' | tr -d ',')

echo "Battery Info: ${BATTERY_INFO}"


# Check if the battery is discharging and the level is below the threshold
if [[ "$BATTERY_STATUS" == "Discharging" && "$BATTERY_LEVEL" -le "$THRESHOLD" ]]; then
    # Send a notification using dunst
    notify-send -u critical "Low Battery" "(${BATTERY_LEVEL}%), ${BATTERY_INFO}"
fi
