if exists("g:loaded_jumpdef_python")
    finish
endif
let g:loaded_jumpdef_python = 1


function! JumpDef_python(obj)
    if (a:obj == "class")
        return "^\\s*class\\s\\+[a-zA-Z0-9_]\\+"
                \ . "\\s*\\((\\([a-zA-Z0-9_,. \\t\\n]\\)*)\\)\\=\\s*:"
    elseif (a:obj == "function")
        return "^\\s*def\\s\\+[a-zA-Z0-9_]\\+\\s*(\\_[^:#]*)\\s*:"
    endif
endfunction
