#!/bin/bash

disk_usage_monitor() {
    TEMP=$(mktemp)
    {
        echo "Disk Usage (df -h):"
        df -h
        echo
        echo "Memory Usage (free -h):"
        free -h
    } > "$TEMP"

    whiptail --textbox "$TEMP" 20 70
    echo "[Disk Usage Checked] $(date)" >> "$1"
    rm "$TEMP"
}
