#!/bin/bash

if [["$1" == "--status"]]; then
    MODE=$(supergfxctl -g | awk '{print $NF}')
    echo "Graphics mode: ${MODE: -unknown}"
    exit 0
fi

MODES=("Integrated" "Hybrid" "Vfio" "↩️ Back")

CHOICE=$(printf "%s\n" "${MODES[@]}" | rofi -dmenu -p "Choose graphics mode")

case "$CHOICE" in
    "Integrated"|"Hybrid"|"Vfio")
    if supergfxctl -m "$CHOICE"; then
        notify-send -u normal -a "supergfxctl" -i video-display \
            "🎮 GPU mode changed" "Current mode: $CHOICE"
    else
        notify-send -u critical -a "supergfxctl" -i dialog-error \
            "❌ Error" "Mode not set: $CHOICE"
    fi
    ;;
    "↩️ Back"|"")
    exit 0
    ;;
esac
