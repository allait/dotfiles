" vim:tabstop=2:shiftwidth=2:expandtab:foldmethod=marker:textwidth=79
" Vimwiki syntax file
" Markdown syntax

" text: *strong*
" let g:vimwiki_rxBold = '\*[^*]\+\*'
let g:vimwiki_rxBold = '\%(^\|\s\|[[:punct:]]\)\@<='.
      \'\(\*\*\|__\)'.
      \'\%([^_*`[:space:]][^_*`]*[^_*`[:space:]]\|[^_*`[:space:]]\)'.
      \'\(\*\*\|__\)'.
      \'\%([[:punct:]]\|\s\|$\)\@='
let g:vimwiki_char_bold = '**'

" text: _emphasis_
" let g:vimwiki_rxItalic = '_[^_]\+_'
let g:vimwiki_rxItalic = '\%(^\|\s\|[[:punct:]]\)\@<='.
      \'\(\*\|_\)'.
      \'\%([^_*`[:space:]][^_*`]*[^_*`[:space:]]\|[^_*`[:space:]]\)'.
      \'\(\*\|_\)'.
      \'\%([[:punct:]]\|\s\|$\)\@='
let g:vimwiki_char_italic = '*'

" text: *_bold italic_* or _*italic bold*_
let g:vimwiki_rxBoldItalic = '\%(^\|\s\|[[:punct:]]\)\@<='.
      \'\(\*\*\*\|___\)'.
      \'\%([^*_`[:space:]][^*_`]*[^*_`[:space:]]\|[^*_`[:space:]]\)'.
      \'\(___\|\*\*\*\)'.
      \'\%([[:punct:]]\|\s\|$\)\@='
let g:vimwiki_char_bolditalic = '\*\*\*'

let g:vimwiki_rxItalicBold = '\%(^\|\s\|[[:punct:]]\)\@<='.
      \'\(___\|\*\*\*\)'.
      \'\%([^*_`[:space:]][^*_`]*[^*_`[:space:]]\|[^*_`[:space:]]\)'.
      \'\(\*\*\*\|___\)'.
      \'\%([[:punct:]]\|\s\|$\)\@='
let g:vimwiki_char_italicbold = '___'

" text: `code`
let g:vimwiki_rxCode = '`[^`]\+`'
let g:vimwiki_char_code = '`'

" text: ~~deleted text~~
let g:vimwiki_rxDelText = '\~\~[^~`]\+\~\~'
let g:vimwiki_char_deltext = '\~\~'

" text: ^superscript^
let g:vimwiki_rxSuperScript = '\^[^^`]\+\^'
let g:vimwiki_char_superscript = '^'

" text: ,,subscript,,
let g:vimwiki_rxSubScript = ',,[^,`]\+,,'
let g:vimwiki_char_subscript = ',,'

" Header levels, 1-6
let g:vimwiki_rxH1 = '\(^#\{1}\s\+.*$\|^.\+\n=\+$\)'
let g:vimwiki_rxH2 = '\(^#\{2}\s\+.*$\|^.\+\n-\+$\)'
let g:vimwiki_rxH3 = '^#\{3}\s\+.*$'
let g:vimwiki_rxH4 = '^#\{4}\s\+.*$'
let g:vimwiki_rxH5 = '^#\{5}\s\+.*$'
let g:vimwiki_rxH6 = '^#\{6}\s\+.*$'
let g:vimwiki_rxHeader = '\%('.g:vimwiki_rxH1.'\)\|'.
      \ '\%('.g:vimwiki_rxH2.'\)\|'.
      \ '\%('.g:vimwiki_rxH3.'\)\|'.
      \ '\%('.g:vimwiki_rxH4.'\)\|'.
      \ '\%('.g:vimwiki_rxH5.'\)\|'.
      \ '\%('.g:vimwiki_rxH6.'\)'

let g:vimwiki_char_header = ''

" <hr>, horizontal rule
let g:vimwiki_rxHR = '^---.*$'

" List items start with optional whitespace(s) then '* ' or '+'
let g:vimwiki_rxListBullet = '^\s*\%(\*\|-\|+\)\s'
let g:vimwiki_rxListNumber = '^\s*\d\+.\s'

let g:vimwiki_rxListDefine = '::\(\s\|$\)'

" Preformatted text
let g:vimwiki_rxPreStart = '```'
let g:vimwiki_rxPreEnd = '```'