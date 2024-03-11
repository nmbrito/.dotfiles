# Prerequisites
## Init functions
    . /etc/os-release
    . functions.sh

    functionDefineDistro

## Global variables
    navidrome_urlrelease="https://api.github.com/repos/navidrome/navidrome/releases/latest"
    navidrome_ug="navidrome"
    navidrome_opt="/opt/navidrome"
    navidrome_var="/var/lib/navidrome"
    navidrome_service="/etc/systemd/system/"
    navidrome_musicpath=""

## Update repository list
    "${pkgmgr}" update

## Upgrade system
    "${pkgmgr}" apt upgrade

## Install necessary packages
    "${pkginst}" ffmpeg curl

# Directory Structure
    adduser ${navidrome_ug}

    install -d -o "${navidrome_ug}" -g "${navidrome_ug}" ${navidrome_opt}
    install -d -o "${navidrome_ug}" -g "${navidrome_ug}" ${navidrome_var}

    mkdir -p "/home/${navidrome_ug}"/.cache

# Download and extract navidrome
    curl -L $(curl -s "${navidrome_urlrelease}" | grep browser_download_url | cut -d '"' -f 4 | grep "Linux_x86_64.tar.gz") --output "/home/${navidrome_ug}/.cache/Navidrome.tar.gz"

    tar -xvzf Navidrome.tar.gz -C "${navidrome_opt}"

    rm "/home/${navidrome_ug}/.cache/Navidrome.tar.gz"

# Configuration file
    cp -rv ./configs/navidrome.toml ${navidrome_var}

    if [ -z "${navidrome_musicpath}" ] ; then
        printf '%s' "Specify music directory: "
        read -r navidrome_musicpath
    fi

    ln -vsf ${navidrome_musicpath} ${navidrome_var}/music_library

# Systemd Unit
    cp -rv ./configs/navidrome.service ${navidrome_service}

# Starting navidrome service
    systemctl daemon-reload
    systemctl start navidrome.service
    systemctl status navidrome.service

# Enable startup
    systemctl enable navidrome.service
