#!/bin/sh

# Quickly sort lists with vim :'<,'>sort
# Removed:
#   neofetch

packages_terminal="\
    ${sw_btop}\
    ${sw_fd}\
    ${sw_fdzshcompletion}\
    ${sw_fzftmux}\
    ${sw_fzfzshcompletion}\
    ${sw_rgzshcompletion}\
    ${sw_vifmcolors}\
    ${sw_vimdata}\
    bat\
    eza\
    curl\
    fzf\
    htop\
    man-pages\
    mc\
    ripgrep\
    tmux\
    vifm\
    vim\
    zsh"

packages_dev="\
    ${sw_shellcheck}\
    gcc\
    gdb\
    make\
    valgrind"

packages_wsl_pattern="\
    wsl_gui\
    wsl_base\
    wsl_systemd"

packages_kde_basics="\
    keepassxc\
    myspell-pt_PT"

packages_kde_personal="\
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

packages_x230="\
    fprintd\
    fprintd-pam\
    libfprint\
    ifuse\
    NetworkManager-fortisslvpn\
    openfortivpn\
    plasma-nm5-fortisslvpn"

packages_ish="\
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

packages_fonts="\
    CascadiaCode.tar.xz\
    FiraCode.tar.xz\
    Hasklig.tar.xz\
    Lilex.tar.xz\
    JetBrainsMono.tar.xz\
    Monoid.tar.xz"

config_kde="\
    "

#    [ ! -d "${HOME}"/.config/ ]         && mkdir "${HOME}"/.config/
#    [ ! -d "${HOME}"/.config/mc ]       && mkdir "${HOME}"/.config/mc
#
#    [ -d "${HOME}"/.vim ]               && rm -rf "${HOME}"/.vim
#    [ -d "${HOME}"/.config/vifm ]       && rm -rf "${HOME}"/.config/vifm
#    [ -d "${HOME}"/.config/neofetch ]   && rm -rf "${HOME}"/.config/neofetch
#    [ -d "${HOME}"/.config/tmux ]       && rm -rf "${HOME}"/.config/tmux
#
#
#    # Files.
#    ln -vsf "${dir_dotroot}"/config/zsh/zshrc   "${HOME}"/.zshrc
#    ln -vsf "${dir_dotroot}"/config/vim/vimrc   "${HOME}"/.vimrc
#    ln -vsf "${dir_dotroot}"/config/mc/ini      "${HOME}"/.config/mc/ini
#
#    # Directories.
#    ln -vsf "${dir_dotroot}"/config/vim         "${HOME}"/.vim
#    ln -vsf "${dir_dotroot}"/config/vifm        "${HOME}"/.config/vifm
#    ln -vsf "${dir_dotroot}"/config/neofetch    "${HOME}"/.config/neofetch
#    ln -vsf "${dir_dotroot}"/config/tmux        "${HOME}"/.config/tmux
#    ln -vsf "${dir_dotroot}"/config/fd          "${HOME}"/.config/fd
#
#    # If KDE is detected as current session.
#    if [ "${XDG_SESSION_DESKTOP}" = "KDE" ]
#    then
#        for kde_configs in $kde_config_list
#        do
#            cp -v "${dir_dotroot}"/config/${kde_configs}    "${HOME}"/.config/
#        done
#        # KDE configuration files must be copied.
#        # KDE is unable to save settings with symlinks.
#        [ -d "${HOME}"/.config/kdedefaults ] && rm -rf "${HOME}"/.config/kdedefaults
#
#        cp -v "${dir_dotroot}"/config/plasma/kglobalshortcutsrc                     	"${HOME}"/.config/
#        cp -v "${dir_dotroot}"/config/plasma/kwinrc                                 	"${HOME}"/.config/
#        cp -v "${dir_dotroot}"/config/plasma/plasma-localerc                            "${HOME}"/.config/
#        cp -v "${dir_dotroot}"/config/plasma/plasma-org.kde.plasma.desktop-appletsrc	"${HOME}"/.config/
#        cp -v "${dir_dotroot}"/config/plasma/plasmashellrc                          	"${HOME}"/.config/
#        cp -v "${dir_dotroot}"/config/plasma/powermanagementprofilesrc                  "${HOME}"/.config/
#        cp -v "${dir_dotroot}"/config/strawberry/strawberry.conf                        "${HOME}"/.config/strawberry
#
#        cp -v "${dir_dotroot}"/config_local/share/konsole/mytik.profile             	"${HOME}"/.local/share/konsole/
#        cp -v "${dir_dotroot}"/config_local/share/konsole/Edna.colorscheme             	"${HOME}"/.local/share/konsole/
#
#        cp -v "${dir_dotroot}"/config/plasma/new/konsolerc                              "${HOME}"/.config/
#        cp -v "${dir_dotroot}"/config/plasma/new/dolphinrc                              "${HOME}"/.config/
#        cp -v "${dir_dotroot}"/config/plasma/new/kdeglobals                             "${HOME}"/.config/
#        cp -v "${dir_dotroot}"/config/plasma/new/kmixrc                                 "${HOME}"/.config/
#        cp -v "${dir_dotroot}"/config/plasma/new/ksplashrc                              "${HOME}"/.config/
#        cp -v "${dir_dotroot}"/config/plasma/new/ktimezonedrc                           "${HOME}"/.config/
#
#        cp -rv "${dir_dotroot}"/config/plasma/kdedefaults                               "${HOME}"/.config/
#    fi
