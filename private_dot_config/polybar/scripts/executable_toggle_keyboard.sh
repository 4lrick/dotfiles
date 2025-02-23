#!/bin/bash

DEVICE="at-translated-set-2-keyboard"
VAR="device[$DEVICE]:enabled"
FILE="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/keyboard.status"

toggle_keyboard() {
    echo "$1" > "$FILE"
    notify-send -u normal "$([[ $1 == true ]] && echo "Enabling" || echo "Disabling") laptop keyboard"
    hyprctl keyword "$VAR" "$1" -r
    hyprctl keyword input:touchpad:disable_while_typing "$([[ $1 == true ]] && echo true || echo false)"
}

if [[ ! -f "$FILE" ]]; then
    toggle_keyboard false
else
    current_status=$(< "$FILE")
    if [[ "$current_status" == "true" ]]; then
        toggle_keyboard false
    else
        toggle_keyboard true
    fi
fi
