#!/bin/sh
# ShellCheck disable=SC2034 # Allow unused variables

if [ ! -f ${pathUtilities}/functions.sh ]                    \
    && [ ! -f ${pathUtilities}/variables.sh ]                \
    && [ ! -f ${pathUtilities}/defineAlmaLinux.sh ]          \
    && [ ! -f ${pathUtilities}/defineAlpine.sh ]             \
    && [ ! -f ${pathUtilities}/defineArchLinux.sh ]          \
    && [ ! -f ${pathUtilities}/defineDebian.sh ]             \
    && [ ! -f ${pathUtilities}/defineFlatpak.sh ]            \
    && [ ! -f ${pathUtilities}/defineMacOS.sh ]              \
    && [ ! -f ${pathUtilities}/defineOpenSUSETumbleweed.sh ] \
    && [ ! -f ${pathUtilities}/packagesLists.sh ]; then
    printf '%s\n' "Missing components. Aborting."
    exit 0
else
    . ${pathUtilities}/variables.sh     # Source file containing functions.
    . ${pathUtilities}/functions.sh     # Source file containing functions.
    functionSystemDefineDistro          # Defines the package manager and software especific to the running distribution.
    functionSystemDefineHost            # Define current host
    . ${pathUtilities}/packagesLists.sh # Sourced after functions.sh
fi

# Main
printf '%s\n' ""                   \
              "Starting process"   \
              "${messageLongDash}"

while : ; do
    functionSystemBuildMenu
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
            function_RestoreExtraconfigs
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
