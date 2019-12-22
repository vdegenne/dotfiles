#!/bin/bash

curr_workspace=$(i3-msg -t get_workspaces | jq '.[] | select(.focused == true) | .num')


if [ -f ~/.config/i3/.cws ]; then
    prev_workspace=$(cat ~/.config/i3/.cws)
else
    prev_workspace=curr_workspace
fi

echo $curr_workspace > ~/.config/i3/.cws

# print the previous workspace number
printf $prev_workspace
