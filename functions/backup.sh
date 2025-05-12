#!/bin/bash

backup_utility() {
    FOLDER=$(whiptail --inputbox "Enter folder path to backup:" 10 60 3>&1 1>&2 2>&3)
    OUTPUT=$(whiptail --inputbox "Enter backup filename (no .tar.gz):" 10 60 3>&1 1>&2 2>&3)
    tar -czf "$OUTPUT.tar.gz" "$FOLDER"
    whiptail --msgbox "Backup saved as $OUTPUT.tar.gz" 10 50
    echo "[Backup: $FOLDER to $OUTPUT.tar.gz] $(date)" >> "$1"
}
