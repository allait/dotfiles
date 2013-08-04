" Folding for Markdown headers, both styles (atx- and setext-)
" from https://gist.github.com/vim-voom/1035030

" In Markdown, setext-style overrides atx-style, so we first check for an
" underline. Empty lines should be ignored when underlined.
func! Foldexpr_markdown(lnum)
    let l1 = getline(a:lnum)
    if l1 =~ '^\s*$'
        return '='
    endif
    let l2 = getline(a:lnum+1)
    if  l2 =~ '^=\+\s*$'
        return '>1'
    elseif l2 =~ '^-\+\s*$'
        return '>2'
    elseif l1 =~ '^#'
        return '>'.matchend(l1, '^#\+')
    else
        return '='
    endif
endfunc

setlocal foldmethod=expr
setlocal foldexpr=Foldexpr_markdown(v:lnum)
