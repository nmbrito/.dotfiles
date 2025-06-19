#!/bin/sh

functionSystemPrintMessage()
{
    case "${1}" in
        "privilegeRoot")
            case "${2}" in
                "implementRepositories") printf '%s\n' "Repositories" ;;
                "rollFixes")             printf '%s\n' "Computer Fixes" ;;
                "installPackages")       printf '%s\n' "Packages" ;;

                "vmTemplateCleanUp")     printf '%s\n' "Preparing Template" ;;
            esac

            printf '%s\n' "${messageLongDash}" \
                          "" \
                          "${messageLongWarn}" "${messageExecRoot}" "${messageLongWarn}" \
                          ""
        ;;

        "privilegeUser")
            case "${2}" in
                "getFonts")          printf '%s\n' "Fonts" ;;
                "performSymlinks")   printf '%s\n' "Symlinking" ;;
                "confGitConfig")     printf '%s\n' "Git globals configuration" ;;
                "syncGitSubmodule")  printf '%s\n' "Syncing git submodules" ;;
                "rollZSHShell")      printf '%s\n' "Changing shell to ZSH" ;;
                "rebuildSubmodules") printf '%s\n' "Rebuilding git submodules" ;;
                "restoreKDE")        printf '%s\n' "Restoring KDE settings" ;;
                "restoreMacOS")      printf '%s\n' "Restoring macOS settings" ;;
            esac

            printf '%s\n' "${messageLongDash}" \
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
    printf '%s\n' "                                                             " \
                  "-------------------------------------------------------------" \
                  " Select an option:                                           " \
                  "-------------------------------------------------------------" \
                  "  (1) Run all                 |  (6)  Symlinks               " \
                  "  (2) Repositories            |  (7)  Configure git globals  " \
                  "  (3) Packages                |  (8)  Sync git submodules    " \
                  "  (4) Fixes                   |  (9)  Link vim helptags      " \
                  "  (5) Fonts                   |  (10) Change to zsh shell    " \
                  "-------------------------------------------------------------" \
                  "  ( r) rebuild git submodules                                " \
                  "-------------------------------------------------------------" \
                  "  Host: ${currentHost}                                       " \
                  "                                                             " \
                  "  Distribution: "${ID}"                                      " \
                  "  Package Manager: "${packageManager}"                       " \
                  "  Package Install Command: "${packageInstallCommand}"        " \
                  "                                                             " \
                  "  Current shell: "${SHELL}"                                  " \
                  "                                                             " \
                  "  Pwd: $(pwd)                                                " \
                  "                                                             " \
                  "  Directories:                                               " \
                  "      Repository / .dotfiles: "${pathDotRoot}"               " \
                  "      Cache: "${pathCache}"                                  " \
                  "      Script: "${pathCache}"                                 " \
                  "      Cache: "${pathCache}"                                  " \
                  "-------------------------------------------------------------" \
                  "  ( ) exit / cancel                                          " \
                  "-------------------------------------------------------------" \
                  "  $0                                                         " \
                  "-------------------------------------------------------------" \
}

functionSystemDefineDistro() 
{
	# EnvInfo
	runningDesktopEnvironment="${XDG_SESSION_DESKTOP}"
	zshInstallPath="/usr/share/zsh"
    ohmyposhInstall="curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ${HOME}/.local/bin"

    # Flatpak universal
    . ${pathUtilities}/defineFlatpak.sh

    # Distribuitions have different package managers
    case "${ID}" in
        "almalinux")           . ${pathUtilities}/defineAlmaLinux.sh ;;
        "alpine")              . ${pathUtilities}/defineAlpine.sh ;;
        "archlinux")           . ${pathUtilities}/defineArchLinux.sh ;;
        "debian")              . ${pathUtilities}/defineDebian.sh ;;
        "macOS")               . ${pathUtilities}/defineMacOS.sh ;;
        "opensuse-tumbleweed") . ${pathUtilities}/defineOpenSUSETumbleweed.sh ;;
        *)
            printf '%s\n' "This script doesn't support distribuition: "${ID}"" \
                          "Exiting."

            exit 0
            ;;
    esac
}

