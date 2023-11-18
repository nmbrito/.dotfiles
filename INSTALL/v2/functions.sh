#!/bin/sh

# File: home_functions.sh
# Description: functions for home_setup.sh

func_build_menu() #{{{1
{
    printf '%s\n'   "                                                                " \
                    "|--------------------------------------------------------------|" \
                    "| Select an option:                                            |" \
                    "|--------------------------------------------------------------|" \
                    "|  ( 1) RUN ALL                 |  ( 6) Symlinks               |" \
                    "|  ( 2) Host fixes              |  ( 7) Configure git globals  |" \
                    "|  ( 3) Repositories            |  ( 8) Sync git submodules    |" \
                    "|  ( 4) Software                |  ( 9) Link VIM helptags      |" \
                    "|  ( 5) Fonts                   |  (10) ZSH shell change       |" \
                    "|--------------------------------------------------------------|" \
                    "|  ( r) Rebuild git submodules                                 |" \
                    "|--------------------------------------------------------------|" \
                    "|  Host: ${current_host}                                        " \
                    "|  Distribuition: ${ID}                                         " \
                    "|  Package manager: ${pkgmgr}                                   " \
                    "|  Current shell: ${SHELL}                                      " \
                    "|  PWD: $(pwd)                                                  " \
                    "|  Repository root: ${dir_dotroot}                              " \
                    "|--------------------------------------------------------------|" \
                    "|  ( ) Exit / Cancel                                           |" \
                    "|--------------------------------------------------------------|" \
                    "                                                                "
}

func_def_distro() #{{{1
{
    # Distribuitions have different package names and software paths.
    case ${ID} in
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
            sw_shellcheck=""
            sw_vifmcolors=""
            sw_vimdata=""
            ;;

        *)
            printf '%s\n'   "This script doesn't support distribuition: ${ID}" \
                            "Exiting."
            exit 0
            ;;

    esac
}

func_def_host() #{{{1
{
    # dmi directory indicates a physical machine.
    if [ -d "/sys/devices/virtual/dmi" ]
    then
        current_host="$(cat /sys/devices/virtual/dmi/id/board_vendor) $(cat /sys/devices/virtual/dmi/id/product_version) - $(cat /sys/devices/virtual/dmi/id/product_name)"

    # ish directory is only available on Apple devices running iSH.app
    elif [ -d "/proc/ish" ] ; then current_host="iOS/iPadOS" ;

    # WT_SESSION environment variable available in WSL1 and WSL2
    elif [ -n "${WT_SESSION}" ] ; then current_host="Windows Subsystem for Linux" ;

    # Last resort to fill current_host instead of garbage
    else current_host="None" ;
    fi
}

func_inst_fixes() #{{{1
{
    printf '%s\n'   "Computer Fixes" \
                    "${message_longdash}" \
                    "Found: ${current_host}" \
                    ""

    printf '%s\n'   "${message_longwarn}" "${message_execroot}" "${message_longwarn}" \
                    ""

    case "${current_host}" in
        "LENOVO ThinkPad X230 - 23252FG")
            printf '%s\n' "Installing Fingerprint"

            su -c "${pkginst} fprintd fprintd-pam libfprint"

            if [ "${XDG_SESSION_DESKTOP}" = "KDE" ]
            then
                (su -c "
                    touch /etc/pam.d/sddm ;
                    echo '#%PAM-1.0' >> /etc/pam.d/sddm ;
                    echo 'auth    [success=1 new_authtok_reqd=1 default=ignore]   pam_unix.so try_first_pass likeauth nullok' >> /etc/pam.d/sddm ;
                    echo 'auth    sufficient      pam_fprintd.so' >> /etc/pam.d/sddm ;

                    touch /etc/pam.d/kde ;
                    echo 'auth 			sufficient  	pam_unix.so try_first_pass likeauth nullok' >> /etc/pam.d/kde ;
                    echo 'auth 			sufficient  	pam_fprintd.so' >> /etc/pam.d/kde ;

                    pam-auth-update ;
                    ")

                # TODO: For some abnormal reason I can't get this crap to work, everytime the SDDM pam.d file is written I get locked out of the system
                #       till I remove it via TTY0...
                #
                # fprintd-enroll        -> enroll via terminal
                # fprintd-enroll user   -> enroll a user via terminal without authentication
                # fprintd-verify        -> verify newly created fingerprint
                #
                # $ fprintd-delete "$USER"                                                                                              -> multi finger enroll
                # $ for finger in {left,right}-{thumb,{index,middle,ring,little}-finger}; do fprintd-enroll -f "$finger" "$USER"; done  -> multi finger enroll
            fi
            ;;

        "iOS/iPadOS")
                printf '%s\n' "Replacing ash with zsh in /etc/passwd file, close and re-open iSH to apply."
                sed -i 's/ash/zsh/g' /etc/passwd
            ;;

        *)
            printf '%s\n' "No fix to apply."
            ;;

    esac

    printf '%s\n' ""

    sleep 3s
}

