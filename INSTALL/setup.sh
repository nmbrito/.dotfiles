#!/bin/sh

# Variables
pathScript=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)                    # Run script from any directory
pathUtilities=$(CDPATH= cd -- "$(dirname -- "$0")" && cd utilities && pwd) # Directory containing all utilities
pathDotRoot=$(git rev-parse --show-toplevel)                               # Define .dotfiles directory
pathCache="${HOME}/.cache"                                                 # Define .cache directory

pathKDEThemes="${HOME}/.local/share"
pathMacOSAppSupport="${HOME}/Library/Application Support"
pathMacOSLibPreference="${HOME}/Library/Preferences"

pathSysDevDMI="/sys/devices/virtual/dmi"
pathiSH="/proc/ish"
pathSWVers="/usr/bin/software_vers"

catSysDevBoardVendor=$(cat /sys/devices/virtual/dmi/id/board_vendor) 2>&1
catSysDevProdVendor=$(cat /sys/devices/virtual/dmi/id/product_version)
catSysDevProdName=$(cat /sys/devices/virtual/dmi/id/product_name)

runningDesktopEnvironment="${XDG_SESSION_DESKTOP}"
zshSharePath="/usr/share/zsh"
zshBinPath="/usr/bin/zsh"

urlNerdFonts="https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest"
urlOhMyPosh="https://ohmyposh.dev/install.sh"

messageLongWarn="###########################################"
messageLongDash="----------------------"
messageExecRoot="# The following commands will run as ROOT #"

if   [ -n ${WT_SESSION} ];                  then wslSession=1; else wslSession=0; fi  # WSL session
if   [ -L /etc/os-release ];                then . /etc/os-release                    # Linux distribution
elif [ $(command -v sw_vers) 2>/dev/null ]; then ID="$(sw_vers -productName)"; fi     # macOS

if [ ! -f ${pathUtilities}/functions.sh ]                 && \
    [ ! -f ${pathUtilities}/defineAlmaLinux.sh ]          && \
    [ ! -f ${pathUtilities}/defineAlpine.sh ]             && \
    [ ! -f ${pathUtilities}/defineArchLinux.sh ]          && \
    [ ! -f ${pathUtilities}/defineDebian.sh ]             && \
    [ ! -f ${pathUtilities}/defineFlatpak.sh ]            && \
    [ ! -f ${pathUtilities}/defineMacOS.sh ]              && \
    [ ! -f ${pathUtilities}/defineOpenSUSETumbleweed.sh ] && \
    [ ! -f ${pathUtilities}/packagesLists.sh ];           then
    printf '%s\n' "Missing components. Aborting."
    exit 0
else
    . ${pathUtilities}/functions.sh     # Source file containing functions.
    functionSystemDefineDistro          # Defines the package manager and software especific to the running distribution.
    functionSystemDefineHost            # Define current host
    . ${pathUtilities}/packagesLists.sh # Sourced after functions.sh
fi

# Main
printf '%s\n' ""                  \
              "Starting process"  \
              "${messageLongDash}"\
              ""                  \

while :
do
    functionSystemBuildMenu
    printf '%s' "Option: "
    read -r optionPicked

    printf '%s\n' ""

    case "${optionPicked}" in
        1) # Run All
            functionImplementRepositories
            functionInstallPackages
            functionRollFixes
            functionGetFonts
            functionPerformSymlinks
            functionConfigureGitGlobals
            functionSyncGitSubmodules
            functionRestoreKDEThemes
            functionRollZSHShell
            functionRebuilGitSubmodules
            ;;
        2)  functionImplementRepositories;; # Repositories
        3)  functionInstallPackages      ;; # Packages
        4)  functionRollFixes            ;; # Fixes
        5)  functionGetFonts             ;; # Fonts
        6)  functionPerformSymlinks      ;; # Symlinks
        7)  functionConfigureGitGlobals  ;; # Git Globals
        8)  functionSyncGitSubmodules    ;; # Git Submodules
        9)  functionRollZSHShell         ;; # ZSH Shell
        10) functionRestoreKDEThemes     ;; # Restore KDE Themes
        r)  functionRebuilGitSubmodules  ;; # Rebuild Git Submodules
        *)
            printf '%s\n' "Exiting..." \
                          ""
            exit 0
            ;;
    esac
done
