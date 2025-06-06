#!/bin/bash

LOG_FILE="./logs/maintenance_toolkit.log"

mkdir -p ./logs
touch "$LOG_FILE"

if [[ $EUID -ne 0 ]]; then
    whiptail --msgbox "This tool must be run as root!" 10 40
    exit 1
fi

source ./functions/disk.sh
source ./functions/process.sh
source ./functions/software.sh
source ./functions/backup.sh
source ./functions/user.sh
source ./functions/network.sh
source ./functions/service.sh

while true; do
    CHOICE=$(whiptail --title "System Maintenance Toolkit" --menu "Choose an option:" 20 60 8 \
        "1" "Disk Usage Monitor" \
        "2" "Process Manager" \
        "3" "Software Installer/Updater" \
        "4" "Backup Utility" \
        "5" "User Manager" \
        "6" "Network Diagnostic" \
        "7" "Service Manager" \
        "8" "Exit" \
        3>&1 1>&2 2>&3)

    case $CHOICE in
        1) disk_usage_monitor "$LOG_FILE" ;;
        2) process_manager "$LOG_FILE" ;;
        3) software_manager "$LOG_FILE" ;;
        4) backup_utility "$LOG_FILE" ;;
        5) user_manager "$LOG_FILE" ;;
        6) network_diagnostic "$LOG_FILE" ;;
        7) service_manager "$LOG_FILE" ;;
        8) break ;;
    esac
done

clear

