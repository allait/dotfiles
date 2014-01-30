# Load chruby into a shell session.
source /usr/local/opt/chruby/share/chruby/chruby.sh 2> /dev/null

# Complete ruby names from ~/.rubies/*
compctl -g '~/.rubies/*(:t)' chruby

# Set default ruby if chruby is installed
type chruby >/dev/null && chruby ruby-2.1.0
