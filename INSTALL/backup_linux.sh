#!/bin/sh

# Files in .config
cp -v "${HOME}/.config/kglobalshortcutsrc"                      "${path_dotrepo}/config/plasma/"    # Keyboard shortcuts
cp -v "${HOME}/.config/kwinrc"                                  "${path_dotrepo}/config/plasma/"    # Kwin effects
cp -v "${HOME}/.config/plasma-localerc"                         "${path_dotrepo}/config/plasma/"    # All locale PT
cp -v "${HOME}/.config/plasma-org.kde.plasma.desktop-appletsrc" "${path_dotrepo}/config/plasma/"    # Applets in panels
cp -v "${HOME}/.config/plasmashellrc"                           "${path_dotrepo}/config/plasma/"    #
cp -v "${HOME}/.config/powermanagementprofilesrc"               "${path_dotrepo}/config/plasma/"    # Energy profiles
cp -v "${HOME}/.config/strawberry/strawberry.conf"              "${path_dotrepo}/config/strawberry" # Strawberry

# Files in .local
cp -v "${HOME}/.local/share/konsole/mytik.profile"  "${path_dotrepo}/config_local/share/konsole/mytik.profile"  # Konsole profile

# Folders
cp -rv "${HOME}/.config/kdedefaults"                "${path_dotrepo}/config/plasma/"

# Themes
tar czvf ${path_dotrepo}/plasma_globalthemes.tar.gz \
    ${HOME}/.local/share/plasma \
    ${HOME}/.local/share/color-schemes \
    ${HOME}/.local/share/icons \
    --wildcards ${HOME}/.local/share/konsole/*.colorscheme \
    ${HOME}/.local/share/kwin \
    ${HOME}/.local/share/wallpapers \
