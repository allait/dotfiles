setlocal commentstring=;;%s

setlocal shiftwidth=2

setlocal foldexpr=GetClojureFold()
setlocal foldmethod=expr
let g:clojure_fold_extra = []

" Quicker jumps to opening and closing paren
noremap <buffer> ( [(
noremap <buffer> ) ])


" Fireplace
" ---------

" Jump to definition
nmap <buffer> <C-]> <Plug>FireplaceDjump
