# Key bindings
# ------------

source /usr/local/opt/fzf/shell/completion.zsh 2>/dev/null
source /usr/local/opt/fzf/shell/key-bindings.zsh 2>/dev/null

# Use fd for CTRL-T completion
export FZF_CTRL_T_COMMAND="fd --follow"

# Use fd for `fzf` command
export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude ".git"'

# Use fd for ** path completion
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# _v_complete() {
#     _fzf_complete "--multi --reverse --filter" "$@" <(
#         fd -d5
#     )
# }

v() {
  local editor="nvim"
  local files
  IFS=$'\n' files=($(fzf --query="$@" --cycle --select-1 --exit-0))
  [[ -n "$files" ]] && ${editor} "${files[@]}"
}

# compctl -U -K _v_complete -x 'C[-1,-*e],s[-]n[1,e]' -c - 'c[-1,-A][-1,-D]' -f -- v
