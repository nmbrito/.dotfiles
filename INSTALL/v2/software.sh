#!/bin/sh

# File: cli_software.sh
# Description: software list for cli_install

# Lists:
#   list_terminal (aka common)
#   list_kde_basics
#   list_kde_personal
#   list_x230

# Quickly sort lists with vim :'<,'>sort

list_terminal="\
    ${sw_btop}\
    ${sw_fd}\
    ${sw_fdzshcompletion}\
    ${sw_fzftmux}\
    ${sw_fzfzshcompletion}\
    ${sw_shellcheck}\
    ${sw_vifmcolors}\
    ${sw_vimdata}\
    bat\
    curl\
    fzf\
    gcc\
    gdb\
    htop\
    neofetch\
    nnn\
    ripgrep-zsh-completion\
    ripgrep\
    tmux\
    valgrind\
    vifm\
    vim\
    zsh"

list_wsl_pattern="\
    wsl_gui\
    wsl_base\
    wsl_systemd"

list_kde_basics="\
    keepassxc\
    myspell-pt_PT"

list_kde_personal="\
    blender\
    code\
    discord\
    ffmpeg-6\
    gimp\
    godot\
    inkscape\
    kdenlive\
    kicad\
    kid3\
    krita\
    kvantum-manager\
    qbittorrent\
    strawberry\
    telegram-desktop\
    virt-manager\
    vlc"

list_x230="\
    ifuse\
    NetworkManager-fortisslvpn\
    openfortivpn\
    plasma-nm5-fortisslvpn"

list_ish="\
    build-base\
    gcc\
    gdb\
    git-doc\
    less-doc\
    less\
    man-pages\
    openssh\
    vifm-colors --force-overwrite\
    zsh-vcs"

list_fonts="\
    CascadiaCode.tar.xz\
    FiraCode.tar.xz\
    Hasklig.tar.xz\
    Lilex.tar.xz\
    Monoid.tar.xz"

