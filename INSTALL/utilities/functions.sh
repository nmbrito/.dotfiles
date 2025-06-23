#!/bin/sh

functionSystemPrintMessage()
{
    case "${1}" in
        "privilegeRoot")
            case "${2}" in
                "implementRepositories") printf '%s\n' "Repositories"  ;;
                "rollFixes")             printf '%s\n' "Computer Fixes";;
                "installPackages")       printf '%s\n' "Packages"      ;;
            esac

            printf '%s\n' "${messageLongDash}"                                      \
                          ""                                                        \
                          "${messageLongWarn} ${messageExecRoot} ${messageLongWarn}"\
                          ""
        ;;
        "privilegeUser")
            case "${2}" in
                "getFonts")              printf '%s\n' "Fonts"                    ;;
                "performSymlinks")       printf '%s\n' "Symlinking"               ;;
                "configureGitConfig")    printf '%s\n' "Git globals configuration";;
                "syncGitSubmodules")     printf '%s\n' "Syncing git submodules"   ;;
                "rollZSHShell")          printf '%s\n' "Changing shell to ZSH"    ;;
                "rebuildGitSubmodules")  printf '%s\n' "Rebuilding git submodules";;
                "restoreKDE")            printf '%s\n' "Restoring KDE settings"   ;;
                "restoreMacOS")          printf '%s\n' "Restoring macOS settings" ;;
                "prepareVirtualMachine") printf '%s\n' "Preparing Virtual Machine";;
            esac

            printf '%s\n' "${messageLongDash}"\
                          ""
        ;;
        "printSleep")
            printf '%s\n' ""
            sleep 3s
        ;;
    esac
}

functionSystemBuildMenu()
{
    printf '%s'   "                                                             " \
                  "-------------------------------------------------------------" \
                  " Select an option:                                           " \
                  "-------------------------------------------------------------" \
                  "  (1) Run all                 |  (6)  Symlinks               " \
                  "  (2) Repositories            |  (7)  Configure git globals  " \
                  "  (3) Packages                |  (8)  Sync git submodules    " \
                  "  (4) Fixes                   |  (9)  Change to zsh shell    " \
                  "  (5) Fonts                   |  (10) Restore KDE Theme      " \
                  "                                                             " \
                  "  (r) rebuild git submodules                                 " \
                  "-------------------------------------------------------------" \
                  " Information:                                                " \
                  "-------------------------------------------------------------" \
                  "  Host: $currentHost                                         " \
                  "                                                             " \
                  "  Distribution: "$ID"                                        " \
                  "  Package Manager: "$packageManager"                         " \
                  "  Package Install Command: "$packageInstall"                 " \
                  "                                                             " \
                  "  Current shell: "$SHELL"                                    " \
                  "                                                             " \
                  "  Pwd: $(pwd)                                                " \
                  "                                                             " \
                  "  Directories:                                               " \
                  "      Repository / .dotfiles: "$pathDotRoot"                 " \
                  "      Cache: "$pathCache"                                    " \
                  "      Script: "$pathCache"                                   " \
                  "      Cache: "$pathCache"                                    " \
                  "-------------------------------------------------------------" \
                  "  ( ) exit / cancel                                          " \
                  "-------------------------------------------------------------"
}

functionSystemDefineDistro() 
{
    # Flatpak universal
    . ${pathUtilities}/defineFlatpak.sh

    # Distribuitions have different package managers
    case "${ID}" in
        "almalinux")           . ${pathUtilities}/defineAlmaLinux.sh         ;;
        "alpine")              . ${pathUtilities}/defineAlpine.sh            ;;
        "archlinux")           . ${pathUtilities}/defineArchLinux.sh         ;;
        "debian")              . ${pathUtilities}/defineDebian.sh            ;;
        "macOS")               . ${pathUtilities}/defineMacOS.sh             ;;
        "opensuse-tumbleweed") . ${pathUtilities}/defineOpenSUSETumbleweed.sh;;
        *)
            printf '%s\n' "This script doesn't support distribuition: "${ID}""\
                          "Exiting."

            exit 0
        ;;
    esac
}

functionSystemDefineHost()
{
    if   [ -d ${pathSysDevDMI} ]; then currentHost="${catSysDevBoardVendor} ${catSysDevProdVendor} - ${catSysDevProdName}"; # Physical machine
    elif [ -d ${pathSWVers} ]   ; then currentHost="$(sysctl hw.model)"                                                   ; # Apple macOS devices
    elif [ -d ${pathiSH} ]      ; then currentHost="iOS/iPadOS"                                                           ; # iSH.app on iOS and iPadOS
    elif [ ${wslSession} ]      ; then currentHost="Windows Subsystem for Linux"                                          ; # WSL1 and WSL2 sessions
    else
        currentHost="None"
    fi

    # Known Hosts
    #   Thinkpad x230              - LENOVO ThinkPad X230 - 23252FG
    #   Proxmox Virtual Machine    - pc-i440fx-9.2 - Standard PC (i440FX + PIIX, 1996)
    #   Macbook Pro Mid 2012 Linux - Apple Inc. 1.0 - MacBookPro9,2
    #   Macbook Pro Mid 2012 MacOS - MacBook9,2
    #   iPhone 13                  - iOS/iPadOS
    #   iPad Pro M2                - iOS/iPadOS
    #   Windows Terminal WSL2      - Windows Subsystem for Linux
}

