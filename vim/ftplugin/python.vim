setlocal omnifunc=pythoncomplete#Complete
setlocal tabstop=8
compiler pylint

" Setup proper function folding
setlocal foldmethod=syntax

syn region pythonFunctionFold start="^\z(\s*\)\%(def\|class\)\>"
  \ end="\ze\%(\s*\n\)\+\%(\z1\s\)\@!." fold transparent

syn region pythonFold matchgroup=pythonComment
  \ start='#.*{{{.*$' end='#.*}}}.*$' fold transparent
