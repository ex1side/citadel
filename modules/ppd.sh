#!/bin/bash

if [["$1" == "--status"]]; then
    PROFILE=$(powerprofilesctl get | awk '{print $NF}')
    echo "Power profile: ${PROFILE: -unknown}"
    exit 0
fi

PROFILES=("performance" "balanced" "power-saver" "↩️ Back")

CHOICE=$(printf "%s\n" "${PROFILES[@]}" | rofi -dmenu -p "Power profiles")

case "$CHOICE" in
    "performance"|"balanced"|"power-saver")
    if powerprofilesctl set "$CHOICE"; then
        notify-send -u normal -a "powerprofilesctl" -i preferences-system-performance \
            "Power profile changed." "Current profile: $CHOICE"
    else
        notify-send -u critical -a "powerprofilesctl" -i dialog-error \
            "❌ Error" "Mode not set: $CHOICE"
    fi
    ;;
    "↩️ Back"|"")
    exit 0
    ;;
esac
