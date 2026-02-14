#!/bin/sh

function_RequestSudo()
{
    printf '%s' "Please input sudo password: "
    stty -echo
    read -r sudo_Password
    stty echo
    printf '%s\n' ""
}
