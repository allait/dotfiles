#!zsh
_fab_list() {
    reply=(`fab --shortlist 2>/dev/null`)
}

compctl -K _fab_list fab

