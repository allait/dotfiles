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
#PROMPT='%{$fg[cyan]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info) %% '
PROMPT='%{$fg[blue]%}%c%{$reset_color%}$(git_prompt_info) %{$fg[yellow]%}%%%{$reset_color%} '
ZSH_THEME_GIT_PROMPT_PREFIX="@%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[yellow]%}✚%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✔%{$reset_color%}"
RPROMPT='%{$fg[black]%}%m%{$reset_color%}%B [%T]%{$reset_color%}'

# Vi mode indicators
VI_NORMAL_MODE="%{$fg_bold[red]%}⚙%{$reset_color%}"
VI_INSERT_MODE=$RPROMPT

autoload zle-line-init zle-keymap-select
zle -N zle-line-init
zle -N zle-keymap-select
