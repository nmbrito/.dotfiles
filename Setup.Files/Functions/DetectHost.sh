#!/bin/sh
#TODO
function_DetectHost()
{
    if [ -d "$path_SysDevDMI" ]; then
        # Physical or Virtual machine
        current_Host="$(cat /sys/devices/virtual/dmi/id/board_vendor) $(cat /sys/devices/virtual/dmi/id/product_version) - $(cat /sys/devices/virtual/dmi/id/product_name)"
    elif [ command -v "$command_SWVers" >/dev/null 2>&1 ]; then
        # Apple macOS devices
        current_Host="$(sysctl -n hw.model)"
    elif [ -d "$path_iSH" ]; then
        # iSH.app on iOS and iPadOS
        current_Host="iOS/iPadOS"
    elif [ -n "${wsl_Session}" ]; then
        # WSL1 and WSL2 sessions
        current_Host="Windows Subsystem for Linux"
    else
        current_Host="None"
    fi

    # Known Hosts
    #   Thinkpad x230              - LENOVO ThinkPad X230 - 23252FG
    #   Thinkpad L14 G2            - LENOVO ThinkPad L14 Gen 2 - 20X1000UPG
    #   Proxmox Virtual Machine    -  pc-i440fx-9.2 - Standard PC (i440FX + PIIX, 1996)
    #   Macbook Pro Mid 2012 Linux - Apple Inc. 1.0 - MacBookPro9,2
    #   Macbook Pro Mid 2012 MacOS - MacBook9,2
    #   iPhone 13                  - iOS/iPadOS
    #   iPad Pro M2                - iOS/iPadOS
    #   Windows Terminal WSL2      - Windows Subsystem for Linux
}
