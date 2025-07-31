#!/bin/sh

path_Utilities=$(CDPATH= cd -- "$(dirname -- "$0")" && cd utilities && pwd) # Directory containing all utilities

if [ ! -f "${path_Utilities}"/functions.sh ] \
    && [ ! -f "${path_Utilities}"/variables.sh ]; then
    printf '%s\n' "File: functions.sh missing. Aborting!"
    exit 0
else
    . "${path_Utilities}"/variables.sh
    . "${path_Utilities}"/functions.sh
    function_SystemAuditFile $check_Files
    function_SystemDefineDistro
    function_SystemDefineHost
    . "${path_Utilities}"/packages_Lists.sh
fi

# Main
printf '%s\n' ""                   \
              "Starting process"   \
              "${message_LongDash}"

while : ; do
    printf '%s\n' "${c_Bold}${fg_Red}This script will run certain sections with elevated privileges${c_Normal}"
    function_SystemAskForSudoPassword
    function_SystemBuildMenu
    printf '%s' "Option: "
    read -r option_Selected

    printf '%s\n' ""

    case "${option_Selected}" in
        1) 
            function_RollRepositories
            function_RollFixes
            function_RollPackages
            function_RollFonts
            function_RollSymlinks
            function_RollZSHShell
            function_ConfigureGitGlobals
            function_SyncGitSubmodules
            function_RestoreExtraConfigs
            function_RebuilGitSubmodules
            ;;
        2)
            function_RollRepositories
            ;;
        3)
            function_RollFixes
            ;;
        4)
            function_RollPackages
            ;;
        5)
            function_RollFonts
            ;;
        6)
            function_RollSymlinks
            ;;
        7)
            function_RollZSHShell
            ;;
        8)
            function_SyncGitSubmodules
            ;;
        9)
            function_ConfigureGitGlobals
            ;;
        10)
            function_RestoreExtraConfigs
            ;;
        r)
            function_RebuilGitSubmodules
            ;;
        *)
            printf '%s\n' "Exiting..." \
                          ""
            exit 0
            ;;
    esac
done

