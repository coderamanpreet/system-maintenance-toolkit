#!/bin/bash

# Service Manager Function
service_manager() {
    LOGFILE="$1"

    # Display Menu
    OPERATION=$(whiptail --title "Service Manager" --menu "Choose operation:" 15 50 4 \
        "1" "Start a Service" \
        "2" "Stop a Service" \
        "3" "Restart a Service" \
        "4" "Check Service Status" \
        3>&1 1>&2 2>&3)

    case $OPERATION in
        1)
            SERVICE=$(whiptail --inputbox "Enter service name to start:" 10 60 3>&1 1>&2 2>&3)

            # Check if service exists
            if ! systemctl list-unit-files | grep -qw "^$SERVICE.service"; then
                whiptail --msgbox "❌ Service '$SERVICE' does not exist." 10 60
                echo "[FAILED: Service '$SERVICE' does not exist] $(date)" >> "$LOGFILE"
                return
            fi

            # Try to start
            sudo systemctl start "$SERVICE"
            if systemctl is-active --quiet "$SERVICE"; then
                whiptail --msgbox "✅ Service '$SERVICE' started successfully." 10 60
                echo "[Started Service: $SERVICE] $(date)" >> "$LOGFILE"
            else
                whiptail --msgbox "❌ Failed to start service '$SERVICE'." 10 60
                echo "[FAILED to Start Service: $SERVICE] $(date)" >> "$LOGFILE"
            fi
            ;;
        2)
            SERVICE=$(whiptail --inputbox "Enter service name to stop:" 10 60 3>&1 1>&2 2>&3)

            if ! systemctl list-unit-files | grep -qw "^$SERVICE.service"; then
                whiptail --msgbox "❌ Service '$SERVICE' does not exist." 10 60
                echo "[FAILED: Service '$SERVICE' does not exist] $(date)" >> "$LOGFILE"
                return
            fi

            sudo systemctl stop "$SERVICE"
            if ! systemctl is-active --quiet "$SERVICE"; then
                whiptail --msgbox "✅ Service '$SERVICE' stopped successfully." 10 60
                echo "[Stopped Service: $SERVICE] $(date)" >> "$LOGFILE"
            else
                whiptail --msgbox "❌ Failed to stop service '$SERVICE'." 10 60
                echo "[FAILED to Stop Service: $SERVICE] $(date)" >> "$LOGFILE"
            fi
            ;;
        3)
            SERVICE=$(whiptail --inputbox "Enter service name to restart:" 10 60 3>&1 1>&2 2>&3)

            if ! systemctl list-unit-files | grep -qw "^$SERVICE.service"; then
                whiptail --msgbox "❌ Service '$SERVICE' does not exist." 10 60
                echo "[FAILED: Service '$SERVICE' does not exist] $(date)" >> "$LOGFILE"
                return
            fi

            sudo systemctl restart "$SERVICE"
            if systemctl is-active --quiet "$SERVICE"; then
                whiptail --msgbox "✅ Service '$SERVICE' restarted successfully." 10 60
                echo "[Restarted Service: $SERVICE] $(date)" >> "$LOGFILE"
            else
                whiptail --msgbox "❌ Failed to restart service '$SERVICE'." 10 60
                echo "[FAILED to Restart Service: $SERVICE] $(date)" >> "$LOGFILE"
            fi
            ;;
        4)
            SERVICE=$(whiptail --inputbox "Enter service name to check status:" 10 60 3>&1 1>&2 2>&3)

            if ! systemctl list-unit-files | grep -qw "^$SERVICE.service"; then
                whiptail --msgbox "❌ Service '$SERVICE' does not exist." 10 60
                echo "[FAILED: Service '$SERVICE' does not exist] $(date)" >> "$LOGFILE"
                return
            fi

            STATUS=$(systemctl status "$SERVICE" 2>&1)
            whiptail --msgbox "Service Status:\n\n$STATUS" 20 70
            echo "[Checked Status of Service: $SERVICE] $(date)" >> "$LOGFILE"
            ;;
    esac
}



