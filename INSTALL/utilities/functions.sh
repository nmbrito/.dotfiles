#!/bin/sh

# File: home_functions.sh
# Description: functions for home_setup.sh

# TODO:
#   functionInstallPackages:
#       Add host virtual machine
#       Add SSH sessions

functionPrintMessage() 
{
    case "${1}" in
        "privilege_root")
            case "${2}" in
                "fixes")                printf '%s\n' "Computer Fixes" ;;
                "repositories")         printf '%s\n' "Repositories" ;;
                "packages")             printf '%s\n' "Packages" ;;
                "vmtemplatecleanup")    printf '%s\n' "Preparing Template" ;;
            esac

            printf '%s\n'   "${message_longdash}" \
                            "" \
                            "${message_longwarn}" "${message_execroot}" "${message_longwarn}" \
                            ""
        ;;
        "privilege_user")
            case "${2}" in
                "fonts")                printf '%s\n' "Fonts" ;;
                "symlinking")           printf '%s\n' "Symlinking" ;;
                "gitconfig")            printf '%s\n' "Git globals configuration." ;;
                "syncgitsubmodule")     printf '%s\n' "Syncing git submodules" ;;
                "vimhelptags")          printf '%s\n' "Linking VIM Helptags" ;;
                "zshshell")             printf '%s\n' "Changing to ZSH" ;;
                "rebuildsubmodules")    printf '%s\n' "Rebuilding git submodules" ;;
                "restorekde")           printf '%s\n' "Restoring KDE settings" ;;
            esac

            printf '%s\n'   "${message_longdash}" \
                            ""
        ;;
        "printsleep")
            printf '%s\n'   ""
            sleep 3s
        ;;
    esac
}

functionBuildMenu() 
{
    printf '%s\n'   "                                                                " \
                    "|--------------------------------------------------------------|" \
                    "| Select an option:                                            |" \
                    "|--------------------------------------------------------------|" \
                    "|  ( 1) Run all                 |  ( 6) Symlinks               |" \
                    "|  ( 2) Repositories            |  ( 7) Configure git globals  |" \
                    "|  ( 3) Packages                |  ( 8) Sync git submodules    |" \
                    "|  ( 4) Fixes                   |  ( 9) Link vim helptags      |" \
                    "|  ( 5) Fonts                   |  (10) Change to zsh shell    |" \
                    "|--------------------------------------------------------------|" \
                    "|  ( r) rebuild git submodules                                 |" \
                    "|--------------------------------------------------------------|" \
                    "|  host: ${current_host}                                        " \
                    "|  distribuition: "${ID}"                                       " \
                    "|  package manager: "${pkg_manager}"                            " \
                    "|  current shell: "${SHELL}"                                    " \
                    "|  pwd: $(pwd)                                                  " \
                    "|  repository root: "${path_dotroot}"                           " \
                    "|  cache directory: "${path_cache}"                             " \
                    "|--------------------------------------------------------------|" \
                    "|  ( ) exit / cancel                                           |" \
                    "|--------------------------------------------------------------|" \
                    "                                                                "
}

functionInfoMenu() 
{
    printf '%s\n'   "                                                                " \
                    "|--------------------------------------------------------------|" \
                    "| Select an option:                                            |" \
                    "|--------------------------------------------------------------|" \
                    "|  Host: ${current_host}                                        " \
                    "|  Distribuition: ${ID}                                         " \
                    "|                                                               " \
                    "|  Package manager: ${pkg_manager}                              " \
                    "|  Package install command: ${pkg_installcommand}               " \
                    "|                                                               " \
                    "|  Current shell: ${SHELL}                                      " \
                    "|  Pwd: $(pwd)                                                  " \
                    "|--------------------------------------------------------------|" \
                    "|  Repository root: ${path_dotroot}                             " \
                    "|  Cache directory: ${path_cache}                               " \
                    "|  Script path: ${path_script}                                  " \
                    "|  Utilities path: ${path_utilities}                            " \
                    "|--------------------------------------------------------------|" \
                    "|  $0                                                           " \
                    "|--------------------------------------------------------------|" \
                    "                                                                "
}

