#!/bin/bash

# Function to get current timestamp
get_timestamp() {
    date +"%Y-%m-%d__%H-%M-%S"
}

# Function to capture screenshot
capture_screenshot() {
    local mode=$1
    local dest=$2
    local window_id=$(xdotool getactivewindow)
	local path="/home/$USER/Pictures/ss/$(get_timestamp).png"
    
    case $mode in
        fullscreen)
            if [ "$dest" = "file" ]; then
                maim $path
            else
                maim | xclip -selection clipboard -t image/png
            fi
            ;;
        window)
            if [ "$dest" = "file" ]; then
                maim --capturebackground --hidecursor --window $window_id "$path"
            else
                maim --capturebackground --hidecursor --window $window_id | xclip -selection clipboard -t image/png
            fi
            ;;
        select)
            if [ "$dest" = "file" ]; then
                maim --capturebackground --hidecursor --select $path
            else
                maim --capturebackground --hidecursor --select | xclip -selection clipboard -t image/png
            fi
            ;;
        *)
            echo "Invalid mode"
            exit 1
            ;;
    esac
}

if [ $# -eq 0 ]; then
    echo "Usage: $0 [fullscreen|window|select] [file|clipboard]"
    exit 1
fi

mode=$1
dest=${2:-file}  # Default to file if not specified

capture_screenshot $mode $dest

if [ "$dest" = "file" ]; then
    notify-send "Screenshot saved to /home/$USER/Pictures/ss" -t 1000
else
    notify-send "Screenshot copied to clipboard" -t 1000
fi
