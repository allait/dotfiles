autoload -U compinit
compinit -Ci

# Treat #~^ as part of patterns
setopt extendedglob
# Cd on directory name
setopt autocd
# Show list on ambiguous completion
setopt auto_list
# Add trailing slash to directory names
setopt auto_param_slash

# /foo/.. -> /
setopt chase_dots

# Make completion list smaller
setopt list_packed

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

# Parse --help arguments completion for following commands
compdef _gnu_generic nosetests
compdef _gnu_generic trial
compdef _gnu_generic mkvirtualenv
compdef _gnu_generic ack
compdef _gnu_generic fab
compdef _gnu_generic csi
compdef _gnu_generic clang
compdef _gnu_generic psql
compdef _gnu_generic createdb
compdef _gnu_generic dropdb
compdef _gnu_generic pg_dump
compdef _gnu_generic pg_config

# Complete MacVim alias and mvim
compdef _vim Vim mvim

# Ignore completion functions I don't have
zstyle ':completion:*:functions' ignored-patterns '_*'

# Completion system configuration
# Immediately show completion menu
zstyle ':completion:*' menu select
# Remove trailing slash if using directory as completion
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' format '%F{white}%d%f'
zstyle ':completion:*' group-name ''
# Perform case-insensitive matching
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' keep-prefix
# Disallow remote connections for completion functions
zstyle ':completion:*' remote-access false
# Complete options for commands after directory stack for cd, pushd, ...
zstyle ':completion:*' complete-options true
# Cache completions for commands that support it
zstyle ':completion:*' use-cache true


# Zsh completion control functions
zstyle ':completion:*' completer _oldlist _complete _match _ignored _list
