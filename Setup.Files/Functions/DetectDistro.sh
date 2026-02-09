#!/bin/sh

function_SystemDefineDistro()
{
    # Flatpak universal
    . "${path_DistroDefines}/Flatpak.sh"

    # Distribuitions have different package managers
    case "${ID}" in
        "almalinux")
            . "${path_DistroDefines}/AlmaLinux.sh"
            ;;
        "alpine")
            . "${path_DistroDefines}/Alpine.sh"
            ;;
        "archlinux")
            . "${path_DistroDefines}/ArchLinux.sh"
            ;;
        "debian")
            . "${path_DistroDefines}/Debian.sh"
            ;;
        "macOS")
            . "${path_DistroDefines}/macOS.sh"
            ;;
        "opensuse-tumbleweed")
            . "${path_DistroDefines}/Tumbleweed.sh"
            ;;
        *)
            printf '%s\n' "This script doesn't support distribuition: $ID"
            exit 0
            ;;
    esac
}
