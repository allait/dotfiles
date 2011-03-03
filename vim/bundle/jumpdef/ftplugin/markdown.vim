if exists("g:loaded_jumpdef_markdown")
    finish
endif
let g:loaded_jumpdef_markdown = 1


function! JumpDef_markdown(obj)
    if (a:obj == "function")
        return "^#\+\\s"
    endif
endfunction
