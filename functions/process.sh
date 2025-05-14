#!/bin/bash

process_manager() {
    LOG_FILE="$1"

    while true; do
        CHOICE=$(whiptail --title "Process Manager" --menu "Choose an option:" 15 60 4 \
        "1" "View all running processes" \
        "2" "Kill process by name" \
        "3" "Kill process by PID" \
        "4" "Exit" 3>&1 1>&2 2>&3)

        case "$CHOICE" in
            "1")
                TEMP=$(mktemp)
                ps aux > "$TEMP"
                whiptail --textbox "$TEMP" 20 70
                rm "$TEMP"
                ;;
            "2")
                PROC_NAME=$(whiptail --inputbox "Enter process name to search and kill:" 10 60 --title "Kill by Name" 3>&1 1>&2 2>&3)
                if [[ -z "$PROC_NAME" ]]; then continue; fi

                PIDS=$(pgrep -f "$PROC_NAME")
                if [[ -n "$PIDS" ]]; then
                    for PID in $PIDS; do
                        PROCESS=$(ps -p "$PID" -o comm=)
                        whiptail --yesno "Kill process: $PROCESS (PID: $PID)?" 10 60
                        if [[ $? -eq 0 ]]; then
                            kill -9 "$PID"
                            echo "[Killed $PROCESS (PID: $PID)] $(date)" >> "$LOG_FILE"
                        fi
                    done
                else
                    whiptail --msgbox "Process not found." 10 40
                fi
                ;;
            "3")
                PID=$(whiptail --inputbox "Enter PID to kill:" 10 60 --title "Kill by PID" 3>&1 1>&2 2>&3)
                if [[ -z "$PID" ]]; then continue; fi

                PROCESS=$(ps -p "$PID" -o comm=)
                if [[ -n "$PROCESS" ]]; then
                    whiptail --yesno "Kill process: $PROCESS (PID: $PID)?" 10 60
                    if [[ $? -eq 0 ]]; then
                        kill -9 "$PID"
                        echo "[Killed $PROCESS (PID: $PID)] $(date)" >> "$LOG_FILE"
                    fi
                else
                    whiptail --msgbox "Process with PID $PID not found." 10 40
                fi
                ;;
            "4")
                break
                ;;
            *)
                break
                ;;
        esac
    done
}

