#!/bin/sh

# File: setup.sh
# Description: semi-automatic personal installer

# Init systems
# -----------------
#   Run script from any directory
    dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

#   Vars
    dir_dotroot="$(git rev-parse --show-toplevel)"
    dir_cache="${HOME}/.cache"
    url_nerdfonts="https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest"

    message_longwarn="###########################################"
    message_longdash="----------------------"
    message_execroot="# The following commands will run as ROOT #"

#   Source components
#   Linux
    if [ -L "/etc/os-release/" ] ; then
        . /etc/os-release
#   macOS
    elif [ -n "$(sw_vers)" ] ; then
        ID="$(sw_vers -productName)"
#   NULL
    else
        ID=0
    fi

    if [ ! -f "${dir}"/functions.sh ] && [ ! -f "${dir}"/packages.sh ] ; then
        printf '%s\n' "Missing install components. Aborting."
        exit 0
    fi

#   Source file containing functions.
    . "${dir}"/functions.sh

#   Defines the package manager and software especific to the running distribution.
    functionDefineDistro 

#   Define current host
    functionDefineHost

#   Source file containing software list.
#   This needs to be here so it can load after the /func_def_distro/ function.
    . "${dir}"/packages.sh

# Main
# ----
printf '%s\n'   "" \
                "Starting process" \
                "${message_longdash}" \
                "" \
                "Current distro: ${ID}"

# Call function
while :
do
    functionBuildMenu
    printf '%s' "Option: "
    read -r option_picked

    printf '%s\n' ""

    case "${option_picked}" in
        1)
            functionInstallFixes
            functionInstallRepositories
            functionInstallPackages
            functionInstallFonts
            functionInstallSymlinks
            functionConfigGitGlobals
            functionInstallGitSubmodules
            functionConfigVimHelptags
            functionConfigShell
            ;;
        2)
            functionInstallFixes ;;
        3)
            functionInstallRepositories ;;
        4)
            functionInstallPackages ;;
        5)
            functionInstallFonts ;;
        6)
            functionInstallSymlinks ;;
        7)
            functionConfigGitGlobals ;;
        8)
            functionInstallGitSubmodules ;;
        9)
            functionConfigVimHelptags ;;
        10)
            functionConfigShell ;;
        r)
            functionRebuildGitSubmodules ;;
        *)
            printf '%s\n'   "Exiting..." \
                            ""
            exit 0
            ;;
    esac
done

