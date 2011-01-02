# There be user-defined functions
fpath=(~/.zsh/functions $fpath)
autoload ~/.zsh/functions/*(:t)

# Load and register completion functions
fpath=(~/.zsh/completions $fpath)

# Load specific config files
for config_file (~/.zsh/lib/*.zsh) source $config_file
unset config_file

# Load plugins
for plugin_file (~/.zsh/plugins/*.zsh) source $plugin_file
unset plugin_file


# Use vim for git commits and stuff
export EDITOR="vim"

# Less is more
export PAGER=less

# Get emacs keybindings
bindkey -e

# Local settings are stored in ~/.zshenv, .zlocal is used for overriding 
# settings from this config
