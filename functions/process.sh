#!/bin/bash

process_manager() {
    TEMP=$(mktemp)
    ps aux > "$TEMP"
    whiptail --textbox "$TEMP" 20 70
    rm "$TEMP"

    PROC_NAME=$(whiptail --inputbox "Enter process name to search and kill:" 10 60 --title "Process Manager" 3>&1 1>&2 2>&3)
    PID=$(pgrep -f "$PROC_NAME")

    if [[ -n "$PID" ]]; then
        whiptail --yesno "Kill process $PROC_NAME (PID: $PID)?" 10 60
        if [[ $? -eq 0 ]]; then
            kill "$PID"
            echo "[Process $PROC_NAME killed] $(date)" >> "$1"
        fi
    else
        whiptail --msgbox "Process not found." 10 40
    fi
}
