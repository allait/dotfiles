# Vi mode indication
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/$VI_NORMAL_MODE}/(main|viins)/$VI_INSERT_MODE}"
    RPS2=$RPS1
    zle reset-prompt
}

# Parameter expantion and substitution performed in prompts
setopt prompt_subst

# Load vcs_info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable hg git
zstyle ':vcs_info:*' formats '@%F{yellow}%b%F{reset}'

# Execute function before every command
function precmd () {
    vcs_info
}

VCS_PROMPT_UNTRACKED="%F{yellow}●%F{reset}"
VCS_PROMPT_UNSTAGED="%F{red}●%F{reset}"
VCS_PROMPT_UNCOMMITED="%F{yellow}●%F{reset}"
VCS_PROMPT_CLEAN="%F{green}●%F{reset"

RPROMPT='$(vcs_prompt_info) [%T]'
PROMPT='%F{blue}$(prompt_pwd)%F{reset}${vcs_info_msg_0_} %F{yellow}%%%F{reset} '

# Vi mode indicators
VI_NORMAL_MODE="%{$fg_bold[red]%}⚙%{$reset_color%}"
VI_INSERT_MODE=$RPROMPT

autoload zle-line-init zle-keymap-select
zle -N zle-line-init
zle -N zle-keymap-select
