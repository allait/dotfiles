# Initialize fasd

if source $(which fasd) 2>/dev/null; then
    eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"
fi

fasd_cd() {
  if [ $# -le 1 ]; then
    fasd "$@"
  else
    local _fasd_ret="$(fasd -e 'printf %s' "$@")"
    [ -z "$_fasd_ret" ] && return
    [ -d "$_fasd_ret" ] && cd "$_fasd_ret" || printf %s\\n "$_fasd_ret"
  fi
}

# Alias v and j
alias j="fasd_cd -d"
alias v="fasd -f -e vim"

