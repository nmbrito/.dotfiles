#!/bin/sh

# File: home_functions.sh
# Description: functions for home_setup.sh

func_def_distro() #{{{1
{
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
            sw_vifmcolors="vifm-colors"
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
    # The dmi directory indicates a physical machine.
    if [ -d "/sys/devices/virtual/dmi" ]
    then
        current_host="$(cat /sys/devices/virtual/dmi/id/board_vendor) $(cat /sys/devices/virtual/dmi/id/product_version) - $(cat /sys/devices/virtual/dmi/id/product_name)"

    # The ish directory is only available on Apple devices because of the iSH.app application
    elif [ -d "/proc/ish" ]
    then
        current_host="iOS/iPadOS"

    # The environment variable WT_SESSION is only encountered when using WSL1 and WSL2
    elif [ -n "${WT_SESSION}" ]
    then
        current_host="Windows Subsystem for Linux"

    # If everything else fails, current host might as well be something
    else
        current_host="None"
    fi
}

func_get_info() #{{{1
{
    printf '%s\n'   "|  Host: ${current_host}           " \
                    "|  Distribuition: ${ID}            " \
                    "|  Package manager: ${pkgmgr}      " \
                    "|  Current shell: ${SHELL}         " \
                    "|  PWD: $(pwd)                     " \
                    "|  Repository root: ${dir_dotroot} "
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
                printf '%s\n' "Changing shell replacing ash with zsh in /etc/passwd"
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
                zypper refresh ;
                ")
            ;;

        "debian")
            printf '%s\n' "No repository to add."
            ;;

        "archlinux")
            printf '%s\n' "No repository to add."
            ;;

        "almalinux")
            printf '%s\n' "No repository to add."
            ;;

        "alpine")
            printf '%s\n' "No repository to add."
            ;;

        *)
            printf '%s\n' "Distribuition not found"
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
    # We'll do this by hosts, if none is detected then we'll verify what session desktop is running
    case ${current_host} in
        "LENOVO ThinkPad X230 - 23252FG")
            if [ "${XDG_SESSION_DESKTOP}" = "KDE" ]
            then
                su -c ${pkginst} ${list_terminal} ${list_kde_basics} ${list_kde_personal} ${list_x230}
            else
                su -c ${pkginst} ${list_terminal} ${list_kde_basics} ${list_kde_personal}
            fi
            ;;

        "Windows Subsystem for Linux")
            (su -c "
                ${pkginst} ${list_terminal} ;
                ${pkginst} -t ${list_wsl_pattern} ;
                ")
            ;;

        "iOS/iPadOS")
            # Alpine in iSH runs as ROOT!
            ${pkginst} ${list_terminal}
            ;;

        # TODO: SSH Sessions
        # "SSH Session")
        # ;;

        *)
            # Let's install generic stuff
            # For now only KDE
            # TODO: Gnome, XFCE, etc.
            # TODO: Maybe even put in case if
            if [ "${XDG_SESSION_DESKTOP}" = "KDE" ]
            then
                su -c ${pkginst} ${list_terminal} ${list_kde_basics}
            fi
            ;;
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
    # If .fonts directory doesn't exist, create one.
    if [ ! -d "${HOME}/.fonts" ]
    then
        mkdir -p "${HOME}/.fonts"
    fi

    # Same principle as above, directory doesn't exist? Create one.
    if [ ! -d "${dir_cache}" ]
    then
        mkdir -p "${dir_cache}"
    fi

    # This checks if the nerdfonts url is down.
    # It'll use a nerdfont present in the font directory as a last resort.
    # Otherwise grab it from the url.
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

    # Files
    ln -vsf "${dir_dotroot}"/config/zsh/zshrc   "${HOME}"/.zshrc
    ln -vsf "${dir_dotroot}"/config/vim/vimrc   "${HOME}"/.vimrc

    # Directories
    ln -vsf "${dir_dotroot}"/config/vim         "${HOME}"/.vim
    ln -vsf "${dir_dotroot}"/config/vifm        "${HOME}"/.config/vifm
    ln -vsf "${dir_dotroot}"/config/neofetch    "${HOME}"/.config/neofetch
    ln -vsf "${dir_dotroot}"/config/tmux        "${HOME}"/.config/tmux

    # Only if KDE is detected as a current session
    if [ "${XDG_SESSION_DESKTOP}" = "KDE" ]
    then
        # KDE configuration files must be copied, with symlinks KDE can't save settings
        cp -v "${dir_dotroot}"/config/plasma/kglobalshortcutsrc                     	"${HOME}"/.config/
        cp -v "${dir_dotroot}"/config/plasma/kwinrc                                 	"${HOME}"/.config/
        cp -v "${dir_dotroot}"/config/plasma/plasma-localerc                            "${HOME}"/.config/
        cp -v "${dir_dotroot}"/config/plasma/plasma-org.kde.plasma.desktop-appletsrc	"${HOME}"/.config/
        cp -v "${dir_dotroot}"/config/plasma/plasmashellrc                          	"${HOME}"/.config/
        cp -v "${dir_dotroot}"/config/plasma/powermanagementprofilesrc                  "${HOME}"/.config/
        cp -v "${dir_dotroot}"/config/strawberry/strawberry.conf                        "${HOME}"/.config/strawberry

        cp -v "${dir_dotroot}"/config_local/share/konsole/mytik.profile             	"${HOME}"/.local/share/konsole/
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

    # When cloning a repository with submodules already added, they aren't initiated. That's why --init and --recursive are there.
    # git submodule add repository_url not only adds to the .gitmodules but also downloads all the content.
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

    # I couldn't remember why I wrote this.
    # But then I did so I might as well write this in here.
    #
    # 1 - Verify if current shell running is ZSH, else just say you already have it running;
    # 2 - Verify if ZSH is installed testing the zsh folder existence;
    # 3 - If the folder exists, install or give error if something happens. Else just warn to install ZSH.
    # TODO: Maybe ask to install it after showing error and re-call function to change shell? Hmmm...
    if [ "${SHELL}" != "/usr/bin/zsh" ]
    then
        if [ ! -f "${zsh_inst_folder}" ]
        then
            chsh -s "$(which zsh)" && printf '%s\n' "Shell changed to ZSH" || printf '%s\n' "ERROR: Shell not changed"
        else
            printf '%s\n' "Error. Install ZSH to change shell."
        fi
    else
        printf '%s\n' "Shell is already ZSH"
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
