setlocal omnifunc=htmlcomplete#CompleteTags
setlocal shiftwidth=2

" Similar to indent folding, but includes parent into fold
setlocal foldmethod=expr
setlocal foldexpr=(getline(v:lnum)=~'^$')?'=':((indent(v:lnum)<indent(v:lnum+1))?('>'.indent(v:lnum+1)):((indent(v:lnum)<indent(v:lnum-1))?('<'.indent(v:lnum-1)):indent(v:lnum)))