func_inst_repository() #{{{1
{
    printf '%s\n'   "Repositories" \
                    "${message_longdash}" \
                    ""

    printf '%s\n'   "${message_longwarn}" "${message_execroot}" "${message_longwarn}" \
                    ""

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

    printf '%s\n' ""

    sleep 3s
}

func_inst_software() #{{{1
{
    printf '%s\n'   "Software" \
                    "${message_longdash}" \
                    ""

    printf '%s\n'   "${message_longwarn}" "${message_execroot}" "${message_longwarn}" \
                    ""

    # Install packages using current_host as a filter
    case ${current_host} in
        "LENOVO ThinkPad X230 - 23252FG")
            case ${XDG_SESSION_DESKTOP} in
                "KDE")
                    (su -c "${pkginst} ${list_terminal} ${list_kde_basics} ${list_kde_personal} ${list_x230}") ;;
                *)
                    (su -c "${pkginst} ${list_terminal}") ;;

        "Windows Subsystem for Linux")
            (su -c "${pkginst} ${list_terminal}") ;
                if [ "${ID}" = "opensuse-tumbleweed" ] ; then (su -c "${pkginst} -t pattern ${list_wsl_pattern}") ; fi
            ;;

        "iOS/iPadOS")
            # Alpine in iSH runs as ROOT!
            ${pkginst} ${list_terminal}
            ${pkginst} ${list_ish}
            ;;

        # TODO: SSH Sessions
        # "SSH Session")
        # ;;

        *)
            # This section installs packages from generic lists since no host was defined
            # KDE only
            # TODO: Gnome, XFCE, etc.
            # TODO: Replace "if" with "case switch"
            case ${XDG_SESSION_DESKTOP} in
                "KDE")
                    (su -c "${pkginst} ${list_terminal} ${list_kde_basics}") ;;
                *) ;;
    esac

    printf '%s\n' ""

    sleep 3s
}

