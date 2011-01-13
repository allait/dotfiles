# Vi mode indication
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/$VI_NORMAL_MODE}/(main|viins)/$VI_INSERT_MODE}"
    RPS2=$RPS1
    zle reset-prompt
}

# Parameter expantion and substitution performed in prompts
setopt prompt_subst

ZSH_THEME_GIT_PROMPT_PREFIX="@%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[yellow]%}✚%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✔%{$reset_color%}"
RPROMPT='%{$fg[black]%}%m%{$reset_color%} [%T]'

PROMPT='%{$fg[blue]%}$(prompt_pwd)%{$reset_color%}$(git_prompt_info) %{$fg[yellow]%}%%%{$reset_color%} '

# Vi mode indicators
VI_NORMAL_MODE="%{$fg_bold[red]%}⚙%{$reset_color%}"
VI_INSERT_MODE=$RPROMPT

autoload zle-line-init zle-keymap-select
zle -N zle-line-init
zle -N zle-keymap-select
