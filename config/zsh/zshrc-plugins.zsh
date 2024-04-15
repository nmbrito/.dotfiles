# Source plugins
. "${path_dotrepo}/config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
. "${path_dotrepo}/config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
. "${path_dotrepo}/config/zsh/plugins/colored-man-pages/colored-man-pages.plugin.zsh"

# FZF from vim:
# [ -f ~/.fzf.zsh ] && . ~/.fzf.zsh

# FZF
    eval "$(fzf --zsh)"
    if [ "${ID}" = "debian" ] ; then
        fd_app="fd-find"
    else
        fd_app="fd"
    fi
    
    # for more info see fzf/shell/completion.zsh
    _fzf_compgen_path() { $fd_app . "$1" }
    _fzf_compgen_dir() { $fd_app --type d . "$1" }
    
    # fzf's command
    export FZF_DEFAULT_COMMAND="$fd_app --hidden --follow --exclude '.git'"
    
    #FZF_DEFAULT_COMMAND="find . -type d" fzf \
    #    --bind='change:reload(eval $FZF_DEFAULT_COMMAND)' \
    #    --bind='del:execute(rm -ri {})' \
    #    --bind='del:+reload(eval $FZF_DEFAULT_COMMAND)' \
    #    --header='CTRL-R to refresh the list | CTRL-P to toggle the preview | DEL to delete the current directory'
    
    # export FZF_COMPLETION_TRIGGER='**' # Change default trigger
    
    # CTRL-T's command
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    # ALT-C's command
    export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"
    # CTRL-R's command (history previous command)
    # NONE
    
    # Note: toggle preview visibility with ?
    export FZF_DEFAULT_OPTS="
        --layout=reverse
        --info=inline
        --height=80%
        --border=rounded
        --multi
        --preview-window=:hidden
        --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
        --color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
        --prompt=' ' --pointer='▶' --marker='✓'
        --bind '?:toggle-preview'
        --bind 'ctrl-a:select-all'
        --bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
    "
        #--prompt='~> ' --pointer='▶' --marker='✓'

    # find-in-file - usage: fif <SEARCH_TERM>
    fif() {
      if [ ! "$#" -gt 0 ]; then
        echo "Need a string to search for!";
        return 1;
      fi
    
      rg --files-with-matches --no-messages "$1" | fzf $FZF_PREVIEW_WINDOW --preview "rg --ignore-case --pretty --context 10 '$1' {}"
    }

