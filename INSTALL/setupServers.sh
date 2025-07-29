#!/bin/sh

path_Utilities=$(CDPATH= cd -- "$(dirname -- "$0")" && cd utilities && pwd) # Directory containing all utilities

if [ ! -f ${path_Utilities}/functions.sh ] \
    && if [ ! -f ${path_Utilities}/variables.sh ]; then
    printf '%s\n' "File: functions.sh missing. Aborting!"
    exit 0
else
    . ${pathUtilities}/variables.sh
    . ${pathUtilities}/functions.sh
    function_SystemAuditFile check_FilesServers
    function_SystemDefineDistro
    function_SystemDefineHost
    . ${pathUtilities}/packages_Lists.sh
fi

# Main
printf '%s\n' ""                   \
              "Starting process"   \
              "${message_LongDash}"

while : ; do
    functionSystemBuildMenu
    printf '%s' "Option: "
    read -r option_Selected

    printf '%s\n' ""

    case "${option_Selected}" in
        1|"navidrome") 
            ;;
        2)
            ;;
        3)
            ;;
        4)
            ;;
        5)
            ;;
        6)
            ;;
        7)
            ;;
        8)
            ;;
        9)
            ;;
        10)
            ;;
        r)
            ;;
        *)
            printf '%s\n' "Exiting..." \
                          ""
            exit 0
            ;;
    esac
done
