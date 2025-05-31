#!/bin/bash

DIR=$(dirname "$(readlink -f "$0")")

source "$DIR/utils/rofi_confs.sh"

main() {
    GPU=$("$DIR/modules/supergfx.sh --status")
    echo -e "$GPU\n ACPI Tools\n PPD\n Exit"
}

while true; do
    CHOICE=$(main | rofi_prompt "citadel")

    case "$CHOICE" in
        *"supergfxctl"*)
            bash "$DIR/modules/supergfx.sh"
                ;;
        *"ACPI Tools"*)
            bash "$DIR/modules/acpi/main.sh"
                ;;
        *"PPD"*)
            bash "$DIR/modules/ppd.sh"
                ;;
        "Exit")
            exit 0
            ;;
    esac
done
