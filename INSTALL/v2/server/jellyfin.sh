#!/bin/sh

# Prerequisites
## Init functions
    . /etc/os-release
    . initfunctions.sh

    functionDefineDistro

## Global variables

## Update repository list
    "${pkgmgr}" update

## Upgrade system
    "${pkgmgr}" apt upgrade

## Install necessary packages
    "${pkginst}" curl

## Download and run script
    curl https://repo.jellyfin.org/install-debuntu.sh | sudo bash

## Additional packages
    "${pkginst}" jellyfin-ffmpeg5
