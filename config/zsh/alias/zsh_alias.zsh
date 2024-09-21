# Single line alias
alias ls="eza -hlaas type --icons=always --git" # List directory with bling
alias lsh="eza -hls type --icons=always"        # List directory with bling minus hidden
alias sl="'ls' -slaF --color=auto"              # Use LS to list directory
alias slh="'ls' -sl --color=auto"               # Use LS to list directory minus hidden

alias cat="bat"                                                                     # Subs cat for bat
alias reload=". ${HOME}/.zshrc"                                                     # reloads zshrc config
alias rm.ds="find . -name .DS_Store -print0 | xargs -0 git rm -f --ignore-unmatch"  # Removes .DS_Store in git repository
alias vis="vim -S ${nmb_vimsessions}/current_session.vim"                           # Loads vim current session

alias cd.="cd ${nmb_dotrepo}"   # Changes to .dotfiles directory
alias ..="cd .."                # Changes down one directory
alias ...="cd ../.."            # Changes down two directories
alias ....="cd ../../.."        # Changes down three directories
alias .....="cd ../../../.."    # Changes down four directories

alias susebox="distrobox enter susebox"     # Enter susebox container
alias debianbox="distrobox enter debianbox" # Enter debianbox container

alias gitsubup="git submodule update --remote"              # Updates submodules
alias gitsubinit="git submodule update --init --recursive"  # Initiates all submodules
alias gitk="git status"                                     # Informs the status of the repository
alias gitf="git fetch"                                      # Verifies if remote branch is newer

# Function alias
function shcheck()                          # Shellcheck with color and less active
{
    shellcheck "$1" -x --color | less -r
}

function gitunicom()    # Add and comment individual files
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

function gitquickcom()  # Add and comment all files
{
    for file in $(git status --porcelain | cut -b 4-)
    do
        echo "${file}"
        git add "$(git rev-parse --show-toplevel)/${file}"
        git commit -m "Updated ${file}."
    done
    git push
}