functionDefineDistro() 
{
    # Some distribuitions have different package names and software paths.
    case "${ID}" in
        "opensuse-tumbleweed")
            pkg_manager="zypper"
            pkg_update="zypper up"
            pkg_upgrade="zypper dup"
            pkg_installcommand="zypper install -y"
            distro_name="opensuse-tumbleweed"
            zsh_install_path="/usr/share/zsh"

            software_btop="btop"
            software_fd="fd"
            software_fdzshcompletion="fd-zsh-completion"
            software_fzftmux="fzf-tmux"
            software_fzfzshcompletion="fzf-zsh-completion"
            software_rgzshcompletion="ripgrep-zsh-completion"
            software_shellcheck="ShellCheck"
            software_vifmcolors="vifm-colors"
            software_vimdata="vim-data"
            ;;
        "debian")
            pkg_manager="apt"
            pkg_update="apt update"
            pkg_upgrade="apt -y upgrade"
            pkg_installcommand="apt -y install"
            distro_name="debian"
            zsh_install_path="/usr/share/zsh"

            software_btop="btop"
            software_fd="fd-find"
            software_fdzshcompletion=""
            software_fzftmux=""
            software_fzfzshcompletion=""
            software_rgzshcompletion=""
            software_shellcheck="ShellCheck"
            software_vifmcolors=""
            software_vimdata="vim-common"
            ;;
        "archlinux")
            pkg_manager="pacman"
            pkg_update="pacman -Sy"
            pkg_upgrade="pacman -Syu"
            pkg_installcommand="pacman -S"
            distro_name="arch"
            zsh_install_path="/usr/share/zsh"

            software_btop="btop"
            software_fd=""
            software_fdzshcompletion=""
            software_fzftmux=""
            software_fzfzshcompletion=""
            software_rgzshcompletion=""
            software_shellcheck="ShellCheck"
            software_vifmcolors=""
            software_vimdata=""
            ;;
        "almalinux")
            pkg_manager="dnf"
            pkg_update="dnf update"
            pkg_upgrade="dnf upgrade -y"
            pkg_installcommand="dnf install -y"
            distro_name="almalinux"
            zsh_install_path="/usr/share/zsh"

            software_btop="btop"
            software_fd="fd"
            software_fdzshcompletion=""
            software_fzftmux=""
            software_fzfzshcompletion=""
            software_rgzshcompletion=""
            software_shellcheck="ShellCheck"
            software_vifmcolors=""
            software_vimdata=""
            ;;
        "alpine")
            pkg_manager="apk"
            pkg_update=""
            pkg_upgrade=""
            pkg_installcommand="apk add"
            distro_name="alpine"
            zsh_install_path="/usr/share/zsh"

            software_btop=""
            software_fd="fd"
            software_fdzshcompletion="fd-zsh-completion"
            software_fzftmux="fzf-tmux"
            software_fzfzshcompletion="fzf-zsh-completion"
            software_rgzshcompletion=""
            software_shellcheck=""
            software_vifmcolors=""
            software_vimdata=""
            ;;
        "macOS")
            pkg_manager="brew"
            pkg_update="brew update"
            pkg_upgrade="brew upgrade"
            pkg_installcommand="brew bundle install"
            distro_name="macOS"
            zsh_install_path="/usr/share/zsh"
            ;;
        *)
            printf '%s\n'   "This script doesn't support distribuition: "${ID}"" \
                            "Exiting."
            exit 0
            ;;
    esac
}

