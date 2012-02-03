" -*- vim -*-
" Jumpdef plugin
" Inspired by python_fn.vim by Mikael Berthe and Jon Franklin
"
" Version: 0.01
"
" Requirements:
" vim (>=7)
"
" Shortcuts:
"   ]c -- Jump to the next class definition in current file
"   [c -- Jump to the previous class definition in current file
"   ]f -- Jump to the next function definition in current file
"   [f -- Jump to the previous function definition in current file

if exists("g:loaded_jumpdef_plugin")
    finish
endif
let g:loaded_jumpdef_plugin = 1

function! s:JumpToDefinition(obj, direction)
    let flag = "W"
    if (a:direction == -1)
        let flag = flag."b"
    endif
    let ftype = split(&ft, '\.')[0]
    if exists("g:loaded_jumpdef_".ftype)
        let l:objregexp = JumpDef_{ftype}(a:obj)
    endif
    if exists("l:objregexp")
        let res = search(l:objregexp, flag)
    endif
    " TODO check for and avoid jumpint to comment region
endfunction

" TODO make this work
function! s:SelectObject(obj)
    " Go to the object declaration
    normal $
    call s:JumpToDefinition(a:obj, -1)
    let beg = line('.')

    if exists("g:loaded_jumpdef_".ftype)
        let l:endregexp = JumpEnd_{ftype}(a:obj)
    endif
    if exists("l:endregexp")
        let end = search(l:endregexp, "")
    endif

    " Select the whole block
    execute "normal \<Down>"
    let cl = line('.')
endfunction

" TODO add folding

command JumpToNextClass call s:JumpToDefinition("class", 1)
command JumpToPreviousClass call s:JumpToDefinition("class", -1)
command JumpToNextFunction call s:JumpToDefinition("function", 1)
command JumpToPreviousFunction call s:JumpToDefinition("function", -1)
" TODO add method jumps(functions with self for python, ...)
"command JumpToNextMethod call s:JumpToDefinition("method", 1)
"command JumpToPreviousMethod call s:JumpToDefinition("method", -1)

nnoremap <silent> <Plug>jumpdefJumpToNextClass :JumpToNextClass<CR>
nnoremap <silent> <Plug>jumpdefJumpToPreviousClass :JumpToPreviousClass<CR>
nnoremap <silent> <Plug>jumpdefJumpToNextFunction :JumpToNextFunction<CR>
nnoremap <silent> <Plug>jumpdefJumpToPreviousFunction :JumpToPreviousFunction<CR>

nmap ]c <Plug>jumpdefJumpToNextClass
nmap [c <Plug>jumpdefJumpToPreviousClass
nmap ]f <Plug>jumpdefJumpToNextFunction
nmap [f <Plug>jumpdefJumpToPreviousFunction

