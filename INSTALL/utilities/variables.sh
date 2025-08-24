#!/bin/sh

check_Files="\
    define_AlmaLinux.sh \
    define_Alpine.sh \
    define_ArchLinux.sh \
    define_Debian.sh \
    define_OpenSUSE_TW.sh \
    define_macOS.sh \
    packages_Lists \
    packages_Brewfile \
    "

check_FilesServers="\
    packages_Servers.sh   \
    "

path_Script=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)                    # Run script from any directory
#path_Utilities=$(CDPATH= cd -- "$(dirname -- "$0")" && cd utilities && pwd) # Directory containing all utilities
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

message_LongWarn="###########################################"
message_LongDash="----------------------"
message_ExecRoot="${c_Blink}${c_Bold}${fg_Red}# The following commands will run as ROOT #${c_Normal}"

fg_Black=$(tput setaf 0)
fg_Red=$(tput setaf 1)
fg_Green=$(tput setaf 2)
fg_Yellow=$(tput setaf 3)
fg_Blue=$(tput setaf 4)
fg_Magenta=$(tput setaf 5)
fg_Cyan=$(tput setaf 6)
fg_White=$(tput setaf 7)
c_Bold=$(tput bold)
c_Blink=$(tput blink)
c_Reverse=$(tput smso)
c_Underline=$(tput smul)
c_ClearScreen=$(tput clear)
c_Normal=$(tput sgr0)

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
