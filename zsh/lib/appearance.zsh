# ls colors
autoload colors; colors;
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Find the option for using colors in ls, depending on the version: Linux or BSD
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'

# Time commands if executed longer than
REPORTTIME=10

if [[ x$WINDOW != x ]]
then
    SCREEN_NO="%B$WINDOW%b "
else
    SCREEN_NO=""
fi
