# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

fpath=(~/.zsh/functions $fpath)

# Load specific config files
for config_file (~/.zsh/*.zsh) source $config_file
unset config_file

export EDITOR="/usr/bin/vim"
