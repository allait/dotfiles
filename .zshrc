# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=5000

fpath=(~/.zsh/functions $fpath)
autoload ~/.zsh/functions/*(:t)

# Load specific config files
for config_file (~/.zsh/*.zsh) source $config_file
unset config_file

export EDITOR="/usr/bin/vim"

source ~/.zlocal
