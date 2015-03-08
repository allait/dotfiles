# Parameter expantion and substitution performed in prompts
setopt prompt_subst

function prompt_vcs_info() {
    local ref
    ref=$(git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(git rev-parse --short HEAD 2> /dev/null) || return

    echo "$1${ref#refs/heads/}$2"
}

function prompt_host {
   if [[ $HOST == *.local || $HOST == *.home ]]; then
       return
   else
       echo "$1%m$2"
   fi
}

function prompt_pwd {
    if [[ $PWD != $HOME ]]; then
        print `echo $PWD|sed -e "s|^$HOME|~|" -e 's-/\([^/]\)\([^/]*\)-/\1-g'``echo $PWD|sed -e 's-.*/[^/]\([^/]*$\)-\1-'`
    else
        print '~'
    fi
}

# Left prompt
if [[ $(tput colors) == 256 ]]; then
    PROMPT=$(prompt_host "%F{202}" "%f ")
    PROMPT=$PROMPT'%f%F{25}$(prompt_pwd)%f$(prompt_vcs_info " on %F{yellow}" %f) %F{221}%#%f '
else
    PROMPT=$(prompt_host "%F{red}" "%f ")
    PROMPT=$PROMPT'%F{blue}$(prompt_pwd)%f$(prompt_vcs_info " on %F{yellow}" %f) %F{yellow}%#%f '
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
