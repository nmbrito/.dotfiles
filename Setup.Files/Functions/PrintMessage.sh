#!/bin/sh

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
        "privilege_Root")
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
        "privilege_User")
            case "${message_Selection}" in
                "Symlinking")
                    printf '%s\n' "Symlinks"
                    ;;
            esac

            printf '%s\n' "${message_LongDash}" \
                          ""
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
