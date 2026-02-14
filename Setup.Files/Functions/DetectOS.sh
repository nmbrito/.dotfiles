#!/bin/sh
#TODO
function_DetectOS()
{
    if [ -L /etc/os-release ]; then
        . /etc/os-release
    elif [ $(command -v sw_vers) 2>/dev/null ]; then
        ID="$(sw_vers -productName)"
    fi
    if [ -n "${WT_SESSION}" ]; then
        wsl_Session=1
    else
        wsl_Session=0
    fi
}
