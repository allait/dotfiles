# Get emacs keybindings
bindkey -e

# Disable ^S/^Q start/stop in ZLE
unsetopt flow_control

# Disable software flow control with ^S/^Q
stty -ixon

# Make word commands stop before and after dots and /
bindkey "^W" vi-backward-kill-word
bindkey "^[b" vi-backward-word
bindkey "^[f" vi-forward-word

# Home/End/Delete keys
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line
bindkey "^[[3~" delete-char

bindkey ' ' magic-space

# ^U to delete line to beginning instead of whole line
bindkey "^U" backward-kill-line

# Search history for current line contents with up/down keys
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Push multiline commands too
bindkey "^Q" push-input

# Edit command in default editor
# http://stackoverflow.com/questions/890620/unable-to-have-bash-like-c-x-e-in-zsh
autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

# Restore normal history behavior in vi-mode
[[ -z "$terminfo[kcuu1]" ]] || bindkey -M viins "$terminfo[kcuu1]" up-line-or-history
[[ -z "$terminfo[kcud1]" ]] || bindkey -M viins "$terminfo[kcud1]" down-line-or-history
