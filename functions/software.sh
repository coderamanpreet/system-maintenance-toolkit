#!/bin/bash

software_manager() {
    OPERATION=$(whiptail --title "Software Manager" --menu "Choose operation:" 15 50 4 \
        "1" "Install a Package" \
        "2" "Remove a Package" \
        "3" "Update All Packages" \
        3>&1 1>&2 2>&3)

    case $OPERATION in
        1)
            PKG=$(whiptail --inputbox "Enter package name to install:" 10 50 3>&1 1>&2 2>&3)
            apt install -y "$PKG"
            echo "[Installed: $PKG] $(date)" >> "$1"
            ;;
        2)
            PKG=$(whiptail --inputbox "Enter package name to remove:" 10 50 3>&1 1>&2 2>&3)
            apt remove -y "$PKG"
            echo "[Removed: $PKG] $(date)" >> "$1"
            ;;
        3)
            apt update && apt upgrade -y
            echo "[System Updated] $(date)" >> "$1"
            ;;
    esac
}
