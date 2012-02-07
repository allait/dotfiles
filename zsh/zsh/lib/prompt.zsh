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
zstyle ':vcs_info:*' formats '@%F{yellow}%b%f'

# Execute function before every command
function precmd () {
    vcs_info
    vcs_prompt_info
}

VCS_PROMPT_UNTRACKED="%F{blue}● %f"
VCS_PROMPT_UNSTAGED="%B%F{red}● %b%f"
VCS_PROMPT_UNCOMMITED="%F{red}● %f"
VCS_PROMPT_CLEAN="%F{green}● %f"

RPROMPT='${vcs_prompt_info_status_}[%T]'
PROMPT='%F{blue}$(prompt_pwd)%f${vcs_info_msg_0_} %F{yellow}%%%f '

# Vi mode indicators
VI_NORMAL_MODE='%F{red}⚙%f'
VI_INSERT_MODE=$RPROMPT

autoload zle-line-init zle-keymap-select
zle -N zle-line-init
zle -N zle-keymap-select
