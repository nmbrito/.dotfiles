#!/bin/sh

$date_today=$(date +%F)

mkdir -p ${nmb_dotrepo}/config/kde_plasma/backup_${date_today}/home_config/
mkdir -p ${nmb_dotrepo}/config/kde_plasma/backup_${date_today}/local_share/

cp -rv "${HOME}/.config/kdeglobals"                              "${nmb_dotrepo}/config/kde_plasma/backup_${date_today}/home_config/kdeglobals"
cp -rv "${HOME}/.config/konsolerc"                               "${nmb_dotrepo}/config/kde_plasma/backup_${date_today}/home_config/konsolerc"
cp -rv "${HOME}/.config/ksmserverrc"                             "${nmb_dotrepo}/config/kde_plasma/backup_${date_today}/home_config/ksmserverrc"
cp -rv "${HOME}/.config/ksplashrc"                               "${nmb_dotrepo}/config/kde_plasma/backup_${date_today}/home_config/ksplashrc"
cp -rv "${HOME}/.config/ktimezonedrc"                            "${nmb_dotrepo}/config/kde_plasma/backup_${date_today}/home_config/ktimezonedrc"
cp -rv "${HOME}/.config/kwinrc"                                  "${nmb_dotrepo}/config/kde_plasma/backup_${date_today}/home_config/kwinrc"
cp -rv "${HOME}/.config/plasma-localerc"                         "${nmb_dotrepo}/config/kde_plasma/backup_${date_today}/home_config/plasma-localerc"
cp -rv "${HOME}/.config/plasma-org.kde.plasma.desktop-appletsrc" "${nmb_dotrepo}/config/kde_plasma/backup_${date_today}/home_config/plasma-org.kde.plasma.desktop-appletsrc"
cp -rv "${HOME}/.config/plasmaparc"                              "${nmb_dotrepo}/config/kde_plasma/backup_${date_today}/home_config/plasmaparc"
cp -rv "${HOME}/.config/plasmarc"                                "${nmb_dotrepo}/config/kde_plasma/backup_${date_today}/home_config/plasmarc"
cp -rv "${HOME}/.config/plasmashellrc"                           "${nmb_dotrepo}/config/kde_plasma/backup_${date_today}/home_config/plasmashellrc"
cp -rv "${HOME}/.config/powerdevilrc"                            "${nmb_dotrepo}/config/kde_plasma/backup_${date_today}/home_config/powerdevilrc"

cp -rv "${HOME}/.local/share/konsole/"              "${nmb_dotrepo}/config/kde_plasma/backup_${date_today}/local_share/konsole/"
cp -rv "${HOME}/.local/share/kwin/effects/"         "${nmb_dotrepo}/config/kde_plasma/backup_${date_today}/local_share/kwin/effects/"
cp -rv "${HOME}/.local/share/plasma/look-and-feel/" "${nmb_dotrepo}/config/kde_plasma/backup_${date_today}/local_share/plasma/look-and-feel"
cp -rv "${HOME}/.local/share/plasma/plasmoids/"     "${nmb_dotrepo}/config/kde_plasma/backup_${date_today}/local_share/plasma/plasmoids"
cp -rv "${HOME}/.local/share/plasma/wallpapers/"    "${nmb_dotrepo}/config/kde_plasma/backup_${date_today}/local_share/plasma/wallpapers"
