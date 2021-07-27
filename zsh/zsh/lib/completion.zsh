autoload -U compinit
compinit -i

# Treat #~^ as part of patterns
setopt extendedglob

# Don't remove space after completion and before &|
export ZLE_REMOVE_SUFFIX_CHARS=$'\t\n;'
export ZLE_SPACE_SUFFIX_CHARS=$'&|'

# Cd on directory name
setopt autocd

# Show list on ambiguous completion
setopt auto_list

# Add trailing slash to directory names
setopt auto_param_slash

# Make completion list smaller
setopt list_packed

# Don't print 'no matches found' error
unsetopt nomatch

# Complete from within word
setopt complete_in_word

# Jump to word end on successful completion
setopt always_to_end

# Perform implicit tees or cats on redirections
setopt multios

# Keep silent, literally
unsetopt beep list_beep

# Ignore completion functions I don't have
zstyle ':completion:*:functions' ignored-patterns '_*'

# Immediately show completion menu
zstyle ':completion:*' menu select

# Remove trailing slash if using directory as completion
zstyle ':completion:*' squeeze-slashes true

# Set description style
zstyle ':completion:*' format '%F{white}%d%f'

# Use tag name as the name of the group
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

# Complete only given users
zstyle ':completion:*' users root $(whoami)

# Zsh completion control functions
zstyle ':completion:*' completer _oldlist _complete _match _ignored _list
