# from `npm completion`

_npm_completion() {
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                COMP_LINE=$BUFFER \
                COMP_POINT=0 \
                npm completion -- "${words[@]}" \
                2>/dev/null)
}

compdef _npm_completion npm
