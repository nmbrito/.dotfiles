#!/bin/sh

# File: setup.sh
# Description: semi-automatic personal installer

# Init systems
# ------------

#   Variables
dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)    # Run script from any directory

dir_dotroot="$(git rev-parse --show-toplevel)"      # Define .dotfiles directory
dir_cache=""${HOME}"/.cache"                        # Define .cache directory

url_nerdfonts="https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest"

message_longwarn="###########################################"
message_longdash="----------------------"
message_execroot="# The following commands will run as ROOT #"

if   [ -L /etc/os-release                  ]; then . /etc/os-release;                   # Linux distribuition
elif [ command -v sw_vers > /dev/null 2>&1 ]; then ID="$(sw_vers -productName)"; fi     # macOS
if   [ -n "${WT_SESSION}"                  ]; then wslsession=1; else wslsession=0; fi  # WSL session

if [ ! -f "${dir}"/initfunctions.sh ] && [ ! -f "${dir}"/packages.sh ] ; then
    printf '%s\n' "Missing install components. Aborting."
    exit 0
else
    . "${dir}"/initfunctions.sh # Source file containing functions.
    functionDefineDistro    # Defines the package manager and software especific to the running distribution.
    functionDefineHost      # Define current host
    . "${dir}"/packages.sh  # Sourced after functions.sh
fi

# Main
# ----
printf '%s\n'   "" \
                "Starting process" \
                "${message_longdash}" \
                "" \
                "Current distro: "${ID}""

while :
do
    functionBuildMenu
    printf '%s' "Option: "
    read -r option_picked

    printf '%s\n' ""

    case "${option_picked}" in
        1)
            functionInstallRepositories
            functionInstallPackages
            functionInstallFixes
            functionInstallFonts
            functionInstallSymlinks
            functionConfigGitGlobals
            functionInstallGitSubmodules
            functionConfigVimHelptags
            functionConfigShell
            ;;
        2)  functionInstallRepositories     ;;
        3)  functionInstallPackages         ;;
        4)  functionInstallFixes            ;;
        5)  functionInstallFonts            ;;
        6)  functionInstallSymlinks         ;;
        7)  functionConfigGitGlobals        ;;
        8)  functionInstallGitSubmodules    ;;
        9)  functionConfigVimHelptags       ;;
        10) functionConfigShell             ;;
        r)  functionRebuildGitSubmodules    ;;
        *)
            printf '%s\n'   "Exiting..." \
                            ""
            exit 0
            ;;
    esac
done

