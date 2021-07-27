# Initialize fasd

if source $(which fasd) 2>/dev/null; then
    eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"
fi

fasd_cd() {
  if [ $# -le 0 ]; then
    cd "$(fasd -dl | fzf)"
  else
    cd "$(fasd -dl1 "$@")"
  fi
}

# Alias j
alias j="fasd_cd"
