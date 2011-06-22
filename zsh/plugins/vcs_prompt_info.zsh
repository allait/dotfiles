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
    fi
    vcs_files=("${(f)vcs_status}")
    STATUS=""
    if [[ -n ${vcs_files[(r)\?\?*]} ]] STATUS="$VCS_PROMPT_UNTRACKED$STATUS"
    if [[ -n ${vcs_files[(r)[MADRCU][MADRCU ]*]} ]] STATUS="$VCS_PROMPT_UNCOMMITED$STATUS"
    if [[ -n ${vcs_files[(r)[MADRCU ][MADRCU]*]} ]] STATUS="$VCS_PROMPT_UNSTAGED$STATUS"
    echo $STATUS
}

hg_parse_status() {
    vcs_status=$(hg status 2> /dev/null)
    if [[ -z $vcs_status ]]; then
        echo "$VCS_PROMPT_CLEAN"
        return
    fi
    vcs_files=("${(f)vcs_status}")
    STATUS=""
    if [[ -n ${vcs_files[(r)\? *]} ]] STATUS="$VCS_PROMPT_UNTRACKED$STATUS"
    if [[ -n ${vcs_files[(r)[MARC] *]} ]] STATUS="$VCS_PROMPT_UNCOMMITED$STATUS"
    if [[ -n ${vcs_files[(r)! *]} ]] STATUS="$VCS_PROMPT_UNSTAGED$STATUS"
    echo $STATUS
}
