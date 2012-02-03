if exists("g:loaded_jumpdef_snippets")
    finish
endif
let g:loaded_jumpdef_snippets = 1


function! JumpDef_snippets(obj)
    if (a:obj == "function")
        return "^snippet\\s"
    endif
endfunction