functionSystemDefineHost()
{
    if   [ -d ${pathSysDevDMI} ]; then currentHost="${catSysDevBoardVendor} ${catSysDevProdVendor} - ${catSysDevProdName}"; # Physical machine
    elif [ -d ${pathSWVers} ];    then currentHost="$(sysctl hw.model)";                                                    # Apple macOS devices
    elif [ -d ${pathiSH} ];       then currentHost="iOS/iPadOS";                                                            # iSH.app on iOS and iPadOS
    elif [ ${wslSession} ];       then currentHost="Windows Subsystem for Linux";                                           # WSL1 and WSL2 sessions
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

    if [ ${1} != "None" ]
        for eachGPGKeys in ${List_of_GPGKeys}
        do
            ${repoImport} ${eachGPGKeys};
        done

        for eachRepository in ${List_of_Repositories}
        do
            ${repoAdd} ${eachRepository};
        done

        ${repoRefresh}
        ${repoAutoGPGKeys} ;
    else
        printf '%s\n' "No repository to add."
    fi

    #case "${distroName}" in
    #    "openSUSE Tumbleweed")
    #        su -c "
    #            rpm --import https://packages.microsoft.com/keys/microsoft.asc ;
    #            rpm --import https://rpm.librewolf.net/pubkey.gpg ;

    #            zypper ar https://packages.microsoft.com/yumrepos/vscode vscode ;
    #            zypper ar https://rpm.librewolf.net librewolf ;
    #            zypper ar https://download.opensuse.org/repositories/home:Sauerland:hardware/openSUSE_Tumbleweed/home:Sauerland:hardware.repo ;

    #            zypper --gpg-auto-import-keys ref ;
    #            "
    #        ;;

    #    *) printf '%s\n' "No repository to add." ;;
    #esac

    functionSystemPrintMessage printSleep
}

functionRollFixes() 
{
    functionSystemPrintMessage privilegeRoot rollFixes

    # Hardware layer
    case "${currentHost}" in
        "MacBookPro9,2")                  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" ;;
        "Apple Inc. 1.0 - MacBookPro9,2") su -c "$packageInstallCommandAuto ${binary_broadcom_wl}" ;;
        *)                                printf '%s\n' "Hardware running smoothly" ;;
    esac

    # Operting system layer
    case "${distroName}" in
        "Debian") ln -s $(which fdfind) "${HOME}/.local/bin/fd" ;;
        *)        printf '%s\n' "Operating system running smoothly" ;;
    esac

    functionSystemPrintMessage printSleep
}

functionInstallPackages()
{
    functionSystemPrintMessage privilegeRoot installPackages
	
	case "${currentHost}" in
		"LENOVO ThinkPad X230 - 23252FG" | "Apple Inc. 1.0 - MacBookPro9,2" | "pc-i440fx-9.2 - Standard PC (i440FX + PIIX, 1996)")
			case "${XDG_SESSION_DESKTOP}" in
                "KDE") su -c "$packageInstallCommandAuto $ohmyposhInstall        \
                                                         $List_of_KDEBasics      \
                                                         $List_of_KDEPersonal    \
                                                         $List_of_KDEFortiClient \
                                                         $List_of_Terminal       \
                                                         $List_of_Developer"
                       su -c "$flatpakInstallCommand     $List_of_Flatpaks";;
                *)     su -c "$packageInstallCommandAuto $ohmyposhInstall";;
            esac
        ;;
        "Windows Subsystem for Linux") su -c "$packageInstallCommandAuto    $ohmyposhInstall  \
                                                                            $List_of_Terminal \
                                                                            $List_of_Developer"
                                       su -c "$packageInstallCommandPattern $List_of_WSLPattern";;
		"iOS/iPadOS") "$packageInstallCommand $List_of_iSH";;
		"MacBook9,2") "$packageInstallCommand --file=${pathUtilities}/packageBrewfile";;
		*)
			case "${XDG_SESSION_DESKTOP}" in
                "KDE") su -c "$packageInstallCommandAuto $ohmyposhInstall";;
                *)     su -c "$packageInstallCommandAuto $ohmyposhInstall";;
            esac
            ;;
	esac

    functionSystemPrintMessage printSleep
}

