if exists("g:loaded_jumpdef_scheme")
    finish
endif
let g:loaded_jumpdef_scheme = 1


function! JumpDef_scheme(obj)
    if (a:obj == "function")
        return "^\\s*(define\\s*(\\_[^;]*)\\s*"
    endif
endfunction