functionDefineHost() 
{
    # dmi directory indicates a physical machine
    if [ -d "/sys/devices/virtual/dmi" ]; then
        current_host="$(cat /sys/devices/virtual/dmi/id/board_vendor) $(cat /sys/devices/virtual/dmi/id/product_version) - $(cat /sys/devices/virtual/dmi/id/product_name)"

    # ish directory is only available on Apple devices running iSH.app
    elif [ -d "/proc/ish" ]; then
        current_host="iOS/iPadOS"

    # software_vers gives macos os name and version, ergo we can get the hostname from sysctl
    elif [ -d "/usr/bin/software_vers" ]; then
        current_host="$(sysctl hw.model)"

    # WT_SESSION environment variable available in WSL1 and WSL2
    elif [ "${wslsession}" ]; then 
        current_host="Windows Subsystem for Linux"

    # If none of the above
    else
        current_host="None"
    fi
}

functionRepositories() 
{
    functionPrintMessage privilege_root repositories

    case "${distro_name}" in
        "opensuse-tumbleweed")
            su -c "
                rpm --import https://packages.microsoft.com/keys/microsoft.asc ;
                zypper ar https://packages.microsoft.com/yumrepos/vscode vscode ;
                zypper ar https://rpm.librewolf.net/librewolf-repo.repo ;
                zypper --gpg-auto-import-keys ref ;
                "
                # Last command is the same as "zypper refresh" but also accepts automatically keys
            ;;
        *)
            printf '%s\n' "No repository to add."
            ;;
    esac

    functionPrintMessage printsleep
}

functionPackages() 
{
    functionPrintMessage privilege_root packages

    # Install Oh-My-Posh

    case "${current_host}" in
        "LENOVO ThinkPad X230 - 23252FG")
            curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ${HOME}/.local/bin
            case "${XDG_SESSION_DESKTOP}" in
                "KDE")
                    su -c "$pkg_installcommand \
                        $packages_terminal \
                        $packages_dev \
                        $packages_kde_basics \
                        $packages_kde_personal \
                        $packages_x230 \
                        ";
                    ;;
                #"hyprland")
                    #(su -c "${pkg_installcommand} ${packages_terminal} ${packages_dev} ${packages_hyprland} ${packages_kde_personal}");
                    #;;
                *)
                    su -c "$pkg_installcommand \
                        $packages_terminal \
                        $packages_dev \
                        ";
                    ;;
            esac
            ;;
        "Windows Subsystem for Linux")
            curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ${HOME}/.local/bin
            su -c "$pkg_installcommand \
                $packages_terminal \
                $packages_dev \
                ";

            if [ "${distro_name}" = "opensuse-tumbleweed" ]; then su -c "$pkg_installcommand -t pattern $packages_wsl_pattern"; fi
            ;;
        "iOS/iPadOS")
            "$pkg_installcommand $packages_terminal $packages_ish"
            ;;
        "MacBook9,2")
            "$pkg_installcommand --file=${dir_dotroot}/INSTALL/Brewfile"
            ;;
        *)
            case "${XDG_SESSION_DESKTOP}" in
                "KDE")
                    curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ${HOME}/.local/bin
                    su -c "$pkg_installcommand \
                        $packages_terminal \
                        $packages_kde_basics \
                        ";
                    ;;
                *) ;;
            esac
    esac

    functionPrintMessage printsleep
}

functionFixes() 
{
    functionPrintMessage privilege_root fixes

    # Hardware layer
    case "${current_host}" in
        "MacBookPro9,2")
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 
            ;;
        *)
            printf '%s\n' "Hardware running smoothly"
            ;;
    esac

    # Operting system layer
    case "${distro_name}" in
        "debian")
            printf '%s\n' "Symlinking fd-find"

            ln -s $(which fdfind) "${HOME}/.local/bin/fd"
            ;;
        *)
            printf '%s\n' "Operating system running smoothly"
            ;;
    esac

    functionPrintMessage printsleep
}

