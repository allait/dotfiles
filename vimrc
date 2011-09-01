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

" Scroll when cursor is n lines before window border
" set scrolloff=1

" Show current normal mode command
set showcmd

" Code and syntax options
" =======================

" Set syntax highlighting
syntax on

" Limit highlighting to x columns to increase speed with long lines
set synmaxcol=2048

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

" Exclude files from listing
set wildignore+=*.pyc,*.o,*.out,*.aux

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

"Switch window splits
nmap <C-Tab> <C-w>w

" Search Options
" ==============

" Incremental search
set incsearch

" Highlight search results
set hlsearch

" Case-insensitive search
set ignorecase

" Case sensitive if search string contains uppercase letters
set smartcase

" Formatting options
" ==================

" Set textwidth for long line insertion. Will break lines over n characters long on space.
" Allows to format comments with `gq`
" This keeps breaking in HTML despite all fo-=t
" set textwidth=80

" Configure autowrapping and auto comment leader insertion
set formatoptions=croql

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
    set statusline+=%= " Indent to the right
    set statusline+=%-20.(%4.l/%L,\ %c%V\ [x%B]%)\  "Current line number/total, column number, byte code
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
" Complete only common letters among possible completions, not the while first
" option
set completeopt=menu,longest ",preview

" Autohide preview window after selection
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

" Racket is scheme, and we have only syntax completion for scheme
au BufRead,BufNewFile *.rkt set filetype=scheme

" We're using chicken scheme
let g:is_chicken = 1


" Indentation and tab options
" ===========================

" Sane default tabstop:
set tabstop=4

" Always convert tabs to spaces
set expandtab

" What to use for an >> and << indent.
set shiftwidth=4

" Set soft tab length
set softtabstop=4

" Keep indentation level from previous line
set autoindent

" Folding options
" ===============

" Folding based on indentation:
set foldmethod=indent

" Make folds open by default
set nofoldenable


" General keymappings
" ===========================

" Use <Cr> as alternative mapleader
nmap <CR> <leader>

" Reset highlighting on Space
nmap <silent><Space> :nohlsearch<Bar>:echo<CR>

" Use <M-CR> to continue current line
imap <M-CR> \<CR>

" Unbind <C-Q> from "visual block"
noremap <C-q> <Nop>

" Use <C-q> in GUI and <C-c> in shell as prefix for personal commands
nmap <C-c> <C-q>
vmap <C-c> <C-q>

" Set backspace behavior
set backspace=indent,eol,start

" Clean whitespace
map <C-q>w mw:%s/\s\+$//<cr>:let @/=''<CR>`w

" Call par reformater on paragraph with textwidth 100
map <C-q>f {v}!par w100<CR>

" Call par reformater on selection with textwidth 100
vmap <C-q>f !par w100<CR>

" Show the name of highlightning group under cursor - usefull for syntax theme
" editing
nmap <silent> <C-F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
     \ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
     \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
     \ . ">"<CR>h

" No more arrows
map <up> <nop>
map <left> <nop>
map <right> <nop>
map <down> <nop>
imap <up> <nop>
imap <left> <nop>
imap <right> <nop>
imap <down> <nop>

" Color and gui options
" =============


" Set gui-specific options
if has("gui_running")
    " Set color scheme
    colorscheme prefect
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
    " Set gui window size
    set lines=80 columns=100
else
    " Set color scheme
    colorscheme jellybeans
endif

" Stretch window in fullscreen mode
if has("gui_macvim")
   set fuoptions=maxvert,maxhorz
endif

" Specific highlight options
" ==========================

" Highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
match BadWhitespace /\s\+$/
" Highlight whitespace on open buffer
autocmd BufWinEnter * match BadWhitespace /\s\+$/
" Don't highlight while typing
autocmd InsertEnter * match BadWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match BadWhitespace /\s\+$/
" Clear match when leaving buffer to avoid memory leaks
autocmd BufWinLeave * call clearmatches()

" Plugin-specific settings
" ===============

" Pylint
" ------

" Disable onwrite pylint checks
let g:pylint_onwrite = 0

" NERDTree
" --------
" Bind F2 to show/hide file browser
map <silent><F2> :NERDTreeToggle<CR>

" Ignore pyc files
let NERDTreeIgnore=['\.pyc$', '\~$']

