if exists("g:loaded_jumpdef_snippet")
    finish
endif
let g:loaded_jumpdef_snippet = 1


function! JumpDef_snippet(obj)
    if (a:obj == "function")
        return "^snippet\\s"
    endif
endfunction
