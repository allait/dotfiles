# Parameter expantion and substitution performed in prompts
setopt prompt_subst

VCS_PROMPT_PREFIX=" on %F{yellow}"
VCS_PROMPT_SUFFIX="%b%f"

# Left prompt
if [[ $(tput colors) == 256 ]]; then
    PROMPT='%F{25}$(prompt_pwd)%f$(vcs_prompt_info) %F{221}%#%f '
else
    PROMPT='%F{blue}$(prompt_pwd)%f$(vcs_prompt_info) %F{yellow}%#%f '
fi

# Right prompt
RPROMPT='%1(j,%F{blue}● %f,)%(?,,%F{red}[%?]%f)[%T]'

# Vi mode indication
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/$VI_NORMAL_MODE}/(main|viins)/$VI_INSERT_MODE}"
    RPS2=$RPS1
    zle reset-prompt
}

# Vi mode indicators
VI_NORMAL_MODE='%F{red}⚙%f'
VI_INSERT_MODE=$RPROMPT

zle -N zle-line-init
zle -N zle-keymap-select