functionGetFonts()
{
    functionSystemPrintMessage privilegeUser getFonts

    if [ ! -d "${HOME}/.fonts" ]; then mkdir -p "${HOME}/.fonts"; fi
    if [ ! -d ${pathCache}   ];   then mkdir -p ${pathCache}; fi

    if [ "$(curl -is ${urlNerdFonts} | head -n 1)" = "HTTP/2 404" ]; then
        for dl_fonts in $(ls "${pathDotRoot}/INSTALL/fonts/*.tar.xz")
        do
            tar -xvf "${pathDotRoot}/INSTALL/fonts/${downloadedFonts}" --directory "${HOME}/.fonts"
        done
    else
        for downloadedFonts in ${packages_fonts}
        do
            curl -L $(curl -s ${urlNerdFonts} | grep browser_download_url | cut -d '"' -f 4 | grep ${downloadedFonts}) --output "${pathCache}/${downloadedFonts}"
            tar -xvf "${pathCache}/${downloadedFonts}" --directory "${HOME}/.fonts"
            rm "${pathCache}/${downloadedFonts}"
        done
    fi

    rm "${HOME}/.fonts/LICENSE.txt"
    rm "${HOME}/.fonts/LICENSE.md"
    rm "${HOME}/.fonts/license.txt"
    rm "${HOME}/.fonts/license.md"
    rm "${HOME}/.fonts/README.txt"
    rm "${HOME}/.fonts/README.md"
    rm "${HOME}/.fonts/readme.txt"
    rm "${HOME}/.fonts/readme.md"
    rm "${HOME}/.fonts/OFL.txt"

    functionSystemPrintMessage printSleep
}

functionPerformSymlinks()
{
    functionSystemPrintMessage privilegeUser performSymlinks

    [ ! -d "${HOME}/.config/" ] && mkdir "${HOME}/.config/"

    for eachSymlinkDirectory in $List_of_SymlinksDirRem
    do
        [ -d $eachSymlinkDirectory ] && rm -rf "$eachSymlinkDirectory"
    done

    for eachSymlink in $List_of_Symlinks
    do
        ln -vsf $eachSymlink
    done

    functionSystemPrintMessage printsleep
}

functionConfGitGlobals()
{
    functionSystemPrintMessage privilegeUser confGitConfig

    printf '%s'     "user.email: "
    read -r git_user_email
    printf '%s\n'   ""
    git config --global user.email "${git_user_email}"

    printf '%s\n'   ""

    printf '%s'     "user.name: "
    read -r git_user_name
    printf '%s\n'   ""
    git config --global user.name "${git_user_name}"

    functionSystemPrintMessage printSleep
}

functionSyncGitSubmodules()
{
    functionSystemPrintMessage privilegeUser syncGitSubmodule

    # A repository with submodules already added must be initiated.
    (cd "${pathDotRoot}" && git submodule update --init --recursive) && printf '%s\n' "" "Submodules updated" ""

    functionSystemPrintMessage printsleep
}

