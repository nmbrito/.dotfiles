#!/bin/sh

# Variables ================================================================== #
path_Script=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)                    # Run script from any directory
path_Functions=$(CDPATH= cd -- "$(dirname -- "$0")" && cd Functions && pwd) # Directory containing all utilities

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

# Functions ================================================================== #
#XXX: OK
function_DetectOS()
{
    # Linux: check if symlink to os-release exists and source it
    if [ -L /etc/os-release ]; then
        . /etc/os-release

    # macOS: check if "sw_vers" command is valid and get product name
    elif [ $(command -v sw_vers) 2>/dev/null ]; then
        ID="$(sw_vers -productName)"
    fi

    # Windows Subsystem for Linux: check if "WT_SESSION" environment variable exists and set a custom variable
    if [ -n "${WT_SESSION}" ]; then
        wsl_Session=1
    else
        wsl_Session=0
    fi
}

#XXX: OK
function_DetectHost()
{
    # Computer or virtual machine
    if [ -d "$path_SysDevDMI" ]; then
        current_Host="$(cat /sys/devices/virtual/dmi/id/board_vendor) $(cat /sys/devices/virtual/dmi/id/product_version) - $(cat /sys/devices/virtual/dmi/id/product_name)"
    # Apple macOS hardware

    elif [ command -v "$command_SWVers" >/dev/null 2>&1 ]; then
        current_Host="$(sysctl -n hw.model)"

    # Apple iOS and iPadOS with iSH.app
    elif [ -d "$path_iSH" ]; then
        current_Host="iOS/iPadOS"

    # Windows Subsystem for Linux sessions
    elif [ -n "${wsl_Session}" ]; then
        # WSL1 and WSL2 sessions
        current_Host="Windows Subsystem for Linux"
    else
        current_Host="None"
    fi

    # Known Hosts
    #   Thinkpad x230              - LENOVO ThinkPad X230 - 23252FG
    #   Thinkpad L14 G2            - LENOVO ThinkPad L14 Gen 2 - 20X1000UPG
    #   Proxmox Virtual Machine    -  pc-i440fx-9.2 - Standard PC (i440FX + PIIX, 1996)
    #   Macbook Pro Mid 2012 Linux - Apple Inc. 1.0 - MacBookPro9,2
    #   Macbook Pro Mid 2012 MacOS - MacBook9,2
    #   iPhone 13                  - iOS/iPadOS
    #   iPad Pro M2                - iOS/iPadOS
    #   Windows Terminal WSL2      - Windows Subsystem for Linux
}

