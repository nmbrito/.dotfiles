# Single line alias
alias ls="eza --header --long --all --group --sort=type --icons=always --git"                   # List directory with bling
alias lsh="eza --header --long --sort=type --icons=always"                                      # List directory with bling minus hidden
alias lst="eza --header --long --tree --level=2 --all --group --sort=type --icons=always --git" # List directory with bling in a tree with 2 levels
alias sl="'ls' -slaF --color=auto"                                                              # Use LS to list directory
alias slh="'ls' -sl --color=auto"                                                               # Use LS to list directory minus hidden

alias cat="bat"                                                                                 # Subs cat for bat
alias reload=". ${HOME}/.zshrc"                                                                 # reloads zshrc config
alias rm.ds="find . -name .DS_Store -print0 | xargs -0 git rm -f --ignore-unmatch"              # Removes .DS_Store in git repository
alias vis="vim -S ${nmb_vimsessions}/current_session.vim"                                       # Loads vim current session

alias cd.="cd ${nmb_dotrepo}"                                                                   # Changes to .dotfiles directory
alias ..="cd .."                                                                                # Changes down one directory
alias ...="cd ../.."                                                                            # Changes down two directories
alias ....="cd ../../.."                                                                        # Changes down three directories
alias .....="cd ../../../.."                                                                    # Changes down four directories

alias susebox="distrobox enter susebox"                                                         # Enter susebox container
alias debianbox="distrobox enter debianbox"                                                     # Enter debianbox container

alias eject1drive="fusermount -u ${HOME}/OneDrive-Pessoal"

alias ompup="oh-my-posh upgrade"                                                                # Upgrade ohmyposh

alias gitsubup="git submodule update --remote"                                                  # Updates submodules
alias gitsubinit="git submodule update --init --recursive"                                      # Initiates all submodules
alias gitk="git status"                                                                         # Informs the status of the repository
alias gitf="git fetch"                                                                          # Verifies if remote branch is newer

alias shcheck="shellcheck $1 -x --color | less -r"
alias gitunicom="sh ${nmb_zshconfig}/alias/zsh_function_GitUniqueCommentsCommit.sh"
#alias gitquickcom="sh ${nmb_zshconfig}/alias/zsh_function_GitQuickCommit.sh"
alias backup_plasma="sh ${nmb_zshconfig}/alias/zsh_function_BackupKDE.sh"

function gitquickcom()
{
    # Add and comment all files
    for file in $(git status --porcelain | cut -b 4-); do
        printf '%s\n' "$file"
        git add "$(git rev-parse --show-toplevel)/${file}"
        git commit -m "Updated ${file}."
    done
    git push
}