func_inst_fonts() #{{{1
{
    printf '%s\n'   "Fonts" \
                    "${message_longdash}" \
                    ""
    # Download fonts, or get them locally, extract and copy to ~/.fonts
    # Directory creation
    if [ ! -d "${HOME}/.fonts" ] ; then mkdir -p "${HOME}/.fonts" ; fi
    if [ ! -d "${dir_cache}" ] ; then mkdir -p "${dir_cache}" ; fi

    # This checks if the nerdfonts url is down.
    # It'll use a nerdfont present in the font directory as a last resort.
    # Otherwise it'll download from url.
    if [ "$(curl -is "${url_nerdfonts}" | head -n 1)" = "HTTP/2 404" ]
    then
        for dl_fonts in $(ls ${dir_dotroot}/fonts/*.tar.xz)
        do
            tar -xvf "${dir_dotroot}/fonts/${dl_fonts}" --directory "${HOME}/.fonts"
        done
    else
        for dl_fonts in ${list_fonts}
        do
            # This uses the github latest version url.
            # Since the files have versions included in the name, we must grep the browser download url, cut the excess and grep again with the names in the list.
            curl -L $(curl -s "${url_nerdfonts}" | grep browser_download_url | cut -d '"' -f 4 | grep "${dl_fonts}") --output "${dir_cache}/${dl_fonts}"
            tar -xvf "${dir_cache}/${dl_fonts}" --directory "${HOME}/.fonts"
            rm "${dir_cache}/${dl_fonts}"
        done
    fi

    rm "${HOME}"/.fonts/LICENSE*
    rm "${HOME}"/.fonts/readme*
    rm "${HOME}"/.fonts/README*

    printf '%s\n' ""

    sleep 3s
}

func_inst_symlinks() #{{{1
{
    printf '%s\n'   "Symlinking" \
                    "${message_longdash}" \
                    ""

    [ -d "${HOME}"/.vim ]               && rm -rf "${HOME}"/.vim
    [ -d "${HOME}"/.config/vifm ]       && rm -rf "${HOME}"/.config/vifm
    [ -d "${HOME}"/.config/neofetch ]   && rm -rf "${HOME}"/.config/neofetch
    [ -d "${HOME}"/.config/tmux ]       && rm -rf "${HOME}"/.config/tmux
    [ -d "${HOME}"/.config/nnn ]        && rm -rf "${HOME}"/.config/nnn

    # Files.
    ln -vsf "${dir_dotroot}"/config/zsh/zshrc   "${HOME}"/.zshrc
    ln -vsf "${dir_dotroot}"/config/vim/vimrc   "${HOME}"/.vimrc

    # Directories.
    ln -vsf "${dir_dotroot}"/config/vim         "${HOME}"/.vim
    ln -vsf "${dir_dotroot}"/config/vifm        "${HOME}"/.config/vifm
    ln -vsf "${dir_dotroot}"/config/neofetch    "${HOME}"/.config/neofetch
    ln -vsf "${dir_dotroot}"/config/tmux        "${HOME}"/.config/tmux
    ln -vsf "${dir_dotroot}"/config/nnn         "${HOME}"/.config/nnn

    # If KDE is detected as current session.
    if [ "${XDG_SESSION_DESKTOP}" = "KDE" ]
    then
        # KDE configuration files must be copied.
        # KDE is unable to save settings with symlinks.
        cp -v "${dir_dotroot}"/config/plasma/kglobalshortcutsrc                     	"${HOME}"/.config/
        cp -v "${dir_dotroot}"/config/plasma/kwinrc                                 	"${HOME}"/.config/
        cp -v "${dir_dotroot}"/config/plasma/plasma-localerc                            "${HOME}"/.config/
        cp -v "${dir_dotroot}"/config/plasma/plasma-org.kde.plasma.desktop-appletsrc	"${HOME}"/.config/
        cp -v "${dir_dotroot}"/config/plasma/plasmashellrc                          	"${HOME}"/.config/
        cp -v "${dir_dotroot}"/config/plasma/powermanagementprofilesrc                  "${HOME}"/.config/
        cp -v "${dir_dotroot}"/config/strawberry/strawberry.conf                        "${HOME}"/.config/strawberry

        cp -v "${dir_dotroot}"/config_local/share/konsole/mytik.profile             	"${HOME}"/.local/share/konsole/

        cp -v "${dir_dotroot}"/config/plasma/new/konsolerc                                  "${HOME}"/.config/
        cp -v "${dir_dotroot}"/config/plasma/new/dolphinrc                                  "${HOME}"/.config/
        cp -v "${dir_dotroot}"/config/plasma/new/kdeglobals                                 "${HOME}"/.config/
        cp -v "${dir_dotroot}"/config/plasma/new/kmixrc                                     "${HOME}"/.config/
        cp -v "${dir_dotroot}"/config/plasma/new/ksplashrc                                  "${HOME}"/.config/
        cp -v "${dir_dotroot}"/config/plasma/new/ktimezonedrc                               "${HOME}"/.config/
    fi

    printf '%s\n' ""

    sleep 3s
}

func_inst_gitglobals() #{{{1
{
    printf '%s\n'   "Git globals configuration." \
                    ""

    printf '%s'     "user.email: "
    read -r git_user_email
    printf '%s\n'   ""
    git config --global user.email "${git_user_email}"

    printf '%s\n'   ""

    printf '%s'     "user.name: "
    read -r git_user_name
    printf '%s\n'   ""
    git config --global user.name "${git_user_name}"

    sleep 3s
}

func_inst_gitsubmodules() #{{{1
{
    printf '%s\n'   "Syncing git submodules" \
                    "${message_longdash}" \
                    ""

    # A repository with submodules already added must be initiated.
    (cd "${dir_dotroot}" && git submodule update --init --recursive) && printf '%s\n' "" "Submodules updated" ""

    printf '%s\n' ""

    sleep 3s
}

func_inst_vimhelptags() #{{{1
{
    printf '%s\n'   "Linking VIM Helptags" \
                    "${message_longdash}" \
                    ""

    vim -u NONE -c "helptags ${dir_dotroot}/config/vim/pack/dist/start/vim-airline/doc" -c q
    vim -u NONE -c "helptags ${dir_dotroot}/config/vim/pack/dist/start/vim-airline-themes/doc" -c q
    vim -u NONE -c "helptags ${dir_dotroot}/config/vim/pack/tpope/start/surround/doc" -c q
    vim -u NONE -c "helptags ${dir_dotroot}/config/vim/pack/tpope/start/commentary/doc" -c q
    vim -u NONE -c "helptags ${dir_dotroot}/config/vim/pack/tpope/start/fugitive/doc" -c q
    vim -u NONE -c "helptags ${dir_dotroot}/config/vim/pack/mbbill/start/undotree/doc" -c q
    vim -u NONE -c "helptags ${dir_dotroot}/config/vim/pack/junegunn/start/fzf/doc" -c q
    vim -u NONE -c "helptags ${dir_dotroot}/config/vim/pack/junegunn/start/fzf-vim/doc" -c q
    vim -u NONE -c "helptags ${dir_dotroot}/config/vim/pack/junegunn/start/goyo.vim/doc" -c q
    vim -u NONE -c "helptags ${dir_dotroot}/config/vim/pack/machakann/start/vim-highlightedyank/doc" -c q
    vim -u NONE -c "helptags ${dir_dotroot}/config/vim/pack/ntpeters/start/vim-better-whitespace/doc" -c q
    vim -u NONE -c "helptags ${dir_dotroot}/config/vim/pack/preservim/start/vim-indent-guides/doc" -c q

    printf '%s\n'   "" \
                    "VIM Helptags linked" \
                    ""

    sleep 3s
}

func_inst_changeshell() #{{{1
{
    printf '%s\n'   "Changing to ZSH" \
                    "${message_longdash}" \
                    ""

    printf '%s\n' "Current shell: ${SHELL}"

    # Check if running shell is ZSH.
    if [ "${SHELL}" != "/usr/bin/zsh" ]
    then
        # Check if ZSH is installed.
        if [ ! -f "${zsh_inst_folder}" ]
        then
            # iSH uses a different method for shell changing.
            if [ "${current_host}" = "iOS/iPadOS" ]
            then
                sed -i 's/ash/zsh/g' /etc/passwd && printf '%s\n' "Replaced ash with zsh in /etc/passwd file, close and re-open iSH to apply."
            else
                # Change the shell
                chsh -s "$(which zsh)" && printf '%s\n' "Shell changed to ZSH." || printf '%s\n' "ERROR: Shell not changed."
            fi
        else
            printf '%s\n' "ZSH missing. Want to install? [y/n]: "
            read  -r optionzshchange
            if [ "${optionzshchange}" = "y" ]
            then
                ${pkginst} "zsh"
                func_inst_changeshell
            fi
        fi
    else
        printf '%s\n' "ZSH already running."
    fi

    printf '%s\n' ""

    sleep 3s
}

func_inst_rebuild_gitsubmodules() #{{{1
{
    printf '%s\n'   "Rebuilding git submodules" \
                    "${message_longdash}" \
                    ""
    previous_pwd="$(pwd)"

    # NOTE: submodule path is relative to root repository.
    (cd ${dir_dotroot} &&
        git submodule add https://github.com/romkatv/powerlevel10k              config/zsh/plugins/powerlevel10k
        git submodule add https://github.com/zsh-users/zsh-syntax-highlighting  config/zsh/plugins/zsh-syntax-highlighting
        git submodule add https://github.com/zsh-users/zsh-autosuggestions      config/zsh/plugins/zsh-autosuggestions
        git submodule add https://github.com/vim-airline/vim-airline            config/vim/pack/dist/start/vim-airline
        git submodule add https://github.com/vim-airline/vim-airline-themes     config/vim/pack/dist/start/vim-airline-themes
        git submodule add https://github.com/tpope/vim-surround                 config/vim/pack/tpope/start/surround
        git submodule add https://github.com/tpope/vim-commentary               config/vim/pack/tpope/start/commentary
        git submodule add https://github.com/tpope/vim-fugitive                 config/vim/pack/tpope/start/fugitive
        git submodule add https://github.com/junegunn/goyo.vim                  config/vim/pack/junegunn/start/goyo.vim
        git submodule add https://github.com/junegunn/limelight.vim             config/vim/pack/junegunn/start/limelight.vim
        git submodule add https://github.com/junegunn/fzf.vim                   config/vim/pack/junegunn/start/fzf.vim
        git submodule add https://github.com/junegunn/fzf                       config/vim/pack/junegunn/start/fzf
        git submodule add https://github.com/mbbill/undotree                    config/vim/pack/mbbill/start/undotree
        git submodule add https://github.com/machakann/vim-highlightedyank      config/vim/pack/machakann/start/vim-highlightedyank
        git submodule add https://github.com/junegunn/rainbow_parentheses.vim   config/vim/pack/junegunn/start/rainbow_parentheses.vim
        git submodule add https://github.com/preservim/vim-indent-guides        config/vim/pack/preservim/start/vim-indent-guides
        git submodule add https://github.com/ntpeters/vim-better-whitespace     config/vim/pack/ntpeters/start/vim-better-whitespace
        git submodule add https://github.com/ap/vim-css-color                   config/vim/pack/css-color/start/css-color
    )

    cd ${previous_pwd}

    printf '%s\n' ""

    sleep 3s
}
