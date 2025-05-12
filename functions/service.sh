#!/bin/bash

service_manager() {
    OPERATION=$(whiptail --title "Service Manager" --menu "Choose operation:" 15 50 3 \
        "1" "Start a Service" \
        "2" "Stop a Service" \
        "3" "Restart a Service" \
        "4" "Check Service Status" \
        3>&1 1>&2 2>&3)

    case $OPERATION in
        1)
            SERVICE=$(whiptail --inputbox "Enter service name to start:" 10 60 3>&1 1>&2 2>&3)
            sudo systemctl start "$SERVICE"
            whiptail --msgbox "Service $SERVICE started." 10 50
            echo "[Started Service: $SERVICE] $(date)" >> "$1"
            ;;
        2)
            SERVICE=$(whiptail --inputbox "Enter service name to stop:" 10 60 3>&1 1>&2 2>&3)
            sudo systemctl stop "$SERVICE"
            whiptail --msgbox "Service $SERVICE stopped." 10 50
            echo "[Stopped Service: $SERVICE] $(date)" >> "$1"
            ;;
        3)
            SERVICE=$(whiptail --inputbox "Enter service name to restart:" 10 60 3>&1 1>&2 2>&3)
            sudo systemctl restart "$SERVICE"
            whiptail --msgbox "Service $SERVICE restarted." 10 50
            echo "[Restarted Service: $SERVICE] $(date)" >> "$1"
            ;;
        4)
            SERVICE=$(whiptail --inputbox "Enter service name to check status:" 10 60 3>&1 1>&2 2>&3)
            STATUS=$(systemctl status "$SERVICE")
            whiptail --msgbox "Service Status:\n$STATUS" 20 70
            echo "[Checked Status of Service: $SERVICE] $(date)" >> "$1"
            ;;
    esac
}
