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
                "fixes")        printf '%s\n' "Computer Fixes" ;;
                "repositories") printf '%s\n' "Repositories" ;;
                "packages")     printf '%s\n' "Packages" ;;
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
                    "| select an option:                                            |" \
                    "|--------------------------------------------------------------|" \
                    "|  ( 1) run all                 |  ( 6) symlinks               |" \
                    "|  ( 2) repositories            |  ( 7) configure git globals  |" \
                    "|  ( 3) packages                |  ( 8) sync git submodules    |" \
                    "|  ( 4) fixes                   |  ( 9) link vim helptags      |" \
                    "|  ( 5) fonts                   |  (10) change to zsh shell    |" \
                    "|--------------------------------------------------------------|" \
                    "|  ( r) rebuild git submodules                                 |" \
                    "|--------------------------------------------------------------|" \
                    "|  host: ${current_host}                                        " \
                    "|  distribuition: "${ID}"                                       " \
                    "|  package manager: "${pkgmgr}"                                 " \
                    "|  current shell: "${SHELL}"                                    " \
                    "|  pwd: $(pwd)                                                  " \
                    "|  repository root: "${dir_dotroot}"                            " \
                    "|  cache directory: "${dir_cache}"                              " \
                    "|--------------------------------------------------------------|" \
                    "|  ( ) exit / cancel                                           |" \
                    "|--------------------------------------------------------------|" \
                    "                                                                "
}

functionDefineDistro() 
{
    # Some distribuitions have different package names and software paths.
    case "${ID}" in
        "opensuse-tumbleweed")
            pkgmgr="zypper"
            pkginst="zypper install -y"
            repo_flag="opensuse-tumbleweed"
            zsh_inst_folder="/usr/share/zsh"

            sw_btop="btop"
            sw_fd="fd"
            sw_fdzshcompletion="fd-zsh-completion"
            sw_fzftmux="fzf-tmux"
            sw_fzfzshcompletion="fzf-zsh-completion"
            sw_rgzshcompletion="ripgrep-zsh-completion"
            sw_shellcheck="ShellCheck"
            sw_vifmcolors="vifm-colors"
            sw_vimdata="vim-data"
            ;;
        "debian")
            pkgmgr="apt"
            pkginst="apt install -y"
            repo_flag="debian"
            zsh_inst_folder="/usr/share/zsh"

            sw_btop="btop"
            sw_fd="fd-find"
            sw_fdzshcompletion=""
            sw_fzftmux=""
            sw_fzfzshcompletion=""
            sw_rgzshcompletion=""
            sw_shellcheck="ShellCheck"
            sw_vifmcolors=""
            sw_vimdata="vim-common"
            ;;
        "archlinux")
            pkgmgr="pacman"
            pkginst="pacman -Sy"
            repo_flag="arch"
            zsh_inst_folder="/usr/share/zsh"

            sw_btop="btop"
            sw_fd=""
            sw_fdzshcompletion=""
            sw_fzftmux=""
            sw_fzfzshcompletion=""
            sw_rgzshcompletion=""
            sw_shellcheck="ShellCheck"
            sw_vifmcolors=""
            sw_vimdata=""
            ;;
        "almalinux")
            pkgmgr="dnf"
            pkginst="dnf install -y"
            repo_flag="almalinux"
            zsh_inst_folder="/usr/share/zsh"

            sw_btop="btop"
            sw_fd="fd"
            sw_fdzshcompletion=""
            sw_fzftmux=""
            sw_fzfzshcompletion=""
            sw_rgzshcompletion=""
            sw_shellcheck="ShellCheck"
            sw_vifmcolors=""
            sw_vimdata=""
            ;;
        "alpine")
            pkgmgr="apk"
            pkginst="apk add"
            repo_flag="alpine"
            zsh_inst_folder="/usr/share/zsh"

            sw_btop=""
            sw_fd="fd"
            sw_fdzshcompletion="fd-zsh-completion"
            sw_fzftmux="fzf-tmux"
            sw_fzfzshcompletion="fzf-zsh-completion"
            sw_rgzshcompletion=""
            sw_shellcheck=""
            sw_vifmcolors=""
            sw_vimdata=""
            ;;
        "macOS")
            pkgmgr="brew"
            pkginst="brew bundle install"
            repo_flag="macOS"
            zsh_inst_folder="/usr/share/zsh"
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

    # sw_vers gives macos os name and version, ergo we can get the hostname from sysctl
    elif [ -d "/usr/bin/sw_vers" ]; then
        current_host="$(sysctl hw.model)"

    # WT_SESSION environment variable available in WSL1 and WSL2
    elif [ "${wslsession}" ]; then 
        current_host="Windows Subsystem for Linux"

    # If none of the above
    else
        current_host="None"
    fi
}

