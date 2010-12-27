" Vimrc

" Pathogen plugin setup
" =====================
" http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen

filetype off
" call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" VIM global options
" ==================

" No vim compatibility
set nocompatible

" Disable intro message
" set shortmess+=I

" No bell sounds
set noerrorbells
set visualbell
set vb t_vb=""

" Enable xterm mouse support in all modes
set mouse=a

" Disable modeline for security reasons
set nomodeline

" Keep cursor in the middle of the screen
" set scrolloff=999

" Set * and + registers to system clipboard, conflicts with yankring
" http://vim.wikia.com/wiki/VimTip984
" set clipboard=unnamed

" Code and syntax options
" =======================

" Set syntax highlighting
syntax on

" Limit highlighting to x columns to increase speed with long lines
" set synmaxcol=160

" Python full highliting
let python_highlight_all=1


" History and swap options
" ========================

"Set maximum undo levels
set undolevels=1000

" Swap files location
set directory=~/tmp/swap/
" Backup files directory
set backupdir=~/tmp/backup/
" Undo files directory
set undodir=~/tmp/undo/

" Enable undo file for persistent undo
set undofile

" Maximum number of lines to save for undo on buffer reload
set undoreload=10000

" Enable backups
set backup

" File options
" ===================

" Set default file encoding to UTF-8
set encoding=utf-8

" When doing tab completion, give the following files lower priority
set suffixes+=.info,.aux,.log,.dvi,.bbl,.out,.o,.loi,.pyc

" Use UNIX (\n) line endings for new files
set fileformat=unix

" Enable filetype plugin
filetype plugin on

" Indent depending on filetype
filetype indent on

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Viewport behavior options (buffers and windows)
" =======================

" Do not warn when switching from unsaved buffer
set hidden
" Autoreload file when changed outside of vim
set autoread

" Set forced buffer rotation on Ctrl+arrows
noremap <C-left> :bp!<CR>
noremap <C-right> :bn!<CR>

" Set forced buffer rotation on Ctrl+h, Ctrl+l
" map <C-h> :bp!<CR>
" map <C-l> :bn!<CR>

"Switch window splits
nmap <C-Tab> <C-w>w

" Search Options
" ==============

" Incremental search
set incsearch

" Highlight search results
set hlsearch
" Reset highlighting on Space
nnoremap <silent><Space> :nohlsearch<Bar>:echo<CR>

" Case-insensitive search
set ignorecase

" Case sensitive is search string contains uppercase letters
set smartcase

" Formatting options
" ==================

" Set textwidth for long line insertion. Will break lines over n characters long on space.
" Allows to format comments with `gq` 
" set textwidth=100

" General view options
" ====================

" Show line numbers
set nu

" Highlight current line
set cursorline

" Highlight column
" set colorcolumn=85

" Show invisible symbols
set list
set listchars=tab:▸\ ",eol:¬

" Status line options
" ===================

" Always show statusline
set laststatus=2

