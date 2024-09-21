#!/bin/sh

# Progress status:
##  navidrome.sh    [DONE]
##  qbittorrent.sh  [DONE]
##  jellyfin.sh     [DONE]
##  nvidia.sh       [DONE]
##  netbox.sh       [TODO]
##  hardenssh.sh    [TODO]

dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

#   Vars
#   -------------------------------
    dir_dotrepo="${HOME}/.dotserver"
    dir_cache="${HOME}/.cache"

    message_longwarn="###########################################"
    message_longdash="----------------------"
    message_execroot="# The following commands will run as ROOT #"

#   Source files
    . /etc/os-release

#   Source file containing functions.
    . "${dir}"/initfunctions.sh

#   Defines the package manager and software especific to the running distribution.
    functionDefineDistro
    functionDefineHost

#   This needs to be here so it can load after the /func_def_distro/ function.
    . "${dir}"/packages.sh

    functionInstallRepository
    functionInstallSoftware
    functionInstallSymlinks
    functionInstallSubmodules
    functionConfigShell

printf '%s\n'   "#----------------------#" \
                "# Everything is ready! #" \
 
