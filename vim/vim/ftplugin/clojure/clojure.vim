setlocal commentstring=;;%s

setlocal shiftwidth=2

setlocal foldexpr=GetClojureFold()
setlocal foldmethod=expr
let g:clojure_fold_extra = []

" Quicker jumps to opening and closing paren
noremap <buffer> ( [(
noremap <buffer> ) ])

" Paredit
" --------

" Wrap symbol or S-exp
nnoremap <buffer> (w :<C-u>call PareditWrap("(", ")")<CR>
nnoremap <buffer> )w :<C-u>call PareditWrap("(", ")")<CR>
vnoremap <buffer> (w :<C-u>call PareditWrapSelection("(", ")")<CR>
vnoremap <buffer> )w :<C-u>call PareditWrapSelection("(", ")")<CR>

" Splice (unwrap)
nnoremap <buffer> (u :<C-u>call PareditSplice()<CR>
nnoremap <buffer> )u :<C-u>call PareditSplice()<CR>

" Move paren
nnoremap <buffer> (h :<C-u>call PareditMoveLeft()<CR>
nnoremap <buffer> )h :<C-u>call PareditMoveLeft()<CR>
nnoremap <buffer> (l :<C-u>call PareditMoveRight()<CR>
nnoremap <buffer> )l :<C-u>call PareditMoveRight()<CR>

" Join and split
nnoremap <buffer> (j :<C-u>call PareditJoin()<CR>
nnoremap <buffer> )j :<C-u>call PareditJoin()<CR>
nnoremap <buffer> (s :<C-u>call PareditSplit()<CR>
nnoremap <buffer> )s :<C-u>call PareditSplit()<CR>

" Fireplace
" ---------

" Jump to definition
nmap <buffer> <C-]> <Plug>FireplaceDjump
