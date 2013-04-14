#!/bin/zsh

vcs_prompt_info() {
    local ref
    ref=$(git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(git rev-parse --short HEAD 2> /dev/null) || return

    echo "$VCS_PROMPT_PREFIX${ref#refs/heads/}$VCS_PROMPT_SUFFIX"
}