" Close panel after opening file
"let NERDTreeQuitOnOpen=1

" Change CWD on NERDTree root changes
"let NERDTreeChDirMode=2

" TagBar
" -------
" Bind F3 to show/hide tag list
map <silent><F3> :TagbarToggle<CR>

" Show Tagbar window on the left
let g:tagbar_left = 1

" Set tagbar window width
let g:tagbar_width = 30

" Change focus to Tagbar on open
let g:tagbar_autofocus = 1

" Don't sort tags by name
let g:tagbar_sort = 0

" Don't show help line
let g:tagbar_compact = 1

" TaskList
" --------
" Bind F4 to show task list
map <silent><F4> :TaskList<CR>

" Command-T
" ---------
" Bind F5 and \e to start command-t file search
map <silent><F5> :CommandT<CR>
nmap <silent><leader>e :CommandT<CR>

" \q to search for buffer name
nmap <silent><leader>q :CommandTBuffer<CR>

" Use Esc to close command-t window
let g:CommandTCancelMap = ['<C-c>', '<ESC>']

" SuperTab
" --------

" Set supertab to complete depending on text before cursor
let g:SuperTabDefaultCompletionType="context"

" Try omnifunc and completefunc if ContextText failed
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:SuperTabContextDiscoverDiscovery = ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]

" Set backwards mapping to work with snipmate's reverse tabstops
let g:SuperTabMappingBackward ='<C-Tab>'

" Disable cr to fix conflict with delimitmate
let g:SuperTabCrMapping = '<C-CR>'

" Syntastic
" ---------

" Enable syntax error signs, disable prewiew window with error list
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=0

" Bind :Errors to hotkey
nmap <silent> <leader>E :Errors<CR>

" YankRing
" --------

" Show yankring menu on F6
nmap <silent><F6> :YRShow<CR>

" Store history file in tmp folder
let g:yankring_history_dir = "~/tmp"

" Don't store history between sessions
let g:yankring_persist = 0

" Limit yank history
let g:yankring_max_history=10

" Gundo
" -----
map <silent><F7> :GundoToggle<CR>

" ShowMarks
" ---------
let g:showmarks_enable=0

" Rainbows
" --------
nmap <leader>R :RainbowParenthesesToggle<CR>

" BufExplorer
" -----------

" Map F1 to BufExplorer in all modes
nnoremap <silent><F1> :BufExplorer<CR>

" Disable help string
let g:bufExplorerDefaultHelp=0

" Zencoding
" ---------

" Set <C-z> for insert mode only
imap <C-z> <C-y>

" VCScommand
" ----------

" Switch to \v to avoid conflict with nerdcommenter
let g:VCSCommandMapPrefix = '<Leader>v'

" Ropevim
" -------

" Change prefixes to <C-q>
let g:ropevim_local_prefix = "<C-q>r"
let g:ropevim_global_prefix = "<C-q>p"

" Disable shorcuts
let g:ropevim_enable_shortcuts = 0

" VimErl
" ------
let g:erlangCompletionDisplayDoc = 0

" UltiSnips
" ---------

" Set jump forward key
let g:UltiSnipsJumpForwardTrigger = "<Tab>"

" Set jump backward key
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"

" List all available snippets
let g:UltiSnipsListSnippets = "<F1>"

" Set UltiSnips edit snippet directory
let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'

" Set UltiSnips folder names
let g:UltiSnipsSnippetDirectories = ["UltiSnips", "snippets"]

" Use hardtabs in snippets for agile sw handling
au FileType snippets setl noexpandtab

" Vimwiki
" -------

" Default wiki with .md files and vimwiki_markdown syntax file
let g:vimwiki_list = [{'path': '~/wiki', 'ext': '.md', 'syntax':'markdown'}]

" Use markdown filetype for files outside wiki path
let g:vimwiki_global_ext = 0

" Highlight headers
let g:vimwiki_hl_headers = 1

" Use Mac OS X `open` for external links
let g:vimwiki_browsers = ['open']

" Enable ctags markdown headers listing
let g:tlist_vimwiki_settings = 'markdown;h:Headers'

" Set up folding
let g:vimwiki_folding = 1
let g:vimwiki_fold_lists = 1

" Disable Tab mapping for table formatting
let g:vimwiki_table_auto_fmt = 0

" Disable wikiwords
let g:vimwiki_camel_case = 0