functionFonts() 
{
    functionPrintMessage privilege_user fonts

    if [ ! -d "${HOME}/.fonts" ] ; then mkdir -p "${HOME}/.fonts" ; fi
    if [ ! -d "${path_cache}" ] ; then mkdir -p "${path_cache}" ; fi

    if [ "$(curl -is "${url_nerdfonts}" | head -n 1)" = "HTTP/2 404" ] ; then
        for dl_fonts in $(ls "${path_dotroot}/INSTALL/fonts/*.tar.xz")
        do
            tar -xvf "${path_dotroot}/INSTALL/fonts/${dl_fonts}" --directory "${HOME}/.fonts"
        done
    else
        for dl_fonts in ${packages_fonts}
        do
            curl -L $(curl -s "${url_nerdfonts}" | grep browser_download_url | cut -d '"' -f 4 | grep "${dl_fonts}") --output "${path_cache}/${dl_fonts}"
            tar -xvf "${path_cache}/${dl_fonts}" --directory "${HOME}/.fonts"
            rm "${path_cache}/${dl_fonts}"
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

    functionPrintMessage printsleep
}

functionSymlinks() 
{
    functionPrintMessage privilege_user symlinking

    [ ! -d "${HOME}/.config/" ]         && mkdir "${HOME}/.config/"

    [ -d "${HOME}/.vim" ]               && rm -rf "${HOME}/.vim"
    [ -d "${HOME}/.config/vifm" ]       && rm -rf "${HOME}/.config/vifm"
    [ -d "${HOME}/.config/fastfetch" ]  && rm -rf "${HOME}/.config/fastfetch"
    [ -d "${HOME}/.config/tmux" ]       && rm -rf "${HOME}/.config/tmux"
    [ -d "${HOME}/.config/mc" ]         && rm -rf "${HOME}/.config/mc"
    [ -d "${HOME}/.config/fd" ]         && rm -rf "${HOME}/.config/fd"

    # Files
    ln -vsf "${path_dotroot}/config/zsh/zprofile"    "${HOME}/.zprofile"
    ln -vsf "${path_dotroot}/config/zsh/zshrc"       "${HOME}/.zshrc"
    ln -vsf "${path_dotroot}/config/vim/vimrc"       "${HOME}/.vimrc"

    # Directories
    ln -vsf "${path_dotroot}/config/vim"         "${HOME}/.vim"
    ln -vsf "${path_dotroot}/config/vifm"        "${HOME}/.config/vifm"
    ln -vsf "${path_dotroot}/config/fastfetch"   "${HOME}/.config/fastfetch"
    ln -vsf "${path_dotroot}/config/tmux"        "${HOME}/.config/tmux"
    ln -vsf "${path_dotroot}/config/fd"          "${HOME}/.config/fd"
    ln -vsf "${path_dotroot}/config/mc"          "${HOME}/.config/mc"

    functionPrintMessage printsleep
}

functionRestoreKDE()
{
    functionPrintMessage privilege_user restorekde

    [ -d "${HOME}/.local/share/aurorae" ]                  && rm -rf "${HOME}/.local/share/aurorae"
    [ -d "${HOME}/.local/share/color-schemes" ]            && rm -rf "${HOME}/.local/share/color-schemes"
    [ -d "${HOME}/.local/share/icons" ]                    && rm -rf "${HOME}/.local/share/icons"
    [ -d "${HOME}/.local/share/plasma/desktoptheme" ]      && rm -rf "${HOME}/.local/share/plasma/desktoptheme"
    [ -d "${HOME}/.local/share/plasma/look-and-feel" ]     && rm -rf "${HOME}/.local/share/plasma/look-and-feel"
    [ -d "${HOME}/.local/share/wallpapers" ]               && rm -rf "${HOME}/.local/share/wallpapers"
    [ -d "${HOME}/.icons" ]                                && rm -rf "${HOME}/.icons"

    cp -rv "${path_dotroot}/kde_backup/share/aurorae"                "${HOME}/.local/share/aurorae"
    cp -rv "${path_dotroot}/kde_backup/share/color-schemes"          "${HOME}/.local/share/color-schemes"
    cp -rv "${path_dotroot}/kde_backup/share/icons"                  "${HOME}/.local/share/icons"
    cp -rv "${path_dotroot}/kde_backup/share/plasma/desktoptheme"    "${HOME}/.local/share/plasma/desktoptheme"
    cp -rv "${path_dotroot}/kde_backup/share/plasma/look-and-feel"   "${HOME}/.local/share/plasma/look-and-feel"
    cp -rv "${path_dotroot}/kde_backup/share/wallpapers"             "${HOME}/.local/share/wallpapers"
    cp -rv "${path_dotroot}/kde_backup/.icons"                       "${HOME}/.icons"

    functionPrintMessage printsleep
}