functionImplementRepositories()
{
    functionSystemPrintMessage privilegeRoot implementRepositories

    if [ ${1} != "None" ]; then
        for eachGPGKeys    in ${List_of_GPGKeys}     ; do ${repoImport} ${eachGPGKeys}; done
        for eachRepository in ${List_of_Repositories}; do ${repoAdd} ${eachRepository}; done

        ${repoRefresh}
        ${repoAutoGPGKeys}
    else
        printf '%s\n' "No repository to add."
    fi

    functionSystemPrintMessage printSleep
}

functionRollFixes() 
{
    functionSystemPrintMessage privilegeRoot rollFixes

    # Hardware layer
    case "${currentHost}" in
        "LENOVO ThinkPad X230 - 23252FG") su -c "$packageInstallAuto ${List_of_x230}"                                                    ;;
        "Apple Inc. 1.0 - MacBookPro9,2") su -c "$packageInstallAuto ${List_of_MacbookProMid2012}"                                       ;;
        "MacBookPro9,2")                  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";;
        *) 
            printf '%s\n' "Hardware running smoothly"
        ;;
    esac

    # Operating system layer
    case "${distroName}" in
        "Debian") ln -s $(which fdfind) "${HOME}/.local/bin/fd";;
        *)
            printf '%s\n' "Operating system running smoothly"
        ;;
    esac

    functionSystemPrintMessage printSleep
}

functionInstallPackages()
{
    functionSystemPrintMessage privilegeRoot installPackages

	case "${currentHost}" in
		"LENOVO ThinkPad X230 - 23252FG" | "Apple Inc. 1.0 - MacBookPro9,2" | "pc-i440fx-9.2 - Standard PC (i440FX + PIIX, 1996)")
			case "${XDG_SESSION_DESKTOP}" in
                "KDE")
                    su -c "$packageInstallAuto $List_of_KDEBasics     \
                                               $List_of_KDEPersonal   \
                                               $List_of_KDEFortiClient\
                                               $List_of_Terminal      \
                                               $List_of_Developer"

                    su -c "$flatpakInstall     $List_of_Flatpaks"
                    ;;
                *)  ;;
            esac
        ;;
        "Windows Subsystem for Linux")
            su -c "$packageInstallAuto    $List_of_Terminal \
                                          $List_of_Developer"

            if [ $packageInstallPattern != "" ]; then su -c $packageInstallPattern $List_of_WSLPattern; fi
            ;;
		"iOS/iPadOS") $packageInstall $List_of_iSH;;
		"MacBook9,2") $packageInstall --file=${pathUtilities}/packagesBrewfile;;
		*)
			#case "${XDG_SESSION_DESKTOP}" in
            #    "KDE") ;;
            #    *) ;;
            #esac
            ;;
	esac

    # XDG_SESSION_DESKTOP
    #   KDE Gnome Hyprland XFCE

    functionSystemPrintMessage printSleep
}

