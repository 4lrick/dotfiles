#!/bin/bash

DEVICE="at-translated-set-2-keyboard"
VAR="device[$DEVICE]:enabled"
FILE="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/keyboard.status"

toggle_keyboard() {
    echo "$1" > "$FILE"
    notify-send -u normal "$([[ $1 == true ]] && echo "Enabling" || echo "Disabling") laptop keyboard"
    hyprctl keyword "$VAR" "$1" -r
}

if [[ ! -f "$FILE" || $(< "$FILE") == false ]]; then
    toggle_keyboard true
else
    toggle_keyboard false
fi
