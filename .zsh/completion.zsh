# Completion options
setopt   extendedglob autocd auto_list auto_param_slash list_packed rec_exact
setopt correct correctall
unsetopt beep list_beep

zstyle ':completion:*' menu select
zstyle ':completion:*' format '%F{white}%d%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' keep-prefix
zstyle ':completion:*' remote-access false
zstyle ':completion:*' completer _oldlist _complete _match _ignored \
    _list _history
autoload -U compinit
compinit
