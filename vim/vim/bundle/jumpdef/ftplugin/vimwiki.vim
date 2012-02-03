if exists("g:loaded_jumpdef_vimwiki")
    finish
endif
let g:loaded_jumpdef_vimwiki = 1


function! JumpDef_vimwiki(obj)
    if (a:obj == "function")
        return '\(^#\+\s\|^.*\n-\+$\|^.*\n=\+$\)'
    endif
endfunction
