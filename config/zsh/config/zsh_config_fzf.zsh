eval "$(fzf --zsh)"

# for more info see fzf/shell/completion.zsh
_fzf_compgen_path() { fd . "$1" }
_fzf_compgen_dir() { fd --type d . "$1" }

# fzf's command
export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude '.git'"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"    # Change directory
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"            # Search files
#export FZF_CTRL_R_COMMAND=""                                # Previous commands
#export FZF_COMPLETION_TRIGGER='**' # Change default trigger

# Note: toggle preview visibility with ?
#--prompt='~> ' --pointer='▶' --marker='✓'
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