functionInstallRepositories() 
{
    functionPrintMessage privilege_root repositories

    case "${repo_flag}" in
        "opensuse-tumbleweed")
            (su -c "
                rpm --import https://packages.microsoft.com/keys/microsoft.asc ;
                zypper ar https://packages.microsoft.com/yumrepos/vscode vscode ;
                zypper ar https://rpm.librewolf.net/librewolf-repo.repo ;
                zypper --gpg-auto-import-keys ref
                ")
                # Last command is the same as "zypper refresh" but also accepts automatically keys
            ;;

        *)
            printf '%s\n' "No repository to add."
            ;;
    esac

    functionPrintMessage printsleep
}

functionInstallPackages() 
{
    functionPrintMessage privilege_root packages

    case "${current_host}" in
        "LENOVO ThinkPad X230 - 23252FG")
            case "${XDG_SESSION_DESKTOP}" in
                "KDE")
                    (su -c "${pkginst} ${packages_terminal} ${packages_kde_basics} ${packages_kde_personal} ${packages_x230}");
                    ;;
                *)
                    (su -c "${pkginst} ${packages_terminal}");
                    ;;
            esac
            ;;
        "Windows Subsystem for Linux")
            (su -c "${pkginst} ${packages_terminal}");

            if [ "${ID}" = "opensuse-tumbleweed" ]; then (su -c "${pkginst} -t pattern ${packages_wsl_pattern}"); fi
            ;;
        "iOS/iPadOS")
            "${pkginst} ${packages_terminal} ${packages_ish}"
            ;;
        "MacBook9,2")
            "${pkginst} --file=${dir_dotroot}/INSTALL/Brewfile"
            ;;
        *)
            case "${XDG_SESSION_DESKTOP}" in
                "KDE")
                    (su -c "${pkginst} ${packages_terminal} ${packages_kde_basics}");
                    ;;
                *) ;;
            esac
    esac

    functionPrintMessage printsleep
}

functionInstallFixes() 
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
    case "${ID}" in
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

functionInstallFonts() 
{
    functionPrintMessage privilege_user fonts

    if [ ! -d "${HOME}/.fonts" ] ; then mkdir -p "${HOME}/.fonts" ; fi
    if [ ! -d "${dir_cache}" ] ; then mkdir -p "${dir_cache}" ; fi

    if [ "$(curl -is "${url_nerdfonts}" | head -n 1)" = "HTTP/2 404" ] ; then
        for dl_fonts in $(ls "${dir_dotroot}/INSTALL/fonts/*.tar.xz")
        do
            tar -xvf "${dir_dotroot}/INSTALL/fonts/${dl_fonts}" --directory "${HOME}/.fonts"
        done
    else
        for dl_fonts in ${packages_fonts}
        do
            curl -L $(curl -s "${url_nerdfonts}" | grep browser_download_url | cut -d '"' -f 4 | grep "${dl_fonts}") --output "${dir_cache}/${dl_fonts}"
            tar -xvf "${dir_cache}/${dl_fonts}" --directory "${HOME}/.fonts"
            rm "${dir_cache}/${dl_fonts}"
        done
    fi

    rm "${HOME}/.fonts/LICENSE"
    rm "${HOME}/.fonts/readme.md"
    rm "${HOME}/.fonts/README.md"

    functionPrintMessage printsleep
}

