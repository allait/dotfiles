" Vimrc

" Pathogen plugin setup
" =====================
" http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen

filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" VIM global options
" ==================

" No vim compatibility
set nocompatible

" No bell sounds
set novisualbell

" Enable xterm mouse support in all modes
set mouse=a

" Set * and + registers to system clipboard, conflicts with yankring
" http://vim.wikia.com/wiki/VimTip984
" set clipboard=unnamed

" Code and syntax options
" =======================

" Set syntax highlighting
syntax on

" Python full highliting
let python_highlight_all=1


" History and swap options
" ========================

"Set maximum undo levels
set undolevels=1000

" Swap files location
set directory=/var/tmp
" Backup files directory
set backupdir=/var/tmp


" File options
" ===================

" Set default file encoding to UTF-8
set encoding=utf-8

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

" Buffer behavior options
" =======================

" Do not warn when switching from unsaved buffer
set hidden
" Autoreload file when changed outside of vim
set autoread

" Set forced buffer rotation on Ctrl+arrows
noremap <C-left> :bp!<CR>
noremap <C-right> :bn!<CR>
" Set forced buffer rotation on Ctrl+h, Ctrl+l
map <C-h> :bp!<CR>
map <C-l> :bn!<CR>


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

" General view options
" ====================

" Show line numbers
set nu

" Highlight current line
set cursorline

" Always show statusline
set laststatus=2

" Status line
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

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

" Number of spaces that a pre-existing tab is equal to
au BufRead,BufNewFile *py,*pyw,*.c,*.h,*html,*js set tabstop=8

" What to use for an indent.
" Python: 4 spaces, soft-tabs
au BufRead,BufNewFile *.py,*pyw,*.html,*.js set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw,*.html,*.js set expandtab

" Keep indentation level from previous line
set autoindent

" Set soft tab length
set softtabstop=4


" Specific highlight options
" ==========================

" Highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/


" Folding options
" ===============

" Folding based on indentation: 
set foldmethod=indent

" Make folds open by default
set nofoldenable


" General keybindings
" ===========================

" Avoid pressing shift for commands and use ; just like :
nnoremap ; :

" Color and gui options
" =============

" Set color scheme
colorscheme mustang

" Set gui-specific options
if has("gui_running")
    " Set gui font
    set guifont=Inconsolata\ Medium\ 10
    " Disable toolbar
    set guioptions-=T
else
    " Set 256-colors mode for console vim
    set t_Co=256
endif


" Plugin-specific settings
" ===============

" Minibufexplorer
" ---------------
" let g:miniBufExplMapWindowNavVim = 1
" let g:miniBufExplMapWindowNavArrows = 1
" let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1


" Pylint
" ------
" Disable onwrite pylint checks
let g:pylint_onwrite = 0

" NERDTree
" --------
" Bind F2 anc Ctrl+K to show/hide file browser
map <C-k> :NERDTreeToggle<CR>
map <silent><F2> :NERDTreeToggle<CR>

" TagList
" -------
" Bind F3 to show/hide tag list
map <silent><F3> :TlistToggle<CR>

" TaskList
" --------
" Bind F4 to show task list
map <silent><F4> :TaskList<CR>

" Command-T
" ---------
" Bind F5 and \e to start command-t file search
map <silent><F5> :CommandT<CR>
nnoremap <leader>e :CommandT<CR>

" SuperTab
" --------
" Set supertab to complete depending on text before cursor
let g:SuperTabDefaultCompletionType="context"

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
" let g:snippets_dir="~/.vim/snippets/"

" Set author in c) snippet
let snips_author = 'Al'

" Use Django snippets in html files
" autocmd FileType html set ft=htmldjango.html

" YankRing
" --------
nmap <silent><F6> :YRShow<CR>

" ShowMarks
" ---------
let g:showmarks_enable=0
