# get the name of the branch we are on
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function parse_git_dirty () {
  gitstat=$(git status 2>/dev/null | grep '\(# Untracked\|# Changes\|# Changed but not updated:\)')

  if [[ $(echo ${gitstat} | grep -c "^\(# Changes to be committed:\|# Changed but not updated:\)$") > 0 ]]; then
	echo -n "$ZSH_THEME_GIT_PROMPT_DIRTY"
  fi

  if [[ $(echo ${gitstat} | grep -c "^# Untracked files:$") > 0 ]]; then
	echo -n "$ZSH_THEME_GIT_PROMPT_UNTRACKED"
  fi 

  if [[ $(echo ${gitstat} | grep -v '^$' | wc -l | tr -d ' ') == 0 ]]; then
	echo -n "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

#
# Will return the current branch name
# Usage example: git pull origin $(current_branch)
#
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

# Vi mode indication
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/$VI_NORMAL_MODE}/(main|viins)/$VI_INSERT_MODE}"
    RPS2=$RPS1
    zle reset-prompt
}
