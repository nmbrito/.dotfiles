#!/bin/sh

# File: setup.sh
# Description: semi-automatic personal installer

# Init systems
# ------------

#   Variables
pathScript=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)                    # Run script from any directory
pathUtilities=$(CDPATH= cd -- "$(dirname -- "$0")" && cd utilities && pwd) # Directory containing all utilities
pathDotRoot="$(git rev-parse --show-toplevel)"                             # Define .dotfiles directory
pathCache=""${HOME}"/.cache"                                               # Define .cache directory

urlNerdFonts="https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest"

messageLongWarn="###########################################"
messageLongDash="----------------------"
messageExecRoot="# The following commands will run as ROOT #"

if   [ -L /etc/os-release                ]; then . /etc/os-release;                   # Linux distribuition
elif [ $(command -v sw_vers) 2>/dev/null ]; then ID="$(sw_vers -productName)"; fi     # macOS
if   [ -n "${WT_SESSION}"                ]; then wslsession=1; else wslsession=0; fi  # WSL session

if [ ! -f "${pathUtilities}"/functions.sh ] && [ ! -f "${pathUtilities}"/packages.sh ] ; then
    printf '%s\n' "Missing components. Aborting."
    exit 0
else
    . "${pathUtilities}"/functions.sh  # Source file containing functions.
    functionDefineDistro               # Defines the package manager and software especific to the running distribution.
    functionDefineHost                 # Define current host
    . "${pathUtilities}"/packages.sh   # Sourced after functions.sh
fi

# Main
# ----
printf '%s\n'   "" \
                "Starting process" \
                "${messageLongDash}" \
                "" \
                "Current distro: "${ID}""

while :
do
    functionBuildMenu
    printf '%s' "Option: "
    read -r option_picked

    printf '%s\n' ""

    case "${optionPicked}" in
        1)                                      # Run All
            functionInstallRepositories
            functionInstallPackages
            functionInstallFixes
            functionInstallFonts
            functionInstallSymlinks
            functionConfigGitGlobals
            functionConfigGitSubmodules
            functionConfigVimHelptags
            functionConfigShell
            ;;
        2)  functionInstallRepositories     ;;  # Repositories
        3)  functionInstallPackages         ;;  # Packages
        4)  functionInstallFixes            ;;  # Fixes
        5)  functionInstallFonts            ;;  # Fonts
        6)  functionInstallSymlinks         ;;  # Symlinks
        7)  functionConfigGitGlobals        ;;  # Git Globals
        8)  functionConfigGitSubmodules     ;;  # Git Submodules
        9)  functionConfigVimHelptags       ;;  # Vim Helptags
        10) functionConfigShell             ;;  # ZSH Shell
        r)  functionRebuildGitSubmodules    ;;  # Rebuild Git Submodules
        *)
            printf '%s\n'   "Exiting..." \
                            ""
            exit 0
            ;;
    esac
done

