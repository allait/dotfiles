setlocal omnifunc=pythoncomplete#Complete
setlocal tabstop=8
compiler pylint

" Setup proper function folding
setlocal foldmethod=syntax

" Match function and class definitions
syn region pythonFunctionFold start="^\z(\s*\)\%(def\|class\)\>"
    \ end="\ze\%(\s*\n\)\+\%(\z1\s\)\@!." fold transparent

" Match docstrings
syn region  pythonFoldedString start=+[Bb]\=[Rr]\=[Uu]\=\z("""\|'''\)+
    \ end=+.*\z1+ fold transparent contained
    \ containedin=pythonString,pythonUniString,pythonUniRawString,pythonRawString

" Match comments that span more than one line.
syntax region  pythonCommentFold start="^\z(\s*\)#\%(!\|\s*-\*-\)\@!.*$"
    \ end="^\%(\z1\#.*$\)\@!" fold contains=ALLBUT,pythonCommentFold

syn region pythonFold matchgroup=pythonComment
    \ start='#.*{{{.*$' end='#.*}}}.*$' fold transparent

