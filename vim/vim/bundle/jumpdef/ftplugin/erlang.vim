if exists("g:loaded_jumpdef_erlang")
    finish
endif
let g:loaded_jumpdef_erlang = 1


function! JumpDef_erlang(obj)
    if (a:obj == "function")
        return "^\\s*[a-zA-Z0-9_]\\+\\s*(\\_\\.*)\\s*\\(when [^:#]*\\)\\{-}->"
    endif
endfunction
