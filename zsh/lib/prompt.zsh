# Vi mode indication
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/$VI_NORMAL_MODE}/(main|viins)/$VI_INSERT_MODE}"
    RPS2=$RPS1
    zle reset-prompt
}
