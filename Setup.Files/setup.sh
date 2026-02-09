#!/bin/sh

# Variables ================================================================== #
path_Script=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)                    # Run script from any directory
path_Functions=$(CDPATH= cd -- "$(dirname -- "$0")" && cd Functions && pwd) # Directory containing all utilities
path_DistroDefines=$(CDPATH= cd -- "$(dirname -- "$0")" && cd DistroDefines && pwd) # Directory containing all utilities
path_DotRoot=$(git rev-parse --show-toplevel)                               # Define .dotfiles directory
path_Cache="${HOME}/.cache"                                                 # Define .cache directory
path_KDEConfig="${HOME}/.config"
path_KDEThemes="${HOME}/.local/share"
path_MacOSAppSupport="${HOME}/Library/Application Support"
path_MacOSLibPreference="${HOME}/Library/Preferences"
path_ZSHShare="/usr/share/zsh"
path_ZSHBin="/usr/bin/zsh"
path_SysDevDMI="/sys/devices/virtual/dmi"
path_iSH="/proc/ish"

command_SWVers="/usr/bin/sw_vers"
running_DesktopEnvironment="${XDG_SESSION_DESKTOP}"

url_NerdFonts="https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest"
url_OhMyPosh="https://ohmyposh.dev/install.sh"

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

# Verify if all files exist ================================================== #
for each_Function in $(ls ${path_Functions}); do
    if [ ! -f "${path_Utilities}/${each_Function}" ]; then
        printf '%s\n' "${each_Function} file missing. Aborting."
        exit 0
    else
        . ${path_Functions}/${each_Function}
    fi
done

# ===== Start ===== #
function_PrintMessage start_Setup
function_RequestSudo

while : ; do
    function_PrintMessage build_Menu
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