functionInstallSymlinks() 
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
    ln -vsf "${dir_dotroot}/config/zsh/zshrc"   "${HOME}/.zshrc"
    ln -vsf "${dir_dotroot}/config/vim/vimrc"   "${HOME}/.vimrc"

    # Directories
    ln -vsf "${dir_dotroot}/config/vim"         "${HOME}/.vim"
    ln -vsf "${dir_dotroot}/config/vifm"        "${HOME}/.config/vifm"
    ln -vsf "${dir_dotroot}/config/fastfetch"   "${HOME}/.config/fastfetch"
    ln -vsf "${dir_dotroot}/config/tmux"        "${HOME}/.config/tmux"
    ln -vsf "${dir_dotroot}/config/fd"          "${HOME}/.config/fd"
    ln -vsf "${dir_dotroot}/config/mc"          "${HOME}/.config/mc"

    functionPrintMessage printsleep
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

functionInstallGitSubmodules() 
{
    functionPrintMessage privilege_user syncgitsubmodule

    # A repository with submodules already added must be initiated.
    (cd "${dir_dotroot}" && git submodule update --init --recursive) && printf '%s\n' "" "Submodules updated" ""

    functionPrintMessage printsleep
}

functionConfigVimHelptags() 
{
    functionPrintMessage privilege_user vimhelptags

    vim -u NONE -c helptags "${dir_dotroot}/config/vim/pack/plugins/start/vim-airline/doc" -c q
    vim -u NONE -c helptags "${dir_dotroot}/config/vim/pack/plugins/start/vim-airline-themes/doc" -c q
    vim -u NONE -c helptags "${dir_dotroot}/config/vim/pack/plugins/start/surround/doc" -c q
    vim -u NONE -c helptags "${dir_dotroot}/config/vim/pack/plugins/start/commentary/doc" -c q
    vim -u NONE -c helptags "${dir_dotroot}/config/vim/pack/plugins/start/fugitive/doc" -c q
    vim -u NONE -c helptags "${dir_dotroot}/config/vim/pack/plugins/start/undotree/doc" -c q
    vim -u NONE -c helptags "${dir_dotroot}/config/vim/pack/plugins/start/fzf/doc" -c q
    vim -u NONE -c helptags "${dir_dotroot}/config/vim/pack/plugins/start/fzf-vim/doc" -c q
    vim -u NONE -c helptags "${dir_dotroot}/config/vim/pack/plugins/start/goyo.vim/doc" -c q
    vim -u NONE -c helptags "${dir_dotroot}/config/vim/pack/plugins/start/vim-highlightedyank/doc" -c q
    vim -u NONE -c helptags "${dir_dotroot}/config/vim/pack/plugins/start/vim-better-whitespace/doc" -c q
    vim -u NONE -c helptags "${dir_dotroot}/config/vim/pack/plugins/start/vim-indent-guides/doc" -c q

    functionPrintMessage printsleep
}

functionConfigShell() 
{
    functionPrintMessage privilege_user zshshell

    printf '%s\n' "Current shell: ${SHELL}"

    # Check if running shell is ZSH.
    if [ "${SHELL}" != "/usr/bin/zsh" ] ; then
        # Check if ZSH is installed.
        if [ ! -f "${zsh_inst_folder}" ] ; then
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
                (su -c "${pkginst}" "zsh")
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
    (cd "${dir_dotroot}" &&
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
        git submodule add https://github.com/lervag/vimtex                      config/vim/pack/plugins/start/vimtex
        git submodule add https://github.com/yegappan/lsp                       config/vim/pack/plugins/start/lsp
    )

    cd "${previous_pwd}"

    functionPrintMessage printsleep
}