functionRestoreMacOS()
{
    [ -d "${HOME}/Library/Application Support/TG Pro" ]                           && rm -rf "${HOME}/Library/Application Support/TG Pro"
    
    cp -rv "${path_dotroot}/.config/tgpro/Application Support/TG Pro"                       "${HOME}/Library/Application Support/TG Pro"
    cp -rv "${path_dotroot}/.config/tgpro/Preferences/com.tunabellysoftware.tgpro.plist"    "${HOME}/Library/Preferences/com.tunabellysoftware.tgpro.plist"

    #TODO: iterm2 config
}

functionConfigGitGlobals() 
{
    functionPrintMessage privilege_user gitconfig

    printf '%s'     "user.email: "
    read -r git_user_email
    printf '%s\n'   ""
    git config --global user.email "${git_user_email}"

    printf '%s\n'   ""

    printf '%s'     "user.name: "
    read -r git_user_name
    printf '%s\n'   ""
    git config --global user.name "${git_user_name}"

    functionPrintMessage printsleep
}

functionGitSubmodules() 
{
    functionPrintMessage privilege_user syncgitsubmodule

    # A repository with submodules already added must be initiated.
    (cd "${path_dotroot}" && git submodule update --init --recursive) && printf '%s\n' "" "Submodules updated" ""

    functionPrintMessage printsleep
}

functionConfigVimHelptags() 
{
    functionPrintMessage privilege_user vimhelptags

    vim -u NONE -c helptags "${path_dotroot}/config/vim/pack/plugins/start/vim-airline/doc" -c q
    vim -u NONE -c helptags "${path_dotroot}/config/vim/pack/plugins/start/vim-airline-themes/doc" -c q
    vim -u NONE -c helptags "${path_dotroot}/config/vim/pack/plugins/start/surround/doc" -c q
    vim -u NONE -c helptags "${path_dotroot}/config/vim/pack/plugins/start/commentary/doc" -c q
    vim -u NONE -c helptags "${path_dotroot}/config/vim/pack/plugins/start/fugitive/doc" -c q
    vim -u NONE -c helptags "${path_dotroot}/config/vim/pack/plugins/start/undotree/doc" -c q
    vim -u NONE -c helptags "${path_dotroot}/config/vim/pack/plugins/start/fzf/doc" -c q
    vim -u NONE -c helptags "${path_dotroot}/config/vim/pack/plugins/start/fzf-vim/doc" -c q
    vim -u NONE -c helptags "${path_dotroot}/config/vim/pack/plugins/start/goyo.vim/doc" -c q
    vim -u NONE -c helptags "${path_dotroot}/config/vim/pack/plugins/start/vim-highlightedyank/doc" -c q
    vim -u NONE -c helptags "${path_dotroot}/config/vim/pack/plugins/start/vim-better-whitespace/doc" -c q
    vim -u NONE -c helptags "${path_dotroot}/config/vim/pack/plugins/start/vim-indent-guides/doc" -c q

    functionPrintMessage printsleep
}

