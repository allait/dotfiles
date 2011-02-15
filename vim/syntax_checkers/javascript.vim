" Nodelint js checker integration
" https://github.com/tav/nodelint

if exists("loaded_javascript_syntax_checker")
    finish
endif

" Exit if the user doesnt have nodelint installed
" Fallbacks to default javascript linter, if any
if !executable("nodelint")
    finish
endif

let loaded_javascript_syntax_checker = 1
let s:config = $HOME.'/.vim/syntax_checkers/nodelint-config.js'

function! SyntaxCheckers_javascript_GetLocList()
    let makeprg = "nodelint --config ".s:config." --reporter ".s:config." ".shellescape(expand('%'))
    let errorformat='%W%f line %l column %c Error: %m'
    return SyntasticMake({ 'makeprg': makeprg, 'errorformat': errorformat })
endfunction
