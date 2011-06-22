#!/bin/zsh

vcs_prompt_info() {
    if [[ -d ".git" ]]; then
        git_parse_status
    elif [[ -d ".hg" ]]; then
        hg_parse_status
    fi
}

git_parse_status() {
    vcs_status=$(git status -s 2> /dev/null)
    if [[ -z $vcs_status ]]; then
        echo "$VCS_PROMPT_CLEAN"
        return
    elif [[ ! $vcs_status =~ '^\?\?' ]]; then
        echo "$VCS_PROMPT_UNSTAGED"
    else
        echo "$VCS_PROMPT_UNTRACKED"
    fi
}

hg_parse_status() {
    vcs_status=$(hg status 2> /dev/null)
    if [[ -z $vcs_status ]]; then
        echo "$VCS_PROMPT_CLEAN"
        return
    elif [[ ! $vcs_status =~ '^\?' ]]; then
        echo "$VCS_PROMPT_UNSTAGED"
    else
        echo "$VCS_PROMPT_UNTRACKED"
    fi
}
