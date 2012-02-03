#!/bin/zsh

function prompt_pwd {
    if [[ $PWD != $HOME ]]; then
        print `echo $PWD|sed -e "s|^$HOME|~|" -e 's-/\([^/]\)\([^/]*\)-/\1-g'``echo $PWD|sed -e 's-.*/[^/]\([^/]*$\)-\1-'`
    else
        print '~'
    fi
}
