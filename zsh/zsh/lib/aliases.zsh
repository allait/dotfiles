# Enable color output
alias grep='grep --color=auto'

# Find the option for using colors in ls, depending on the version: Linux or BSD
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'

# ack fix for Debian and it's curious naming scheme
which ack-grep >&- && alias ack=ack-grep

# Shortcuts
alias l='ls -lAh'

alias pu='pushd'
alias po='popd'

# Python aliases
alias pdt='python -m doctest -v'
alias serve='python -m SimpleHTTPServer'

# Git alias
alias g='git'

# Vim alias
alias v='vim'
