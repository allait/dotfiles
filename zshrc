# Lines configured by zsh-newuser-install
setopt histignorespace

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=5000

# There be user-defined functions
fpath=(~/.zsh/functions $fpath)
autoload ~/.zsh/functions/*(:t)

# Load specific config files
for config_file (~/.zsh/*.zsh) source $config_file
unset config_file

# Use vim for git commits and stuff
export EDITOR="/usr/bin/vim"

# Get emacs keybindings
bindkey -e

# Local settings are stored in ~/.zshenv, .zlocal is used for overriding 
# settings from this config
