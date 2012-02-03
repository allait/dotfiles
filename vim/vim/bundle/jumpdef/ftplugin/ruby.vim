if exists("g:loaded_jumpdef_ruby")
    finish
endif
let g:loaded_jumpdef_ruby = 1


function! JumpDef_ruby(obj)
    if (a:obj == "class")
        return "^\\s*class\\s\\+[a-zA-Z0-9_]\\+"
                \ . "\\s*\\(<\\s*[a-zA-Z0-9_,. \\t\\n]*\\)\\{-}"
    elseif (a:obj == "function")
        return "^\\s*def\\s\\+[a-zA-Z0-9_]\\+\\s*\\((\\_[^:#]*)\\)\\{-}\\s*"
    endif
endfunction