function_PrintMessage()
{
    # Arguments
    local message_Type="${1}"
    local message_Selection="${2}"

    # Colors
    local foreground_Black="$(tput setaf 0)"
    local foreground_Red="$(tput setaf 1)"
    local foreground_Green="$(tput setaf 2)"
    local foreground_Yellow="$(tput setaf 3)"
    local foreground_Blue="$(tput setaf 4)"
    local foreground_Magenta="$(tput setaf 5)"
    local foreground_Cyan="$(tput setaf 6)"
    local foreground_White="$(tput setaf 7)"
    local text_Bold="$(tput bold)"
    local text_Blink="$(tput blink)"
    local text_Reverse="$(tput smso)"
    local text_Underline="$(tput smul)"
    local text_ClearScreen="$(tput clear)"
    local text_Normal="$(tput sgr0)"

    # Constant text
    local message_LongHash="#############################################"
    local message_LongDash="----------------------"
    local message_ExecuteAsRoot="${text_Blink}${text_Bold}${foreground_Red}## The following commands will run as ROOT ##${text_Normal}"

    case "${message_Type}" in
        "owner_Root")
            case "${message_Selection}" in
                "Add_Repositories")
                    printf '%s\n' "Repositories"
                ;;
                "Add_Fixes")
                    printf '%s\n' ""
                ;;
                "Add_Packages")
                    printf '%s\n' ""
                ;;
            esac

            printf '%s\n' \
                "${message_LongDash}" \
                "" \
                "${message_LongHash}" \
                "${message_ExecuteAsRoot}" \
                "${message_LongHash}" \
                ""
        ;;
        "owner_User")
            case "${message_Selection}" in
                "Symlinking")
                    printf '%s\n' "Symlinks"
                ;;
            esac

            printf '%s\n' "${message_LongDash}" \
                          ""
        ;;
        "sudo_Password")
            printf '%s' "Please input sudo password: "
        ;;
        "start_Setup")
            printf '%s\n' "" \
                          "Starting process" \
                          "${message_LongDash}"

            printf '%s\n' "${text_Bold}${foreground_Red}This script will run certain sections with elevated privileges${text_Normal}"
        ;;
        "build_Menu")
            sleep 3s

            if [ "${message_Selection}" = "ClearScreen" ]; then
                printf '%s' "${text_ClearScreen}"
            fi

            printf '%s\n' \
                "                                                                         " \
                "${text_Bold} Select an option:                                           " \
                " --------------------------------------------------------- ${text_Normal}" \
                "  (1) Run all                                                            " \
                "  (2) Repositories           | (7) Change to ZSH Shell                   " \
                "  (3) Fixes                  | (8) Sync Git Submodules                   " \
                "  (4) Packages               | (9) Configure Git Globals                 " \
                "  (5) Fonts                  | (10) Restore Extra Configs                " \
                "  (6) Symlinks               |                                           " \
                "                                                                         " \
                "  (r) Rebuild Git Submodules                                             " \
                "                                                                         " \
                "${text_Bold} Information:                                                " \
                " --------------------------------------------------------- ${text_Normal}" \
                "  Host: $current_Host                                                    " \
                "                                                                         " \
                "  Distribution: $ID                                                      " \
                "  Package Manager: $package_Manager                                      " \
                "  Package Install Command: $package_Install                              " \
                "                                                                         " \
                "  Current shell: $SHELL                                                  " \
                "                                                                         " \
                "  Current Working Directory: $(pwd)                                      " \
                "                                                                         " \
                "  Directories:                                                           " \
                "      Repository: $path_DotRoot                                          " \
                "      Cache:      $path_Cache                                            " \
                "      Script:     $path_Script                                           " \
                "      Functions:  $path_Functions                                        " \
                "${text_Bold} ---------------------------------------------------------   " \
                "  ( ) exit / cancel                                                      " \
                " ---------------------------------------------------------${text_Normal} " \
                ""
        ;;
        *)
            printf '%s\n' "Message Error!"
        ;;
    esac
}

#XXX: OK
function_RequestSudo()
{
    function_PrintMessage owner_User sudo_Password
    stty -echo
    read -r sudo_Password
    stty echo
    printf '%s\n' ""
}

#XXX: OK
function_DefineDistro()
{
    # Flatpak
    . "${path_DistroDefines}/Flatpak.sh"

    # Distribuitions specific package managers
    case "${ID}" in
        "almalinux")
            . "${path_DistroDefines}/AlmaLinux.sh"
        ;;
        "alpine")
            . "${path_DistroDefines}/Alpine.sh"
        ;;
        "archlinux")
            . "${path_DistroDefines}/ArchLinux.sh"
        ;;
        "debian")
            . "${path_DistroDefines}/Debian.sh"
        ;;
        "macOS")
            . "${path_DistroDefines}/macOS.sh"
        ;;
        "opensuse-tumbleweed")
            . "${path_DistroDefines}/Tumbleweed.sh"
        ;;
        *)
            printf '%s\n' "This script doesn't support distribuition: $ID"
            exit 0
        ;;
    esac
}

#TODO
function_AddRepositories()
{
    function_PrintMessage owner_Root Add_Repositories

    for eachGPGKeys in ${List_of_GPGKeys}; do
        printf '%s\n' "$sudo_Password" | sudo -S ${SHELL} -c "$repo_Import $eachGPGKeys"
    done
    local IFS=$'\n'
    for eachRepository in ${List_of_Repositories}; do
        printf '%s\n' ${sudo_Password} | sudo -S ${SHELL} -c "$repo_Add $eachRepository"
    done

    printf '%s\n' "${sudo_Password}" | sudo -S ${SHELL} -c "$repo_AutoGPGKeys"
}

#TODO: previously "RollFixes"
function_CorrectionFixes()
{

}

