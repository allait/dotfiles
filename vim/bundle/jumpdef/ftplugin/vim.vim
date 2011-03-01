if exists("g:loaded_jumpdef_vim")
    finish
endif
let g:loaded_jumpdef_vim = 1


function! JumpDef_vim(obj)
    if (a:obj == "function")
        return "^\\s*function[!]*\\s\\+[a-z:A-Z0-9_]\\+\\s*(\\_[^#]*)\\s*"
    endif
endfunction