functionConfigShell() 
{
    functionPrintMessage privilege_user zshshell

    printf '%s\n' "Current shell: ${SHELL}"

    # Check if running shell is ZSH.
    if [ "${SHELL}" != "/usr/bin/zsh" ] ; then
        # Check if ZSH is installed.
        if [ ! -f "${zsh_install_path}" ] ; then
            # iSH uses a different method for shell changing.
            if [ "${current_host}" = "iOS/iPadOS" ] ; then
                sed -i 's/ash/zsh/g' /etc/passwd && printf '%s\n' "Replaced ash with zsh in /etc/passwd file, close and re-open iSH to apply."
            else
                # Change the shell
                chsh -s "$(which zsh)" && printf '%s\n' "Shell changed to ZSH." || printf '%s\n' "ERROR: Shell not changed."
            fi
        else
            printf '%s\n' "ZSH missing. Want to install? [y/n]: "
            read  -r optionzshchange
            if [ "${optionzshchange}" = "y" ] ; then
                (su -c "${pkg_installcommand}" "zsh")
                functionConfigShell
            fi
        fi
    else
        printf '%s\n' "ZSH already running."
    fi

    functionPrintMessage printsleep
}

functionRebuildGitSubmodules() 
{
    functionPrintMessage privilege_user rebuildsubmodules

    previous_pwd="$(pwd)"

    # NOTE: submodule path is relative to root repository.
    (cd "${path_dotroot}" &&
        git submodule add https://github.com/romkatv/powerlevel10k              config/zsh/plugins/powerlevel10k
        git submodule add https://github.com/zsh-users/zsh-syntax-highlighting  config/zsh/plugins/zsh-syntax-highlighting
        git submodule add https://github.com/zsh-users/zsh-autosuggestions      config/zsh/plugins/zsh-autosuggestions
        git submodule add https://github.com/ap/vim-css-color                   config/vim/pack/plugins/start/css-color
        git submodule add https://github.com/junegunn/fzf                       config/vim/pack/plugins/start/fzf
        git submodule add https://github.com/junegunn/fzf.vim                   config/vim/pack/plugins/start/fzf.vim
        git submodule add https://github.com/junegunn/goyo.vim                  config/vim/pack/plugins/start/goyo.vim
        git submodule add https://github.com/junegunn/limelight.vim             config/vim/pack/plugins/start/limelight.vim
        git submodule add https://github.com/machakann/vim-highlightedyank      config/vim/pack/plugins/start/vim-highlightedyank
        git submodule add https://github.com/mbbill/undotree                    config/vim/pack/plugins/start/undotree
        git submodule add https://github.com/ntpeters/vim-better-whitespace     config/vim/pack/plugins/start/vim-better-whitespace
        git submodule add https://github.com/preservim/vim-indent-guides        config/vim/pack/plugins/start/vim-indent-guides
        git submodule add https://github.com/tpope/vim-surround                 config/vim/pack/plugins/start/surround
        git submodule add https://github.com/vim-airline/vim-airline            config/vim/pack/plugins/start/vim-airline
        git submodule add https://github.com/vim-airline/vim-airline-themes     config/vim/pack/plugins/start/vim-airline-themes
    )

        # Previously enabled (for reference)
        #   git submodule add https://github.com/lervag/vimtex                      config/vim/pack/plugins/start/vimtex
        #   git submodule add https://github.com/yegappan/lsp                       config/vim/pack/plugins/start/lsp

    cd "${previous_pwd}"

    functionPrintMessage printsleep
}

functionVMTemplateCleanUp()
{
    functionPrintMessage privilege_root vmtemplatecleanup

    case "${distro_name}" in
        "debian")
            printf '%s\n' "Reconfiguring SSH Keys"
            (su -c "
                rm -fv /etc/ssh/ssh_host_*
                dpkg-reconfigure openssh-server
                systemctl restart ssh
            ")

            printf '%s\n' "Cleaning packages"
            (su -c "
                ${pkg_manager} autoclean
                ${pkg_manager} clean
                ${pkg_manager} autoremove
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



    functionPrintMessage printsleep
}
