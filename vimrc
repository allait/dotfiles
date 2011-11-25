" Vimrc

" Pathogen plugin setup {{{1
" =====================
" http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen

filetype off
call pathogen#runtime_append_all_bundles()

" VIM global options {{{1
" ==================

" No vim compatibility
set nocompatible

" No bell sounds
set noerrorbells
set visualbell
set vb t_vb=""

" Enable xterm mouse support in all modes
set mouse=a

" Disable modeline for security reasons
set nomodeline

" Show current normal mode command
set showcmd

" Syntax options {{{1
" =======================

" Set syntax highlighting
syntax on

" Limit highlighting to x columns to increase speed with long lines
set synmaxcol=2048

" Python full highliting
let python_highlight_all=1


" History and swap options {{{1
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

" File options {{{1
" ============

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

" Viewport behavior options (buffers and windows) {{{1
" ===============================================

" Do not warn when switching from unsaved buffer
set hidden
" Autoreload file when changed outside of vim
set autoread

" Set forced buffer rotation on Ctrl+arrows
noremap <C-left> :bp!<CR>
noremap <C-right> :bn!<CR>

" Switch window splits
nmap <C-Tab> <C-w>w

" Create new split window below the current one
set splitbelow

" Create vertical split window right of the current one
set splitright

" Search and Movement Options {{{1
" ==============

" Incremental search
set incsearch

" Highlight search results
set hlsearch

" Case-insensitive search
set ignorecase

" Case sensitive if search string contains uppercase letters
set smartcase

" Don't move on *
nnoremap * *<C-o>

" Use Emacs C-A and C-E behavior in insert mode
inoremap <C-a> <Esc>I
inoremap <C-e> <Esc>A

" Formatting options {{{1
" ==================

" Configure autowrapping and auto comment leader insertion
set formatoptions=ctrqln

" General view options {{{1
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

" Status line options {{{1
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

" Completion options {{{1
" ==================

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

" When doing tab completion, give the following files lower priority
set suffixes+=.info,.aux,.log,.dvi,.bbl,.out,.o,.loi,.pyc

" Exclude files from listing
set wildignore+=*.aux,*.out,*.toc " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.ico " binary images
set wildignore+=*.pyc,*.luac,*.beam " byte code
set wildignore+=*.o,*.obj,*.manifest " compiled object files
set wildignore+=*.DS_Store? " system files

" Using chicken scheme
let g:is_chicken = 1

" Indentation and tab options {{{1
" ===========================

" Sane default tabstop:
set tabstop=4

" Always convert tabs to spaces
set expandtab

" What to use for an >> and << indent.
set shiftwidth=4

" Round indent to multiple of shiftwidth
set shiftround

" Set soft tab length
set softtabstop=4

" Keep indentation level from previous line
set autoindent

" Folding options {{{1
" ===============

" Folding based on indentation:
set foldmethod=indent

" Make folds open by default
set nofoldenable


" General keymappings {{{1
" ===================

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

" Color and gui options {{{1
" =====================

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

" Specific highlight options {{{1
" ==========================

" Highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

fun! s:MatchBadWhitespace(current)
    if exists('b:hide_bad_whitespace')
        match none
        return
    endif
    if a:current
        match BadWhitespace /\s\+$/
    else
        match BadWhitespace /\s\+\%#\@<!$/
    endif
endfun

augroup WhitespaceMatch
    " Highlight whitespace on open buffer
    autocmd BufWinEnter * call s:MatchBadWhitespace(1)
    " Don't highlight while typing
    autocmd InsertEnter * call s:MatchBadWhitespace(0)
    autocmd InsertLeave * call s:MatchBadWhitespace(1)
    " Clear match when leaving buffer to avoid memory leaks
    autocmd BufWinLeave * call clearmatches()
augroup END

" Plugin-specific settings {{{1
" ========================

" Pylint {{{2
" ------

" Disable onwrite pylint checks
let g:pylint_onwrite = 0

" NERDTree {{{2
" --------
" Bind show/hide file browser
map <silent><F2> :NERDTreeToggle<CR>
nmap <silent><leader>d :NERDTreeToggle<CR>

" Ignore pyc files
let NERDTreeIgnore=['\.pyc$', '\~$']

" Close panel after opening file
"let NERDTreeQuitOnOpen=1

" Change CWD on NERDTree root changes
"let NERDTreeChDirMode=2

" TagBar {{{2
" ------
" Bind show/hide tag list
map <silent><F3> :TagbarToggle<CR>
nmap <silent><leader>f :TagbarToggle<CR>

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

" CtrlP {{{2
" ---------

" \e to search for file name
nmap <silent><leader>e :CtrlP<CR>

" \q to search for buffer name
nmap <silent><leader>q :CtrlPBuffer<CR>

" Don't change the working directory
let g:ctrlp_working_path_mode = 0

" Disable most recently used files list
let g:ctrlp_mru_files = 0

" Don't seach for dotfiles/dirs
let g:ctrlp_dotfiles = 0

" Open new files in the current window
let g:ctrlp_open_new_file = 0

" SuperTab {{{2
" --------

" Set supertab to complete depending on text before cursor
let g:SuperTabDefaultCompletionType="context"

" Use custom context function from autoload/completion
let g:SuperTabCompletionContexts = ['completion#ExtendedContextText']

" Set backwards mapping to work with snipmate's reverse tabstops
let g:SuperTabMappingBackward ='<C-Tab>'

" Disable cr to fix conflict with delimitmate
let g:SuperTabCrMapping = '<C-CR>'

" Syntastic {{{2
" ---------

" Enable syntax error signs, disable prewiew window with error list
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=0

" Bind :Errors to hotkey
nmap <silent> <leader>E :Errors<CR>

" Gundo {{{2
" -----
nmap <silent><leader>u :GundoToggle<CR>

" ShowMarks {{{2
" ---------
" Disable by default
let g:showmarks_enable=0

" Set saner sign colors
hi ShowMarksHLl ctermbg=NONE guibg=NONE guifg=#1C9BEE ctermfg=blue
hi ShowMarksHLu ctermbg=NONE guibg=NONE guifg=#1C9BEE ctermfg=blue
hi ShowMarksHLo ctermbg=NONE guibg=NONE guifg=#1C9BEE ctermfg=blue
hi ShowMarksHLm ctermbg=NONE guibg=NONE guifg=#1C9BEE ctermfg=blue

" Rainbows {{{2
" --------
nmap <leader>r :RainbowParenthesesToggle<CR>

" BufExplorer {{{2
" -----------

" Map F1 to BufExplorer in all modes
nnoremap <silent><F1> :BufExplorer<CR>

" Disable help string
let g:bufExplorerDefaultHelp=0

" Zencoding {{{2
" ---------

" Set <C-z> for insert mode only
imap <C-z> <C-y>

" Ropevim {{{2
" -------

" Change prefixes to <C-q>
let g:ropevim_local_prefix = "<C-q>r"
let g:ropevim_global_prefix = "<C-q>p"

" Disable shorcuts
let g:ropevim_enable_shortcuts = 0

" VimErl {{{2
" ------
let g:erlangCompletionDisplayDoc = 0

" UltiSnips {{{2
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

" Vimwiki {{{2
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

" Commentary {{{2
" ----------

" Map to \c
xmap <leader>c <Plug>Commentary
nmap <leader>c <Plug>Commentary
nmap <leader>cc <Plug>CommentaryLine
