#!/bin/bash

AC_PATH="/sys/class/power_supply/AC/online"
STATE_FILE="/tmp/last_ac_state"

if [ -f "$STATE_FILE" ]; then
    LAST_STATE=$(cat "$STATE_FILE")
else
    LAST_STATE=""
fi

check_power() {
    local current_state=$(cat "$AC_PATH")

    if [ "$current_state" != "$LAST_STATE" ]; then
        if [ "$current_state" = "1" ]; then
            dunstify -i "battery-charging" \
                     -a "System" \
                     -u low \
                     "Power" \
                     "AC Connected Last: $LAST_STATE Current: $current_state"
        else
            dunstify -i "battery" \
                     -a "System" \
                     -u low \
                     "Power" \
                     "AC Disconnected Last: $LAST_STATE Current: $current_state"
        fi
        echo "$current_state" > "$STATE_FILE"
    fi
}

check_power