functionGetFonts()
{
    functionSystemPrintMessage privilegeUser getFonts

    if [ ! -d ${HOME}/.fonts ]; then mkdir -p ${HOME}/.fonts; fi
    if [ ! -d $pathCache ]    ; then mkdir -p $pathCache    ; fi

    if [ $(curl -is $urlNerdFonts | head -n 1) = "HTTP/2 404" ]; then
        for eachFont in $(ls ${pathDotRoot}/INSTALL/fonts/*.tar.xz); do
            tar -xvf ${pathDotRoot}/INSTALL/fonts/${eachFont} --directory ${HOME}/.fonts
        done
    else
        for eachFont in $List_of_Fonts; do
            curl -L $(curl -s $urlNerdFonts | grep browser_download_url | cut -d '"' -f 4 | grep ${eachFont}) --output ${pathCache}/${eachFont}
            tar -xvf ${pathCache}/${eachFont} --directory ${HOME}/.fonts
            rm ${pathCache}/${eachFont}
        done
    fi

    rm ${HOME}/.fonts/LICENSE*
    rm ${HOME}/.fonts/README*
    rm ${HOME}/.fonts/OFL*

    functionSystemPrintMessage printSleep
}

functionPerformSymlinks()
{
    functionSystemPrintMessage privilegeUser performSymlinks

    [ ! -d ${HOME}/.config/ ] && mkdir ${HOME}/.config/

    for eachSymlinkDir in $List_of_SymlinksDirRem; do [ -d $eachSymlinkDir ] && rm -rf $eachSymlinkDir; done
    for eachSymlink    in $List_of_Symlinks      ; do ln -vsf $eachSymlink                            ; done

    functionSystemPrintMessage printsleep
}

functionConfigureGitGlobals()
{
    functionSystemPrintMessage privilegeUser configureGitConfig

    printf '%s'   "user.email: "
    read -r git_user_email
    printf '%s\n' ""
    git config --global user.email $git_user_email

    printf '%s\n' ""

    printf '%s'   "user.name: "
    read -r git_user_name
    printf '%s\n' ""
    git config --global user.name $git_user_name

    functionSystemPrintMessage printSleep
}

functionSyncGitSubmodules()
{
    functionSystemPrintMessage privilegeUser syncGitSubmodules

    # A repository with submodules already added must be initiated.
    (cd $pathDotRoot && git submodule update --init --recursive) && printf '%s\n' "" "Submodules updated" ""

    functionSystemPrintMessage printsleep
}

functionRollZSHShell() 
{
    functionSystemPrintMessage privilegeUser rollZSHShell

    printf '%s\n' "Current shell: $SHELL"

    if [ $SHELL != "$zshBinPath" ]; then
        if [ ! -f $zshSharePath ]; then
            if [ $currentHost = "iOS/iPadOS" ]; then sed -i 's/ash/zsh/g' /etc/passwd && printf '%s\n' "Replaced ash with zsh."
            else
                chsh -s $(which zsh) && printf '%s\n' "Shell changed to ZSH." || printf '%s\n' "ERROR: Shell not changed."
            fi
        else
            printf '%s\n' "ZSH missing. Want to install? [y/n]: "
            read -r optionZSHChange
            if [ $optionZSHChange = "y" ]; then
                (su -c "$packageInstallAuto zsh")
                functionRollZSHShell
            fi
        fi
    else
        printf '%s\n' "ZSH already running."
    fi

    functionSystemPrintMessage printSleep
}

functionRebuildGitSubmodules() 
{
    functionSystemPrintMessage privilegeUser rebuildGitSubmodules

    previousWorkingDir="$(pwd)"

    # NOTE: submodule path is relative to root repository.
    cd $pathDotRoot && for eachGitSubmodule in $List_of_Submodules; do git submodule add $eachGitSubmodule; done

    cd $previousWorkingDir

    functionSystemPrintMessage printSleep
}

functionRestoreKDEThemes()
{
    functionSystemPrintMessage privilegeUser restoreKDE

    for eachKDEConfig in ${List_of_RestoreKDE}; do
        [ -d ${pathKDEThemes}/${eachKDEConfig} ]      && rm -rf ${pathKDEThemes}/${eachKDEConfig}
        cp -rv ${pathDotRoot}/kde_backup/share/${eachKDEConfig} ${pathKDEThemes}/${eachKDEConfig}
    done

    # Restore kglobalshortcutsrc from each host

    [ -d "${HOME}/.icons" ]                 && rm -rf ${HOME}/.icons
    cp -rv ${pathDotRoot}/kde_backup/.icons           ${HOME}/.icons

    functionSystemPrintMessage printSleep
}

functionRestoreMacOS()
{
    functionSystemPrintMessage privilegeUser restoreMacOS

    for eachMacOSConfig in $List_of_RestoreMacOS; do [ -d ${pathMacOSAppSupport}/${eachMacOSConfig} ] && rm -rf "${pathMacOSAppSupport}/${eachMacOSConfig}"; done
    
    cp -rv ${pathDotRoot}/.config/tgpro/Preferences/com.tunabellysoftware.tgpro.plist ${pathMacOSPreference}/com.tunabellysoftware.tgpro.plist

    functionSystemPrintMessage printSleep
}

#functionPrepareVirtualMachine()
#{
#    functionSystemPrintMessage privilegeRoot prepareVirtualMachine
#
#    case "${distroName}" in
#        "debian")
#            printf '%s\n' "Reconfiguring SSH Keys"
#            (su -c "
#                rm -fv /etc/ssh/ssh_host_*
#                dpkg-reconfigure openssh-server
#                systemctl restart ssh
#            ")
#
#            printf '%s\n' "Cleaning packages"
#            (su -c "
#                ${packageManager} autoclean
#                ${packageManager} clean
#                ${packageManager} autoremove
#            ")
#
#            printf '%s\n' "Configuring Journalctl"
#            (su -c "
#                sed -i 's@#SystemMaxUse=@SystemMaxUse=1G@g' /etc/systemd/journald.conf
#                sed -i 's@#SystemMaxFileSize=@SystemMaxFileSize=50M@g' /etc/systemd/journald.conf
#
#                journalctl --vacuum-time=2d
#                journalctl --vacuum-size=100M
#                systemctl restart systemd-journald
#            ")
#
#            printf '%s\n' "Clearing temporary folder"
#            (su -c "
#                rm -rf /tmp/.
#            ")
#            ;;
#        *)
#            printf '%s\n' "Distro not implemented yet"
#            ;;
#    esac
#
#    functionSystemPrintMessage printSleep
#}
