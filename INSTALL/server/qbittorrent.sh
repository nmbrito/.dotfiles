#!/bin/sh

# Prerequisites
## Init functions
    . /etc/os-release
    . initfunctions.sh

    functionDefineDistro

## Global variables
    qbittorrent_ug="qbittorrent-nox"
    qbittorrent_service="/etc/systemd/system/"
    qbittorrent_config="/home/${qbittorrent_ug}/.config/qBittorrent"
    qbittorrent_downloadpath="/srv/dev-disk-by-uuid-bb0fd0fd-2f62-4d0d-ac35-19def1a87b42/Downloads/" # If not defined, script will ask for path later

## Update repository list
    "${pkgmgr}" update
    
## Upgrade system
    "${pkgmgr}" apt upgrade
    
# Install qBitTorrent-NOX
    "${pkginst}" qbittorrent-nox

# Add qBitTorrent-NOX user
    adduser ${qbittorrent_ug}

# Directory permissions
    if [ -z "${qbittorrent_downloadpath}" ] ; then
        printf '%s' "Specify download directory: "
        read -r qbittorrent_downloadpath
    fi
    
    chown -R "${qbittorrent_ug}":"${qbittorrent_ug}" "${qbittorrent_downloadpath}"
    chmod 775 -R "${qbittorrent_downloadpath}"

# Configuration files
    cp -rv ./configs/qBittorrent.conf ${qbittorrent_config}

# Systemctl Unit
    cp -rv ./configs/qbittorrent-nox.service ${qbittorrent_service}

# Starting navidrome service
    systemctl daemon-reload
    systemctl start qbittorrent-nox.service
    systemctl status qbittorrent-nox.service

# Enable startup
    systemctl enable qbittorrent-nox.service
