setlocal commentstring=;;%s

setlocal shiftwidth=2

setlocal foldexpr=GetClojureFold()
setlocal foldmethod=expr
let g:clojure_fold_extra = []

" Quicker jumps to opening and closing paren
nmap <buffer> ( <Plug>(sexp_move_to_prev_bracket)
nmap <buffer> ) <Plug>(sexp_move_to_next_bracket)

" Paredit
" --------

" Wrap symbol or S-exp
nmap <buffer> (w <Plug>(sexp_round_head_wrap_element)
nmap <buffer> )w <Plug>(sexp_round_tail_wrap_element)
vmap <buffer> (w <Plug>(sexp_round_head_wrap_element)
vmap <buffer> )w <Plug>(sexp_round_tail_wrap_element)

" Splice (unwrap)
nmap <buffer> (u <Plug>(sexp_splice_list)
nmap <buffer> )u <Plug>(sexp_splice_list)

" Insert at points
nmap <buffer> (i  <Plug>(sexp_insert_at_list_head)
nmap <buffer> )i  <Plug>(sexp_insert_at_list_tail)

" Move forms/elements
nmap <buffer> (f  <Plug>(sexp_swap_list_backward)
nmap <buffer> )f  <Plug>(sexp_swap_list_forward)
nmap <buffer> (e  <Plug>(sexp_swap_element_backward)
nmap <buffer> )e  <Plug>(sexp_swap_element_forward)

" Move paren
nmap <buffer> (< <Plug>(sexp_capture_prev_element)
nmap <buffer> )< <Plug>(sexp_emit_tail_element)
nmap <buffer> (> <Plug>(sexp_emit_head_element)
nmap <buffer> )> <Plug>(sexp_capture_next_element)

" Fireplace
" ---------

" Jump to definition
nmap <buffer> <C-]> <Plug>FireplaceDjump
