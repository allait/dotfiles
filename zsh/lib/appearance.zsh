# ls colors
autoload colors; colors;

# Find the option for using colors in ls, depending on the version: Linux or BSD
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'

# Time commands if executed longer than
REPORTTIME=10
