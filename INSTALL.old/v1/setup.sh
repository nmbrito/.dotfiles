#!/bin/sh

# File: cli-install.sh
# Description: semi-automatic personal installer

# Init systems
# -----------------
#   Run script from any directory
    dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

#   Vars
    #dir_dotrepo="${HOME}/.dotfiles"
    dir_dotroot="$(git rev-parse --show-toplevel)"
    dir_cache="${HOME}/.cache"
    url_nerdfonts="https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest"

    message_longwarn="###########################################"
    message_longdash="----------------------"
    message_execroot="# The following commands will run as ROOT #"

#   Source components
    . /etc/os-release

    if [ ! -f "${dir}"/functions.sh ] && [ ! -f "${dir}"/software.sh ]; then
        printf '%s\n' "Missing install components. Aborting."
        exit 0
    fi

#   Source file containing functions.
    . "${dir}"/functions.sh

#   Defines the package manager and software especific to the running distribution.
    func_def_distro

#   Define current host
    func_def_host

#   Source file containing software list.
#   This needs to be here so it can load after the /func_def_distro/ function.
    . "${dir}"/software.sh

# Main
# ----
printf '%s\n'   "" \
                "Starting process" \
                "${message_longdash}" \
                "" \
                "Current distro: ${ID}"

# Call function
while :
do
    printf '%s\n'   "" \
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
                    "|--------------------------------------------------------------|"
    func_get_info
    printf '%s\n'   "|--------------------------------------------------------------|" \
                    "|  ( ) Exit / Cancel                                           |" \
                    "|--------------------------------------------------------------|" \
                    ""

    printf '%s' "Option: "
    read -r option_picked

    printf '%s\n' ""

    case "${option_picked}" in
        1)
            func_inst_fixes
            func_inst_repository
            func_inst_software
            func_inst_fonts
            func_inst_symlinks
            #func_inst_gitglobals
            func_inst_gitsubmodules
            func_inst_vimhelptags
            func_inst_changeshell
            ;;

        2)
            func_inst_fixes ;;

        3)
            func_inst_repository ;;

        4)
            func_inst_software ;;

        5)
            func_inst_fonts ;;

        6)
            func_inst_symlinks ;;

        7)
            func_inst_gitglobals ;;

        8)
            func_inst_gitsubmodules ;;

        9)
            func_inst_vimhelptags ;;

        10)
            func_inst_changeshell ;;

        r)
            func_inst_rebuild_gitsubmodules ;;

        *)
            printf '%s\n'   "Exiting..." \
                            ""
            exit 0
            ;;
    esac
done

