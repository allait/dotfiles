# ls colors
autoload colors; colors;
export LSCOLORS="Gxfxcxdxbxegedabagacad"

source ~/.zsh/lib/prompt.zsh
# Find the option for using colors in ls, depending on the version: Linux or BSD
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'

#setopt no_beep
setopt multios
setopt cdablevarS

# Time commands if executed longer than
REPORTTIME=10

if [[ x$WINDOW != x ]]
then
    SCREEN_NO="%B$WINDOW%b "
else
    SCREEN_NO=""
fi

# Setup the prompt with pretty colors
setopt prompt_subst

function title {
  if [[ $TERM == "screen" ]]; then
    # Use these two for GNU Screen:
    print -nR $'\033k'$1$'\033'\\\

    print -nR $'\033]0;'$2$'\a'
  elif [[ $TERM == "xterm" || $TERM == "rxvt" ]]; then
    # Use this one instead for XTerms:
    print -nR $'\033]0;'$*$'\a'
  fi
}

function precmd {
    if [[ $KEEP_TITLE != "yes" ]]; then
        title "$USERNAME:$PWD"
    fi
}

function prompt_pwd {
    if [[ $PWD != $HOME ]]; then
        print `echo $PWD|sed -e "s|^$HOME|~|" -e 's-/\([^/]\)\([^/]*\)-/\1-g'``echo $PWD|sed -e 's-.*/[^/]\([^/]*$\)-\1-'`
    else
        print '~'
    fi
}

#PROMPT='%{$fg[cyan]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info) %% '
PROMPT='%{$fg[blue]%}$(prompt_pwd)%{$reset_color%}$(git_prompt_info) %{$fg[yellow]%}%%%{$reset_color%} '
ZSH_THEME_GIT_PROMPT_PREFIX="@%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[yellow]%}✚%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✔%{$reset_color%}"
RPROMPT='%{$fg[black]%}%m%{$reset_color%} [%T]'

# Vi mode indicators
VI_NORMAL_MODE="%{$fg_bold[red]%}⚙%{$reset_color%}"
VI_INSERT_MODE=$RPROMPT

autoload zle-line-init zle-keymap-select
zle -N zle-line-init
zle -N zle-keymap-select

# Colorize less
#export LESS_TERMCAP_mb=$'\E[01;36m'
#export LESS_TERMCAP_md=$'\E[01;36m'
#export LESS_TERMCAP_me=$'\E[0m'
#export LESS_TERMCAP_se=$'\E[0m'
#export LESS_TERMCAP_so=$'\E[01;44;33m'
#export LESS_TERMCAP_ue=$'\E[0m'
#export LESS_TERMCAP_us=$'\E[04;32m'
