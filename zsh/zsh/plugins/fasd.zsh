# Initialize fasd

if source $(which fasd) 2>/dev/null; then
    eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"
fi

fasd_cd() {
  if [ $# -le 0 ]; then
    cd "$(fasd -dl | fzf)"
  else
    cd "$(fasd -d -e 'printf %s' "$@")"
  fi
}

_fasd_edit_zsh_cmd_complete() {
  local compl
  read -c compl
  (( $+compstate )) && compstate[insert]=menu # no expand if compsys loaded
  reply=(${(f)"$(LANG=C fasd -b viminfo --complete "$compl")"})
}

fasd_edit() {
  local dest
  if [ $# -le 0 ]; then
    dest="$(LANG=C fasd -tl -b viminfo | fzf)"
  else
    dest="$(LANG=C fasd -t -b viminfo "$@")"
  fi

  if [[ ! -z $dest ]]; then
      vim "$dest"
  fi
}

compctl -U -K _fasd_edit_zsh_cmd_complete -V fasd_edit -x 'C[-1,-*e],s[-]n[1,e]' -c - 'c[-1,-A][-1,-D]' -f -- fasd_edit

# Alias v and j
alias j="fasd_cd"
alias v="fasd_edit"
