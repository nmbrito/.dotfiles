#!/bin/sh

function_SystemAuditFile()
{
    check_Entry="${1}"

    for each_Entry in ${check_Entry}; do
        if [ ! -f "${path_Utilities}/${each_Entry}" ]; then
            printf '%s\n' "${each_Entry} file missing. Aborting."
            exit 0
        fi
    done
}
function_SystemPrintMessage()
{
    privilege_Type="${1}"
    show_Message="${2}"

    case "${privilege_Type}" in
        "privilege_Root")
            case "${show_Message}" in
                "roll_Repositories")
                    printf '%s\n' "Repositories"
                    ;;
                "roll_Fixes")
                    printf '%s\n' "Computer Fixes"
                    ;;
                "roll_Packages")
                    printf '%s\n' "Packages"
                    ;;
            esac

            printf '%s\n' \
                "${message_LongDash}" \
                ""                    \
                "${message_LongWarn}" \
                "${message_ExecRoot}" \
                "${message_LongWarn}" \
                ""
        ;;
        "privilege_User")
            case "${show_Message}" in
                "roll_Fonts")
                    printf '%s\n' "Fonts"
                    ;;
                "roll_Symlinks")
                    printf '%s\n' "Symlinking"
                    ;;
                "roll_ZSHShell")
                    printf '%s\n' "Changing shell to ZSH"
                    ;;
                "configure_GitGlobals")
                    printf '%s\n' "Git globals configuration"
                    ;;
                "sync_GitSubmodules")
                    printf '%s\n' "Syncing git submodules"
                    ;;
                "rebuild_GitSubmodules")
                    printf '%s\n' "Rebuilding git submodules"
                    ;;
                "restore_ExtraConfigs")
                    printf '%s\n' "Restoring KDE settings"
                    ;;
                "prepare_VirtualMachine")
                    printf '%s\n' "Preparing Virtual Machine"
                    ;;
            esac

            printf '%s\n' "${message_LongDash}" \
                          ""
        ;;
        "print_Sleep")
            printf '%s\n' ""
            sleep 3s
        ;;
    esac
}
function_SystemBuildMenu()
{
    printf '%s' "${c_ClearScreen}"
    printf '%s\n' \
        "${c_Bold} Select an option:                                           " \
        " --------------------------------------------------------- ${c_Normal}" \
        "  (1) Run all                                                         " \
        "  (2) Repositories           | (7) Change to ZSH Shell                " \
        "  (3) Fixes                  | (8) Sync Git Submodules                " \
        "  (4) Packages               | (9) Configure Git Globals              " \
        "  (5) Fonts                  | (10) Restore Extra Configs             " \
        "  (6) Symlinks               |                                        " \
        "                                                                      " \
        "  (r) Rebuild Git Submodules                                          " \
        "                                                                      " \
        "${c_Bold} Information:                                                " \
        " --------------------------------------------------------- ${c_Normal}" \
        "  Host: $current_Host                                                 " \
        "                                                                      " \
        "  Distribution: $ID                                                   " \
        "  Package Manager: $package_Manager                                    " \
        "  Package Install Command: $package_Install                            " \
        "                                                                      " \
        "  Current shell: $SHELL                                               " \
        "                                                                      " \
        "  Current Working Directory: $(pwd)                                   " \
        "                                                                      " \
        "  Directories:                                                        " \
        "      Repository: $path_DotRoot                                       " \
        "      Cache:      $path_Cache                                         " \
        "      Script:     $path_Script                                        " \
        "      Utilities:  $path_Utilities                                     " \
        "${c_Bold} ---------------------------------------------------------   " \
        "  ( ) exit / cancel                                                   " \
        " ---------------------------------------------------------${c_Normal} " \
        ""
}
function_SystemDefineDistro() 
{
    # Flatpak universal
    . "${path_Utilities}/define_Flatpak.sh"

    # Distribuitions have different package managers
    case "${ID}" in
        "almalinux")
            . "${path_Utilities}/define_AlmaLinux.sh"
            ;;
        "alpine")
            . "${path_Utilities}/define_Alpine.sh"
            ;;
        "archlinux")
            . "${path_Utilities}/define_ArchLinux.sh"
            ;;
        "debian")
            . "${path_Utilities}/define_Debian.sh"
            ;;
        "macOS")
            . "${path_Utilities}/define_macOS.sh"
            ;;
        "opensuse-tumbleweed")
            . "${path_Utilities}/define_OpenSUSE_TW.sh"
            ;;
        *)
            printf '%s\n' "This script doesn't support distribuition: $ID"
            exit 0
            ;;
    esac
}
function_SystemDefineHost()
{
    if [ -d "${path_SysDevDMI}" ]; then
        # Physical machine
        current_Host="${cat_SysDevBoardVendor} ${cat_SysDevProdVendor} - ${cat_SysDevProdName}"
    elif [ -d "${path_SWVers}" ]; then
        # Apple macOS devices
        current_Host="$(sysctl hw.model)"
    elif [ -d "${path_iSH}" ]; then
        # iSH.app on iOS and iPadOS
        current_Host="iOS/iPadOS"
    elif [ "${wsl_Session}" ]; then
        # WSL1 and WSL2 sessions
        current_Host="Windows Subsystem for Linux"
    else
        current_Host="None"
    fi

    # Known Hosts
    #   Thinkpad x230              - LENOVO ThinkPad X230 - 23252FG
    #   Thinkpad L14 G2            - LENOVO ThinkPad L14 Gen 2 - 20X1000UPG
    #   Proxmox Virtual Machine    -  pc-i440fx-9.2 - Standard PC (i440FX + PIIX, 1996)
    #   Macbook Pro Mid 2012 Linux - Apple Inc. 1.0 - MacBookPro9,2
    #   Macbook Pro Mid 2012 MacOS - MacBook9,2
    #   iPhone 13                  - iOS/iPadOS
    #   iPad Pro M2                - iOS/iPadOS
    #   Windows Terminal WSL2      - Windows Subsystem for Linux
}
function_SystemAskForSudoPassword()
{
    printf '%s' "Please input sudo password: "
    stty -echo
    read -r sudo_Password
    stty echo 
    printf '%s\n' ""
}
function_RollRepositories()
{
    function_SystemPrintMessage privilege_Root roll_Repositories

    for eachGPGKeys in ${List_of_GPGKeys}; do
        printf '%s\n' "$sudo_Password" | sudo -S ${SHELL} -c "$repo_Import $eachGPGKeys" 
    done
    local IFS=$'\n'
    for eachRepository in ${List_of_Repositories}; do
        printf '%s\n' ${sudo_Password} | sudo -S ${SHELL} -c "$repo_Add $eachRepository" 
    done

    printf '%s\n' "${sudo_Password}" | sudo -S ${SHELL} -c "$repo_AutoGPGKeys"
    
    function_SystemPrintMessage print_Sleep
}
function_RollFixes() 
{
    function_SystemPrintMessage privilege_Root roll_Fixes

    # Hardware layer
    case "${current_Host}" in
        "LENOVO ThinkPad X230 - 23252FG")
            printf '%s\n' "$sudo_Password" | sudo -S ${SHELL} -c "$package_InstallAuto ${List_of_x230}"
            ;;
        "Apple Inc. 1.0 - MacBookPro9,2")
            printf '%s\n' "$sudo_Password" | sudo -S ${SHELL} -c "$package_InstallAuto ${List_of_MacbookProMid2012}"
            printf '%s\n' "$sudo_Password" | sudo -S ${SHELL} -c "systemctl enable mbpfan.service"
            printf '%s\n' "$sudo_Password" | sudo -S ${SHELL} -c "systemctl daemon-restart"
            printf '%s\n' "$sudo_Password" | sudo -S ${SHELL} -c "systemctl enable mbpfan.service"
            ;;
        "MacBookPro9,2")
            printf '%s\n' "${sudo_Password}" | sudo -S ${SHELL} -c /bin/bash -c "curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
            ;;
    esac

    # Operating system layer
    case "${distro_Name}" in
        "Debian")
            ln -s $(which fdfind) "${HOME}/.local/bin/fd"
            ;;
    esac

    function_SystemPrintMessage print_Sleep
}
function_RollPackages()
{
    function_SystemPrintMessage privilege_Root roll_Packages

    curl -s $url_OhMyPosh | bash -s -- -d ${HOME}/.local/bin

	case "${current_Host}" in
		"LENOVO ThinkPad X230 - 23252FG" | "LENOVO ThinkPad L14 Gen 2 - 20X1000UPG" | "Apple Inc. 1.0 - MacBookPro9,2" | " pc-i440fx-9.2 - Standard PC (i440FX + PIIX, 1996)")
			case "${XDG_SESSION_DESKTOP}" in
                "KDE")
                    printf '%s\n' "$sudo_Password" | sudo -S ${SHELL} -c "$package_InstallAuto  \
                                                                        $List_of_KDEBasics \
                                                                        $List_of_KDEPersonal \
                                                                        $List_of_KDEFortiClient \
                                                                        $List_of_Terminal \
                                                                        $List_of_Developer"
                    printf '%s\n' "$sudo_Password" | sudo -S ${SHELL} -c "$flatpak_InstallAuto $List_of_Flatpaks"
                    ;;
                *)
                    ;;
            esac
            ;;
        "Windows Subsystem for Linux")
            su -c "$package_InstallAuto \
                $List_of_Terminal      \
                $List_of_Developer"

            if [ "$package_InstallPattern" != "" ]; then
                su -c "$package_InstallPattern $List_of_WSLPattern"
            fi
            ;;
		"iOS/iPadOS")
            "$package_Install $List_of_iSH"
            ;;
		"MacBook9,2")
            "$package_Install --file=${pathUtilities}/packages_Brewfile"
            ;;
		*)
			#case "${XDG_SESSION_DESKTOP}" in
            #    "KDE") ;;
            #    *) ;;
            #esac
            ;;
	esac

    # XDG_SESSION_DESKTOP
    #   KDE Gnome Hyprland XFCE

    function_SystemPrintMessage print_Sleep
}
function_RollFonts()
{
    function_SystemPrintMessage privilege_User roll_Fonts

    if [ ! -d "${HOME}/.fonts" ]; then
        mkdir -p "${HOME}/.fonts"
    fi

    if [ ! -d "$path_Cache" ]; then
        mkdir -p "$path_Cache"
    fi

    if [ "$(curl -is $url_NerdFonts | head -n 1)" = "HTTP/2 404" ]; then
        for eachFont in $(ls ${path_DotRoot}/INSTALL/fonts/*.tar.xz); do
            tar -xvf "${path_DotRoot}/INSTALL/fonts/${eachFont}" --directory "${HOME}/.fonts"
        done
    else
        for eachFont in $List_of_Fonts; do
            curl -L $(curl -s $url_NerdFonts | grep browser_download_url | cut -d '"' -f 4 | grep ${eachFont}) --output ${path_Cache}/${eachFont}
            tar -xvf "${path_Cache}/${eachFont}" --directory "${HOME}/.fonts"
            rm "${path_Cache}/${eachFont}"
        done
    fi

    rm "${HOME}"/.fonts/LICENSE*
    rm "${HOME}"/.fonts/README*
    rm "${HOME}"/.fonts/OFL*

    function_SystemPrintMessage print_Sleep
}
function_RollSymlinks()
{
    function_SystemPrintMessage privilege_User roll_Symlinks

    if [ ! -d "${HOME}/.config/" ]; then
        mkdir "${HOME}/.config/"
    fi

    if [ -d "${HOME}/.vim" ]; then
        rm -rf "${HOME}/.vim"
    fi
    if [ -d "${HOME}/.config/.vifm" ] || [ -L "${HOME}/.config/.vifm" ]; then
        rm -rf "${HOME}/.config/vifm"
    fi
    if [ -d "${HOME}/.config/.fastfetch" ] || [ -L "${HOME}/.config/.fastfetch" ]; then
        rm -rf "${HOME}/.config/fastfetch"
    fi
    if [ -d "${HOME}/.config/.tmux" ] || [ -L "${HOME}/.config/.tmux" ]; then
        rm -rf "${HOME}/.config/tmux"
    fi
    if [ -d "${HOME}/.config/.fd" ] || [ -L "${HOME}/.config/.fd" ]; then
        rm -rf "${HOME}/.config/fd"
    fi
    if [ -d "${HOME}/.config/.mc" ] || [ -L "${HOME}/.config/.mc" ]; then
        rm -rf "${HOME}/.config/mc"
    fi

    ln -vsf "${path_DotRoot}/config/zsh/zshrc"    "${HOME}/.zshrc"
    ln -vsf "${path_DotRoot}/config/zsh/zprofile" "${HOME}/.zprofile"
    ln -vsf "${path_DotRoot}/config/vim/vimrc"    "${HOME}/.vimrc"

    ln -vsf "${path_DotRoot}/config/vim"          "${HOME}/.vim"
    ln -vsf "${path_DotRoot}/config/vifm"         "${HOME}/.config/vifm"
    ln -vsf "${path_DotRoot}/config/fastfetch"    "${HOME}/.config/fastfetch"
    ln -vsf "${path_DotRoot}/config/tmux"         "${HOME}/.config/tmux"
    ln -vsf "${path_DotRoot}/config/fd"           "${HOME}/.config/fd"
    ln -vsf "${path_DotRoot}/config/mc"           "${HOME}/.config/mc"

    function_SystemPrintMessage print_Sleep
}
function_RollZSHShell() 
{
    function_SystemPrintMessage privilege_User roll_ZSHShell

    printf '%s\n' "Current shell: $SHELL"

    if [ "${SHELL}" != "$path_ZSHBin" ]; then
        if [ ! -f "$path_ZSHShare" ]; then
            if [ "$current_Host" = "iOS/iPadOS" ]; then
                sed -i 's/ash/zsh/g' /etc/passwd && printf '%s\n' "Replaced ash with zsh."
            else
                chsh -s $(which zsh) \
                    && printf '%s\n' "Shell changed to ZSH." \
                    || printf '%s\n' "ERROR: Shell not changed."
            fi
        else
            printf '%s\n' "ZSH missing. Want to install? [y/n]: "
            read -r option_ZSHChange
            if [ "$option_ZSHChange" = "y" ]; then
                su -c "$package_InstallAuto ${binary_zsh}"
                function_RollZSHShell
            fi
        fi
    else
        printf '%s\n' "ZSH already running."
    fi

    function_SystemPrintMessage print_Sleep
}
function_ConfigureGitGlobals()
{
    function_SystemPrintMessage privilege_User configure_GitGlobals

    printf '%s' "user.email: "
    read -r git_user_email
    printf '%s\n' ""
    git config --global user.email $git_user_email

    printf '%s\n' ""

    printf '%s' "user.name: "
    read -r git_user_name
    printf '%s\n' ""
    git config --global user.name $git_user_name

    function_SystemPrintMessage print_Sleep
}
function_SyncGitSubmodules()
{
    function_SystemPrintMessage privilege_User sync_GitSubmodules

    # A repository with submodules already added must be initiated.
    cd $path_DotRoot                               \
        && git submodule update --init --recursive \
        && printf '%s\n' ""                        \
                         "Submodules updated"      \
                         ""

    function_SystemPrintMessage print_Sleep
}
function_RebuildGitSubmodules() 
{
    function_SystemPrintMessage privilege_User rebuild_GitSubmodules

    previous_WorkingDir="$(pwd)"

    local IFS=$'\n'
    # NOTE: submodule path is relative to root repository.
    cd $path_DotRoot \
        && for eachGitSubmodule in $List_of_Submodules; do
            git submodule add $eachGitSubmodule
           done

    cd $previous_WorkingDir

    function_SystemPrintMessage print_Sleep
}
function_RestoreExtraConfigs()
{
    function_SystemPrintMessage privilege_User restore_ExtraConfigs

	case "${current_Host}" in
		"LENOVO ThinkPad X230 - 23252FG" | "LENOVO ThinkPad L14 Gen 2 - 20X1000UPG" | "Apple Inc. 1.0 - MacBookPro9,2" | " pc-i440fx-9.2 - Standard PC (i440FX + PIIX, 1996)")
			case "${XDG_SESSION_DESKTOP}" in
                "KDE")
                    #TODO: Install global theme in terminal
                    cp -rv "${path_DotRoot}/config/kde_plasma/home_config/." "${path_KDEConfig}/"
                    cp -rv "${path_DotRoot}/config/kde_plasma/local_share/." "${path_KDEThemes}/"
                    ;;
            esac
            ;;
		"MacBook9,2")
            cp -rv "${path_DotRoot}/.config/tgpro/Preferences/com.tunabellysoftware.tgpro.plist" "${path_MacOSPreference}/com.tunabellysoftware.tgpro.plist"
            ;;
    esac

    function_SystemPrintMessage print_Sleep
}
function_PrepareVirtualMachine()
{
    printf '%s\n' "Work in Progress"
#    functionSystemPrintMessage privilegeRoot prepareVirtualMachine
#
#    case "${distro_Name}" in
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
#                ${package_Manager} autoclean
#                ${package_Manager} clean
#                ${package_Manager} autoremove
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
}
function_SetHostname()
{
    old_Hostname=$(hostname)

    printf '%s' "New hostname: "
    read -r new_Hostname

    hostnamectl set-hostname ${new_Hostname}
    sed -i "s/$old_Hostname/${new_hostname}/g" /etc/hosts
}
function_SetRootPassword()
{
    printf '%s' "Please set root password: "
    passwd root
}
