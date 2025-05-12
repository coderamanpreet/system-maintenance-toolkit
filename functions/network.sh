
#!/bin/bash

network_diagnostic() {
    OPERATION=$(whiptail --title "Network Diagnostics" --menu "Choose operation:" 15 50 3 \
        "1" "Check Network Interfaces" \
        "2" "Check DNS Configuration" \
        "3" "Ping Test" \
        3>&1 1>&2 2>&3)

    case $OPERATION in
        1)
            INTERFACES=$(ip addr)
            whiptail --msgbox "Network Interfaces:\n$INTERFACES" 20 70
            echo "[Checked Network Interfaces] $(date)" >> "$1"
            ;;
        2)
            DNS=$(cat /etc/resolv.conf)
            whiptail --msgbox "DNS Configuration:\n$DNS" 20 70
            echo "[Checked DNS Configuration] $(date)" >> "$1"
            ;;
        3)
            HOST=$(whiptail --inputbox "Enter host to ping (e.g., google.com):" 10 60 3>&1 1>&2 2>&3)
            PING_RESULT=$(ping -c 4 "$HOST")
            whiptail --msgbox "Ping Test Result:\n$PING_RESULT" 20 70
            echo "[Ping Test to $HOST] $(date)" >> "$1"
            ;;
    esac
}
