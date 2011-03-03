if exists("g:loaded_jumpdef_javascript")
    finish
endif
let g:loaded_jumpdef_javascript = 1


function! JumpDef_javascript(obj)
    if (a:obj == "function")
        return "\\(^\\s*\\|\\s\\+\\)function\\s*[a-zA-Z0-9_]*\\s*(\\_[^/]*)\\s*"
    endif
endfunction
