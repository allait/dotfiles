# Lines configured by zsh-newuser-install
setopt histignorespace

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

# Unicode environment
export LANG=en_US.utf8
export LC_CTYPE=en_US.UTF-8
