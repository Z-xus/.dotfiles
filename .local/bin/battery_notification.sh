#!/bin/bash

THRESHOLD=20
BAT_STATE_FILE="/tmp/last_battery_status"

BATTERY_INFO=$(acpi -b)
BATTERY_LEVEL=$(echo "$BATTERY_INFO" | grep -P -o '[0-9]+(?=%)')
BATTERY_STATUS=$(echo "$BATTERY_INFO" | awk '{print $3}' | tr -d ',')

TIME_REMAINING=$(acpi -b | grep -o '[0-9]\+:[0-9]\+:[0-9]\+')

if [ ! -z "$TIME_REMAINING" ]; then
    HOURS=$(echo $TIME_REMAINING | cut -d: -f1)
    MINUTES=$(echo $TIME_REMAINING | cut -d: -f2)

    HOURS=$(echo $HOURS | sed 's/^0//')
    MINUTES=$(echo $MINUTES | sed 's/^0//')

    if [ "$HOURS" -gt "0" ]; then
        FORMATTED_TIME="${HOURS}hrs ${MINUTES}min"
    else
        FORMATTED_TIME="${MINUTES}min"
    fi

    echo "$FORMATTED_TIME"
fi


LAST_BATTERY_LEVEL=$(cat "$BAT_STATE_FILE" 2>/dev/null || echo "")

echo "Battery Level: $BATTERY_LEVEL"
echo "Battery Status: $BATTERY_STATUS"
echo "Last Battery Level: $LAST_BATTERY_LEVEL"
echo "$((LAST_BATTERY_LEVEL - BATTERY_LEVEL))"

if [[ "$BATTERY_LEVEL" -gt "95" ]]; then
    echo "Battery is full"
    notify-send -a System -u low "Battery Full" "Battery is charged" -i battery-full
fi

if [[ "$BATTERY_STATUS" == "Discharging" && "$BATTERY_LEVEL" -le "$THRESHOLD" ]]; then
    if [ $((LAST_BATTERY_LEVEL - BATTERY_LEVEL)) -ge 5 ]; then
        notify-send -a System -u critical "Low Battery" "(${BATTERY_LEVEL}%), ${FORMATTED_TIME} remaining" -i battery-caution
    fi
fi

echo "$BATTERY_LEVEL" > "$BAT_STATE_FILE"
