# Tread #~^ as part of patterns
setopt extendedglob
# Cd on directory name
setopt autocd
# Show list on ambiguous completion
setopt auto_list
# Add trailing slash to directory names
# setopt auto_param_slash

# pushd on cd
setopt auto_pushd

# /foo/.. -> /
setopt chase_dots

# Make completion list smaller
setopt list_packed
# Recognize exact matches
setopt rec_exact

# Show menu on second TAB
setopt auto_menu
# Complete from within word
setopt complete_in_word
# Jump to word end on successful completion
setopt always_to_end
# Perform implicit tees or cats on redirections
setopt multios
# Turn on command correction
setopt correct correctall
# Keep silent, literally
unsetopt beep list_beep

alias man='nocorrect man'
alias mv='nocorrect mv'
alias mkdir='nocorrect mkdir'

# Generic --help arguments completion for following commands
compdef _gnu_generic nosetests
compdef _gnu_generic curl
compdef _gnu_generic ack-grep
compdef _gnu_generic fab

# Ignore completion functions I don't have
zstyle ':completion:*:functions' ignored-patterns '_*'

# Completion system configuration
zstyle ':completion:*' menu select
zstyle ':completion:*' format '%F{white}%d%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' keep-prefix
zstyle ':completion:*' remote-access false

# Zsh completion control functions
zstyle ':completion:*' completer _oldlist _complete _match _ignored _list

autoload -U compinit
compinit -i