" Status line
if has('statusline')
    set statusline=%<%f\  " Current file path
    set statusline+=%m%h%r%w " File flags - modified, help buffer, readonly, preview
    set statusline+=%y " Filetype
    set statusline+=%{fugitive#statusline()} " File git status
    set statusline+=%= " Indent to the right
    set statusline+=%-20.(%4.l/%L,\ %c%V%)\  "Current line number/total, column number
    set statusline+=%P\  "Percentage through a file
    "set statusline+=[%{&fileformat}] " file format (unix/mac/win)
    set statusline+=[%{(&fenc==\"\"?&enc:&fenc)}]\  "File encoding
    set statusline+={%n} "Buffer number
endif

" Completion options
" =======================

" Enable menu at the bottom of vim window
set wildmenu
" Set menu behavior
set wildmode=list:longest,full

" Set competion menu behavior, preview window disabled
set completeopt=menu ",preview

" Autohide preview window after selection
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

" Filetype-specific omnicompletion
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS


" Indentation and tab options
" ===========================

" Sane default tabstop:
set tabstop=4

" Always convert tabs to spaces
set expandtab

" Number of spaces that a pre-existing tab is equal to
au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=8

" What to use for an >> and << indent.
set shiftwidth=4

" Set soft tab length
set softtabstop=4

" Where filesize matters: html, js and css: 2-space indents
au BufRead,BufNewFile *.html,*.js,*.css set shiftwidth=2
au BufRead,BufNewFile *.html,*.js,*.css set softtabstop=2
au BufRead,BufNewFile *.html,*.js,*.css set tabstop=2

" Keep indentation level from previous line
set autoindent


" Specific highlight options
" ==========================

" Highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Treat html files as Django templates. Breaks some stuff
" autocmd FileType html set ft=html.htmldjango

" Folding options
" ===============

" Folding based on indentation: 
set foldmethod=indent

" Make folds open by default
set nofoldenable


" General keymappings
" ===========================

" Unbind <C-Q> from "visual block"
noremap <C-q> <Nop>

" Use <C-q> in GUI and <C-c> in shell as prefix for personal commands
nmap <C-c> <C-q>

" Avoid pressing shift for commands and use ; just like :
nnoremap ; :

" Set backspace behavior
set backspace=indent,eol,start

" Clean whitespace
map <leader>W mw:%s/\s\+$//<cr>:let @/=''<CR>`w

" Call par reformater on paragraph with textwidth 100
map <C-q>f {v}!par w100<CR>

" Call par reformater on selection with textwidth 100
vmap <C-q>f !par w100<CR>

" Toggle fullscreen(MacVim only) on F11
if has("gui_macvim")
    set fuoptions=maxvert,maxhorz
    inoremap <F11> <ESC>:set invfullscreen<CR>a
    nnoremap <F11> :set invfullscreen<CR>
    vnoremap <F11> :set invfullscreen<CR>
endif

" Color and gui options
" =============

" Set color scheme
colorscheme molokai

" Set gui-specific options
if has("gui_running")
    " Set gui font
    if !has("gui_macvim")
        set guifont=Droid\ Sans\ Mono\ Slashed\ 8
    endif
    " Disable toolbar
    set guioptions-=T
    " Disable left scrollbar
    set guioptions-=l
    set guioptions-=L
    " Disable right scrollbar
    set guioptions-=r
    set guioptions-=R
    " Disable bottom scrollbar
    set guioptions-=b
else
    " Set 256-colors mode for console vim
    " set t_Co=256
    colorscheme default
endif


" Plugin-specific settings
" ===============

" Minibufexplorer
" ---------------
" let g:miniBufExplMapWindowNavVim = 1
" let g:miniBufExplMapWindowNavArrows = 1
" let g:miniBufExplMapCTabSwitchBufs = 1

" let g:miniBufExplModSelTarget = 1

" Disable plugin
let g:loaded_minibufexplorer = 1

" LustyJuggler & LustyExplorer
" ------------ - -------------

" Show key hints near buffer names
let g:LustyJugglerShowKeys = 'a'

" Instant switch to previous buffer
nmap <silent> <Tab> :LustyJugglePrevious<CR>

" Pylint
" ------
" Disable onwrite pylint checks
let g:pylint_onwrite = 0

" NERDTree
" --------
" Bind F2 to show/hide file browser
map <silent><F2> :NERDTreeToggle<CR>

" TagList
" -------
" Bind F3 to show/hide tag list
map <silent><F3> :TlistToggle<CR>

" Django templates setting
let g:tlist_htmldjango_settings = 'html;a:anchor;f:javascript function'

" TaskList
" --------
" Bind F4 to show task list
map <silent><F4> :TaskList<CR>

" Command-T
" ---------
" Bind F5 and \e to start command-t file search
map <silent><F5> :CommandT<CR>
nnoremap <leader><CR> :CommandT<CR>
nnoremap <leader>e :CommandT<CR>

" SuperTab
" --------

" Set supertab to complete depending on text before cursor
let g:SuperTabDefaultCompletionType="context"

" Set backwards mapping to work with snipmate's reverse tabstops
let g:SuperTabMappingBackward ='<C-Tab>'

" Disable cr to fix conflict with delimitmate
let g:SuperTabCrMapping = '<C-CR>'

" DelimitMate
" -----------

" Expand space inside empty pairs
let g:delimitMate_expand_space = 1

" Expand newlines inside empty pairs
let g:delimitMate_expand_cr = 1

" Syntastic
" ---------
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statuslineu=%*
" Enable syntax error signs, disable prewiew window with error list
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=0

" AlignMaps
" ---------
" Hide AlignMaps menu
let g:DrChipTopLvlMenu= ""

" SnipMate
" --------

" Set snippet directory to allow disabling built-in snippets
let g:snippets_dir="~/.vim/snippets/"

" Set author in c) snippet
let snips_author = 'Al'

" YankRing
" --------

" Show yankring menu on F6
nmap <silent><F6> :YRShow<CR>

" Store history file in tmp folder
let g:yankring_history_dir = "~/tmp"

" Don't add one-letter deletes to history
let g:yankring_min_element_length = 2

" Don't store history between sessions
let g:yankring_persist = 0

" Limit yank history
let g:yankring_max_history=10

" ShowMarks
" ---------
let g:showmarks_enable=0

" Rainbows
" --------
nmap <leader>R :RainbowParenthesesToggle<CR>

" Gundo
" -----
nmap <silent> <F7> :GundoToggle<CR>

" BufExplorer
" -----------
nmap <F1> :BufExplorer<CR>

" Zencoding
" ---------

"Set leader key to a more mnemonic Ctrl+z (as in 'zen')
let g:user_zen_leader_key = '<C-z>'

" Set <C-z>z shortcut(does the same thing as <c-z>,
imap <C-z>z <C-z>,

" VCScommand
" ----------

" Switch to \v to avoid conflict with nerdcommenter
let g:VCSCommandMapPrefix = '<Leader>v'

" AlignMaps
" ---------

" Disable alignmaps bindings
let g:loaded_AlignMapsPlugin=1

" Ropevim
" -------

" Change prefixes to <C-q>
let g:ropevim_local_prefix = "<C-q>r"
let g:ropevim_global_prefix = "<C-q>p"

" Disable shorcuts
let g:ropevim_enable_shortcuts = 0