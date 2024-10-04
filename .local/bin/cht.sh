#!/usr/bin/env bash

# list of langs/core utils
languages=$(echo "golang rust cpp c typescript javascript" | tr " " "\n")
core_utils=$(echo "sed awk xargs find" | tr " " "\n")

selected=$(echo -e "$languages\n$core_utils" | fzf)

read -p "Query for $selected: " query

if echo "$languages" | grep -qs $selected; then
    # tmux split-window -h bash -c "curl cht.sh/$selected/$(echo "$query" | tr " " '+') | bat"
    # tmux -2 split-window -h bash -c "bat -p --color=always <(curl cht.sh/$selected/$(echo "$query" | tr " " '+'))"

    query_url=$(echo "$query" | tr " " '+')
    # Added ?T to get the unhighlighted version
    # command="curl cht.sh/$selected/$query_url | less -R"
    command="curl cht.sh/$selected/$query_url | bat --plain --color=always"
else
    command="curl cht.sh/$selected~$query | bat --plain --color=always"
fi

if [ -n "$TMUX" ]; then
    tmux -2 split-window -h bash -c "$command"
else
    i3-msg split h
    wezterm -e /bin/bash -c "$command" 2> /dev/null
fi