functionRollZSHShell() 
{
    functionSystemPrintMessage privilegeUser rollZSHShell

    printf '%s\n' "Current shell: ${SHELL}"

    # Check if running shell is ZSH.
    if [ "${SHELL}" != "/usr/bin/zsh" ]; then
        # Check if ZSH is installed.
        if [ ! -f "${zshInstallPath}" ]; then
            # iSH uses a different method for shell changing.
            if [ "${currentHost}" = "iOS/iPadOS" ]; then sed -i 's/ash/zsh/g' /etc/passwd && printf '%s\n' "Replaced ash with zsh in /etc/passwd file.";
            else chsh -s "$(which zsh)" && printf '%s\n' "Shell changed to ZSH." || printf '%s\n' "ERROR: Shell not changed."; fi
        else
            printf '%s\n' "ZSH missing. Want to install? [y/n]: "
            read  -r optionZSHChange
            if [ "${optionZSHChange}" = "y" ] ; then
                (su -c "${packageInstallCommand} zsh")
                functionRollZSHShell
            fi
        fi
    else printf '%s\n' "ZSH already running."; fi

    functionSystemPrintMessage printSleep
}

functionRebuildSubmodules() 
{
    functionSystemPrintMessage privilegeUser rebuildSubmodules

    previous_pwd="$(pwd)"

    # NOTE: submodule path is relative to root repository.
    cd $pathDotRoot &&
        for eachGitSubmodule in $List_of_Submodules
        do
             git submodule add $eachGitSubmodule
        done


    cd $previous_pwd

    functionSystemPrintMessage printSleep
}

functionRestoreKDE()
{
    functionSystemPrintMessage privilegeUser restoreKDE

    for eachKDEConfig in ${List_of_RestoreKDE}
    do
        [ -d ${pathKDEThemes}/${eachKDEConfig} ]        && rm -rf "${pathKDEThemes}/${eachKDEConfig}"
        cp -rv "${pathDotRoot}/kde_backup/share/${eachKDEConfig}" "${pathKDEThemes}/${eachKDEConfig}"
    done

    [ -d "${HOME}/.icons" ]                             && rm -rf "${HOME}/.icons"
    cp -rv "${pathDotRoot}/kde_backup/.icons"                     "${HOME}/.icons"

    functionSystemPrintMessage printSleep
}

functionRestoreMacOS()
{
    functionSystemPrintMessage privilegeUser restoreMacOS

    for eachMacOSConfig in ${List_of_RestoreMacOS}
    do
        [ -d ${pathMacOSAppSupport}/${eachMacOSConfig} ] && rm -rf "${pathMacOSAppSupport}/${eachMacOSConfig}"
    done
    
    cp -rv "${pathDotRoot}/.config/tgpro/Preferences/com.tunabellysoftware.tgpro.plist" "${pathMacOSPreference}/com.tunabellysoftware.tgpro.plist"

    functionSystemPrintMessage printSleep
}

functionVMTemplateCleanUp()
{
    functionSystemPrintMessage privilegeRoot vmTemplateCleanUp

    case "${distroName}" in
        "debian")
            printf '%s\n' "Reconfiguring SSH Keys"
            (su -c "
                rm -fv /etc/ssh/ssh_host_*
                dpkg-reconfigure openssh-server
                systemctl restart ssh
            ")

            printf '%s\n' "Cleaning packages"
            (su -c "
                ${packageManager} autoclean
                ${packageManager} clean
                ${packageManager} autoremove
            ")

            printf '%s\n' "Configuring Journalctl"
            (su -c "
                sed -i 's@#SystemMaxUse=@SystemMaxUse=1G@g' /etc/systemd/journald.conf
                sed -i 's@#SystemMaxFileSize=@SystemMaxFileSize=50M@g' /etc/systemd/journald.conf

                journalctl --vacuum-time=2d
                journalctl --vacuum-size=100M
                systemctl restart systemd-journald
            ")

            printf '%s\n' "Clearing temporary folder"
            (su -c "
                rm -rf /tmp/.
            ")
            ;;
        *)
            printf '%s\n' "Distro not implemented yet"
            ;;
    esac

    functionSystemPrintMessage printsleep
}

