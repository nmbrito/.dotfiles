#!/bin/sh

# Backup themes and configurations ----------------
tar czvf ${nmb_dotrepo}/kde_config.tar.gz \
    # Folders in root
    -C ${HOME}/ .icons \
    # Folders in .local
    -C ${HOME}/.local/share/ aurorae \
    -C ${HOME}/.local/share/ color-schemes \
    -C ${HOME}/.local/share/ icons \
    -C ${HOME}/.local/share/ konsole \
    -C ${HOME}/.local/share/ kwin \
    -C ${HOME}/.local/share/ plasma \
    -C ${HOME}/.local/share/ wallpapers \
    # Folders in .config
    -C ${HOME}/.config/ kdedefaults \
    # Files in .config
    -C ${HOME}/.config/ dolphinrc \
    -C ${HOME}/.config/ gtkrc \
    -C ${HOME}/.config/ kdeglobals \
    -C ${HOME}/.config/ kglobalshortcutsrc \
    -C ${HOME}/.config/ kiorc \
    -C ${HOME}/.config/ konsolerc \
    -C ${HOME}/.config/ krunnerrc \
    -C ${HOME}/.config/ kservicemenurc \
    -C ${HOME}/.config/ ksmserverrc \
    -C ${HOME}/.config/ ksplashrc \
    -C ${HOME}/.config/ ktimezonedrc \
    -C ${HOME}/.config/ kwinrc \
    -C ${HOME}/.config/ plasma_calendar_holiday_regions \
    -C ${HOME}/.config/ plasma-localerc \
    -C ${HOME}/.config/ plasma-org.kde.plasma.desktop-appletsrc \
    -C ${HOME}/.config/ plasmashellrc \
    # Misc files in .config
    -C ${HOME}/.config/ Trolltech.conf \
    -C ${HOME}/.config/ powermanagementprofilesrc \

# Restore -----------------------------------------
tar -xzvf "${nmb_dotrepo}/kde_config.tar.gz" -C "${HOME}/.cache/kde_backup_temp"

[ -d "${HOME}/.icons" ]                            && rm -rf "${HOME}/.icons"
[ -d "${HOME}/.local/share/aurorae" ]              && rm -rf "${HOME}/.local/share/aurorae"
[ -d "${HOME}/.local/share/color-schemes" ]        && rm -rf "${HOME}/.local/share/color-schemes"
[ -d "${HOME}/.local/share/icons" ]                && rm -rf "${HOME}/.local/share/icons"
[ -d "${HOME}/.local/share/konsole" ]              && rm -rf "${HOME}/.local/share/konsole"
[ -d "${HOME}/.local/share/kwin" ]                 && rm -rf "${HOME}/.local/share/kwin"
[ -d "${HOME}/.local/share/plasma" ]               && rm -rf "${HOME}/.local/share/plasma"
[ -d "${HOME}/.local/share/wallpapers" ]           && rm -rf "${HOME}/.local/share/wallpapers"

cp -rv ".cache/kde_backup_temp/share/aurorae"                "${HOME}/.local/share/aurorae"
cp -rv ".cache/kde_backup_temp/share/color-schemes"          "${HOME}/.local/share/color-schemes"
cp -rv ".cache/kde_backup_temp/share/icons"                  "${HOME}/.local/share/icons"
cp -rv ".cache/kde_backup_temp/share/plasma/desktoptheme"    "${HOME}/.local/share/plasma/desktoptheme"
cp -rv ".cache/kde_backup_temp/share/plasma/look-and-feel"   "${HOME}/.local/share/plasma/look-and-feel"
cp -rv ".cache/kde_backup_temp/share/wallpapers"             "${HOME}/.local/share/wallpapers"
cp -rv ".cache/kde_backup_temp/.icons"                       "${HOME}/.icons"
cp -rv ".cache/kde_backup_temp/.config"                      "${HOME}/.config"

rm -rf "${HOME}/.cache"

#----------------------------------------------------------------
# Tricks
#    tar -xzfv ${nmb_dotrepo}/plasma_globalthemes.tar.gz \
#        --wildcards ${HOME}/.local/share/konsole/*.colorscheme \
