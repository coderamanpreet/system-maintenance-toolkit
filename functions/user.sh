#!/bin/bash

user_manager() {
    OPERATION=$(whiptail --title "User Manager" --menu "Choose operation:" 15 50 3 \
        "1" "Add a User" \
        "2" "Delete a User" \
        "3" "List All Users" \
        3>&1 1>&2 2>&3)

    case $OPERATION in
        1)
            USERNAME=$(whiptail --inputbox "Enter username to add:" 10 50 3>&1 1>&2 2>&3)
            if id "$USERNAME" &>/dev/null; then
                whiptail --msgbox "User $USERNAME already exists!" 10 50
            else
                sudo useradd -m "$USERNAME"
                whiptail --msgbox "User $USERNAME added." 10 50
                echo "[Added User: $USERNAME] $(date)" >> "$1"
            fi
            ;;
        2)
            USERNAME=$(whiptail --inputbox "Enter username to delete:" 10 50 3>&1 1>&2 2>&3)
            if id "$USERNAME" &>/dev/null; then
                sudo userdel -r "$USERNAME"
                whiptail --msgbox "User $USERNAME deleted." 10 50
                echo "[Deleted User: $USERNAME] $(date)" >> "$1"
            else
                whiptail --msgbox "User $USERNAME does not exist!" 10 50
            fi
            ;;
        3)
            USERS=$(awk -F: '$3>=1000 && $3!=65534 {print $1}' /etc/passwd)
            whiptail --msgbox "List of Regular Users:\n$USERS" 20 70
            echo "[Listed Users] $(date)" >> "$1"
            ;;
    esac
}
