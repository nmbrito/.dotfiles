# Global
alias lsd="ls -slaF --color=auto"                                       # Lists with -sla (with hidden folders and more)
alias sld="ls -sl --color=auto"                                         # Lists with -sl (no hidden folders)
alias cd.="cd ${path_dotrepo}"                                          # Changes to .dotfiles directory
alias cat="bat"                                                         # Subs cat for bat
alias catalias="bat ${path_dotrepo}/config/zsh/zshrc-alias.zsh"         # Cats my alias
#alias catalias="cat ${path_dotrepo}/config/zsh/zshrc-alias.zsh | less"  # Cats my alias
alias reload=". ${HOME}/.zshrc"                                         # reloads zshrc config
alias vis="vim -S ${path_vimsessions}/current_session.vim"              # Loads vim current session
function shcheck() { shellcheck "$1" -x --color | less -r }             # Shellcheck with color and less active

# Backup KDE Plasma Settings
function backupkde()
{
    # Files in .config
    cp -v "${HOME}/.config/kglobalshortcutsrc"                      "${path_dotrepo}/config/plasma/"    # Keyboard shortcuts
    cp -v "${HOME}/.config/kwinrc"                                  "${path_dotrepo}/config/plasma/"    # Kwin effects
    cp -v "${HOME}/.config/plasma-localerc"                         "${path_dotrepo}/config/plasma/"    # All locale PT
    cp -v "${HOME}/.config/plasma-org.kde.plasma.desktop-appletsrc" "${path_dotrepo}/config/plasma/"    # Applets in panels
    cp -v "${HOME}/.config/plasmashellrc"                           "${path_dotrepo}/config/plasma/"    #
    cp -v "${HOME}/.config/powermanagementprofilesrc"               "${path_dotrepo}/config/plasma/"    # Energy profiles
    cp -v "${HOME}/.config/strawberry/strawberry.conf"              "${path_dotrepo}/config/strawberry" # Strawberry

    # Files in .local
    cp -v "${HOME}/.local/share/konsole/mytik.profile"  "${path_dotrepo}/config_local/share/konsole/mytik.profile"  # Konsole profile

    # Folders
    cp -rv "${HOME}/.config/kdedefaults"                             "${path_dotrepo}/config/plasma/"

    # Themes
    tar czvf ${path_dotrepo}/.cache/plasma_globalthemes.tar.gz \
        ${HOME}/.local/share/plasma \
        ${HOME}/.local/share/color-schemes \
        ${HOME}/.local/share/icons \
        --wildcards ${HOME}/.local/share/konsole/*.colorscheme \
        ${HOME}/.local/share/kwin \
        ${HOME}/.local/share/wallpapers \
}

# GIT
alias gitsubup="git submodule update --remote"                              # Updates git submodules
alias gitsubstat="git submodule status"                                     # Updates git submodules
alias gitorig="git remote -v"                                               # Verify repository origin
alias gituok="git status"                                                   # Git status
alias gitusync="git remote show origin"                                     # Informs if local repository is up to date with remote

function gitunicom()        # Add and comment individual files
{
    for file in $(git status --porcelain | cut -b 4-)
    do
        echo "${file}"
        git add "$(git rev-parse --show-toplevel)/${file}"
        printf '%s' "Enter comment: "
        read -r comments
        git commit -m "${comments}"
    done
    git push
}

function gitquickcom()      # Add and comment individual files
{
    for file in $(git status --porcelain | cut -b 4-)
    do
        echo "${file}"
        git add "$(git rev-parse --show-toplevel)/${file}"
        git commit -m "Updated ${file}."
    done
    git push
}

function gitquickcompt()    # Add and comment individual files
{
    for file in $(git status --porcelain | cut -b 4-)
    do
        echo "${file}"
        git add "$(git rev-parse --show-toplevel)/${file}"
        git commit -m "${file} atualizado."
    done
    git push
}

# Windows Subsystem for Linux
if [ -n "${WT_SESSION}" ] ; then
    alias explore="explorer.exe ."                                      # Opens current directory in windows explorer
fi

# Distro dependent
case ${ID} in
    "archlinux")
        alias pacup="sudo pacman -Syu"                                  # Perform system update
        alias pacin="sudo pacman -S"                                    # Installs package
        alias pacquery="sudo pacman -Qqs"                               # Search local package with no description
        alias pacdepless="sudo pacman -R $(pacman -Qdtq)"               # Remove unecessary dependencies
        ;;

    "opensuse-tumbleweed")
        alias zypdup="sudo zypper dup"                                  # Perform distro upgrade
        alias zypup="sudo zypper up"                                    # Update software
        alias zypfind="sudo zypper search"                              # Search packages
        alias zypfindv="sudo zypper search -s"                          # Search packages version
        alias zypin="sudo zypper in --no-recommends"                    # Install packages
        alias zypinrec="sudo zypper in"                                 # Install packages without recommendations
        alias zyprem="sudo zypper rm"                                   # Remove packages
        alias zypremu="sudo zypper rm --clean-deps"                     # Remove package and cleans unneeded dependencies
        alias zypinfo="zypper info"                                     # Package information
        alias zypfindupa="sudo zypper pa --unneeded"                    # Find unneed packages
        ;;

    "alpine")
        alias alpin="apk add"                                           # Install package
        alias alpfix="apk fix"                                          # Fixes packages install
        alias alpforcefix="apk fix --force-overwrite"                   # Forces the overwrite
        ;;

    *)
        ;;
esac

