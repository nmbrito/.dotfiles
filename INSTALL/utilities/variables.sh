#!/bin/sh

check_Files="\
    define_AlmaLinux.sh   \
    define_Alpine.sh      \
    define_ArchLinux.sh   \
    define_Debian.sh      \
    define_OpenSUSE_TW.sh \
    define_macOS.sh       \
    packages_Lists        \
    packages_Brewfile     \
    "

check_FilesServers="\
    packages_Servers.sh   \
    "

path_Script=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)                    # Run script from any directory
#path_Utilities=$(CDPATH= cd -- "$(dirname -- "$0")" && cd utilities && pwd) # Directory containing all utilities
path_DotRoot=$(git rev-parse --show-toplevel)                               # Define .dotfiles directory
path_Cache="${HOME}/.cache"                                                 # Define .cache directory
path_KDEThemes="${HOME}/.local/share"
path_MacOSAppSupport="${HOME}/Library/Application Support"
path_MacOSLibPreference="${HOME}/Library/Preferences"
path_ZSHShare="/usr/share/zsh"
path_ZSHBin="/usr/bin/zsh"

path_SysDevDMI="/sys/devices/virtual/dmi"
path_iSH="/proc/ish"
path_SWVers="/usr/bin/software_vers"

cat_SysDevBoardVendor=$(cat /sys/devices/virtual/dmi/id/board_vendor 2>&1) 2>&1
cat_SysDevProdVendor=$(cat /sys/devices/virtual/dmi/id/product_version 2>&1) 2>&1
cat_SysDevProdName=$(cat /sys/devices/virtual/dmi/id/product_name 2>&1) 2>&1

running_DesktopEnvironment="${XDG_SESSION_DESKTOP}"

url_NerdFonts="https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest"
url_OhMyPosh="https://ohmyposh.dev/install.sh"

message_LongWarn="###########################################"
message_LongDash="----------------------"
message_ExecRoot="${cBlink}${cBold}${fgRed}# The following commands will run as ROOT #${cNormal}"

fg_Black=$(tput setaf 0)
fg_Red=$(tput setaf 1)
fg_Green=$(tput setaf 2)
fg_Yellow=$(tput setaf 3)
fg_Blue=$(tput setaf 4)
fg_Magenta=$(tput setaf 5)
fg_Cyan=$(tput setaf 6)
fg_White=$(tput setaf 7)
bg_Black=$(tput setbf 0)
bg_Red=$(tput setbf 1)
bg_Green=$(tput setbf 2)
bg_Yellow=$(tput setbf 3)
bg_Blue=$(tput setbf 4)
bg_Magenta=$(tput setbf 5)
bg_Cyan=$(tput setbf 6)
bg_White=$(tput setbf 7)
c_Bold=$(tput bold)
c_Blink=$(tput blink)
c_Reverse=$(tput smso)
c_Underline=$(tput smul)
c_ClearScreen=$(tput clear)
c_Normal=$(tput sgr0)

if [ -n ${WT_SESSION} ]; then 
    wsl_Session=1
else
    wsl_Session=0
fi
if [ -L /etc/os-release ]; then
    . /etc/os-release
elif [ $(command -v sw_vers) 2>/dev/null ]; then
    ID="$(sw_vers -productName)"
fi
