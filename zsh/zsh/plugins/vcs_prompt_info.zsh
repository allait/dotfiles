#!/bin/zsh

vcs_prompt_info() {
    if [[ -d ".git" ]] || [[ -n $(git symbolic-ref HEAD 2> /dev/null) ]]; then
        git_parse_status
    elif [[ -d ".hg" ]] || [[ -n $(hg branch 2> /dev/null) ]]; then
        hg_parse_status
    else
        typeset -gx vcs_prompt_info_status_=""
    fi
}

git_parse_status() {
    local vcs_status vcs_files _status
    vcs_status=$(git status --porcelain 2> /dev/null)
    if [[ -z $vcs_status ]]; then
        typeset -gx vcs_prompt_info_status_="$VCS_PROMPT_CLEAN"
        return
    fi
    vcs_files=("${(f)vcs_status}")
    _status=""
    if [[ -n ${vcs_files[(r)\?\?*]} ]] _status="$VCS_PROMPT_UNTRACKED$_status"
    if [[ -n ${vcs_files[(r)[MADRCU][MADRCU ]*]} ]] _status="$VCS_PROMPT_UNCOMMITED$_status"
    if [[ -n ${vcs_files[(r)[MADRCU ][MADRCU]*]} ]] _status="$VCS_PROMPT_UNSTAGED$_status"
    typeset -gx vcs_prompt_info_status_=$_status
}

hg_parse_status() {
    local vcs_status vcs_files _status
    vcs_status=$(hg status 2> /dev/null)
    if [[ -z $vcs_status ]]; then
        typeset -gx vcs_prompt_info_status_="$VCS_PROMPT_CLEAN"
        return
    fi
    vcs_files=("${(f)vcs_status}")
    _status=""
    if [[ -n ${vcs_files[(r)\? *]} ]] _status="$VCS_PROMPT_UNTRACKED$_status"
    if [[ -n ${vcs_files[(r)[MARC] *]} ]] _status="$VCS_PROMPT_UNCOMMITED$_status"
    if [[ -n ${vcs_files[(r)! *]} ]] _status="$VCS_PROMPT_UNSTAGED$_status"
    typeset -gx vcs_prompt_info_status_=$_status
}