#TODO: previously "RollPackages" and "InstallForAll"
function_InstallPackages()
{

}

#TODO: previously "RollFonts"
function_InstallFonts()
{

}

function_CreateSymlinks()
{
    function_PrintMessage owner_User Symlinking

    if [ ! -d "${HOME}/.config/" ]; then
        mkdir "${HOME}/.config/"
    fi

    if [ -d "${HOME}/.vim" ] || [ -L "${HOME}/.vim" ]; then
        rm -rf  "${HOME}/.vim"
    fi

    if [ -d "${HOME}/.config/fd" ] || [ -L "${HOME}/.config/fd" ]; then
        rm -rf  "${HOME}/.config/fd"
    fi

    if [ -d "${HOME}/.config/mc" ] || [ -L "${HOME}/.config/mc" ]; then
        rm -rf  "${HOME}/.config/mc"
    fi

    if [ -d "${HOME}/.config/vifm" ] || [ -L "${HOME}/.config/vifm" ]; then
        rm -rf  "${HOME}/.config/vifm"
    fi

    if [ -d "${HOME}/.config/tmux" ] || [ -L "${HOME}/.config/tmux" ]; then
        rm -rf  "${HOME}/.config/tmux"
    fi

    if [ -d "${HOME}/.config/fastfetch" ] || [ -L "${HOME}/.config/fastfetch" ]; then
        rm -rf  "${HOME}/.config/fastfetch"
    fi

    ln -vsf "${path_DotRoot}/config/mc"           "${HOME}/.config/mc"
    ln -vsf "${path_DotRoot}/config/fd"           "${HOME}/.config/fd"
    ln -vsf "${path_DotRoot}/config/tmux"         "${HOME}/.config/tmux"
    ln -vsf "${path_DotRoot}/config/vifm"         "${HOME}/.config/vifm"
    ln -vsf "${path_DotRoot}/config/vim"          "${HOME}/.vim"
    ln -vsf "${path_DotRoot}/config/vim/vimrc"    "${HOME}/.vimrc"
    ln -vsf "${path_DotRoot}/config/fastfetch"    "${HOME}/.config/fastfetch"
    ln -vsf "${path_DotRoot}/config/zsh/zshrc"    "${HOME}/.zshrc"
    ln -vsf "${path_DotRoot}/config/zsh/zprofile" "${HOME}/.zprofile"
}

#TODO: previously "RollZSHShell"
function_SwitchShellToZSH()
{

}

#TODO: previously "ConfigureGitGlobals"
function_GitStageGlobals()
{

}

#TODO: previously "SyncGitSubmodules"
function_GitSyncSubmodules()
{

}

#TODO: previously "RebuildGitSubmodules"
function_GitRebuildSubmodules()
{

}

#TODO: previously "RestoreExtraConfigs"
function_RestoreThemes()
{

}

#TODO
function_PrepareVirtualMachine()
{

}

#TODO
function_SetHostname()
{

}

#TODO
function_SetRootPassword()
{

}

# Start ====================================================================== #
function_DetectOS
function_DetectHost
function_PrintMessage
function_RequestSudo

while : ; do
    function_PrintMessage build_Menu
    printf '%s' "Option: "
    read -r option_Selected

    printf '%s\n' ""

    case "${option_Selected}" in
        1) 
            function_AddRepositories
            function_CorrectionFixes
            function_InstallPackages
            function_InstallFonts
            function_CreateSymlinks
            function_SwitchShellToZSH
            function_GitStageGlobals
            function_GitSyncSubmodules
            function_RestoreThemes
        ;;
        2)
            function_AddRepositories
        ;;
        3)
            function_CorrectionFixes
        ;;
        4)
            function_InstallPackages
        ;;
        5)
            function_InstallFonts
        ;;
        6)
            function_CreateSymlinks
        ;;
        7)
            function_SwitchShellToZSH
        ;;
        8)
            function_GitStageGlobals
        ;;
        9)
            function_GitSyncSubmodules
        ;;
        10)
            function_RestoreThemes
        ;;
        r)
            function_GitRebuildSubmodules
        ;;
        *)
            printf '%s\n' "Exiting..." \
                          ""
            exit 0
        ;;
    esac
done
