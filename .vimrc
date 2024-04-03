" mwhite's .vimrc, cobbled from various sources

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set backspace=2

" Plugins
" =======

call plug#begin('~/.vim/plugged')

"" Color theme
Plug 'wgibbs/vim-irblack'

"" Start screen
Plug 'mhinz/vim-startify'

"" File and symbol selector
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jasoncodes/ctrlp-modified.vim'
let g:ctrlp_root_markers= ['.git/', '.git']   " Search root git dir, not submodule
let g:ctrlp_regexp = 1
let g:ctrlp_max_files = 0
map <leader>p :CtrlP<CR>
map <leader>bu :CtrlPBuffer<CR>
map <leader>t :CtrlPBufTag<CR>
map <leader>cq :CtrlPQuickfix<CR>
map <leader>m :CtrlPModified<CR>
map <leader>b :CtrlPBranch<CR>
map <leader>bm :CtrlPBranchModified<CR>

"" Quickfix location opening
Plug 'yssl/QFEnter'
let g:qfenter_keymap = {}
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-CR>', '<C-s>', '<C-x>']
let g:qfenter_keymap.topen = ['<C-t>']

"" Git integration
Plug 'kdheepak/lazygit.nvim', { 'branch': 'nvim-v0.4.3' }
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
let g:gitgutter_max_signs = 10000
map <leader>gb :Gblame<CR>
map <leader>gh :Gbrowse<CR>
map <leader>gg :Ggrep<space>
map <leader>gf :Ggrep <cword><cr>

"" Tagbar
Plug 'majutsushi/tagbar'
let g:tagbar_singleclick = 1
let g:tagbar_sort = 0
map + :TagbarToggle<CR>

"" Syntax checking
Plug 'scrooloose/syntastic'
let g:syntastic_check_on_open=0
let g:syntastic_enable_signs=0
" Slows things down a lot
let g:syntastic_enable_highlighting=0
let g:syntastic_javascript_checkers = ['eslint']

Plug 'milkypostman/vim-togglelist'
let g:toggle_list_no_mappings = 1

"" Undo tree
Plug 'sjl/gundo.vim'
let g:gundo_prefer_python3 = 1
map <leader>uu :GundoToggle<CR>

"" Indent object for braceless languages
Plug 'michaeljsmith/vim-indent-object'

"" Comment toggling
Plug 'scrooloose/nerdcommenter'

"" File manager
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
let NERDTreeIgnore=[
    \ '\~$',
    \ '\.pyc$',
    \ ]
let NERDTreeHijackNetrw=1
map - :NERDTreeTabsToggle<CR>
"autocmd BufWinEnter * NERDTreeMirrorOpen

Plug 'Raimondi/delimitMate'
let delimitMate_balance_matchpairs = 1

"" Python support
Plug 'jmcantrell/vim-virtualenv'
Plug 'davidhalter/jedi-vim'
let g:jedi#popup_on_dot = 0
"let g:jedi#popup_select_first = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#goto_assignments_command = "<leader>l"
let g:jedi#goto_definition_command = "<leader>d"
let g:jedi#rename_command = "<leader>jr"
let g:jedi#usages_command = "<leader>jn"
augroup ft_python
    au! 
    au filetype python setlocal formatoptions+=t
    au filetype python setlocal omnifunc=jedi#completions
augroup END


"" JavaScript support
Plug 'marijnh/tern_for_vim', {'do': 'npm install'}
augroup ft_javascript
    au!
    au filetype javascript nnoremap <buffer> <leader>d :TernDef<CR>
    au filetype javascript nnoremap <buffer> <leader>l :TernDef<CR>
    au filetype javascript nnoremap <buffer> K :TernDoc<CR>
    au filetype javascript nnoremap <buffer> <leader>jr :TernRename<CR>
    au filetype javascript nnoremap <buffer> <leader>jn :TernRefs<CR>
augroup END

Plug 'tpope/vim-unimpaired'

"" Universal tab completion
Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']

"" Syntax pack
Plug 'sheerun/vim-polyglot'

"" Extra functionality for common filetypes
Plug 'jamessan/vim-gnupg'
Plug 'sukima/xmledit'
Plug 'gregsexton/MatchTag'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'ap/vim-css-color'

Plug 'tpope/vim-markdown'
let g:markdown_fenced_languages = ['javascript', 'python', 'html', 'sql', 'json']
"Plug 'vim-pandoc/vim-pandoc'
let g:pandoc_no_folding = 1
let g:pandoc_use_hard_wraps = 1

" Make high-color colorschemes look better on low-color terminals
Plug 'godlygeek/csapprox'
let g:CSApprox_verbose_level = 0

" Intelligently set tab settings
Plug 'tpope/vim-sleuth'

call plug#end()

colorscheme ir_black

filetype on
syntax on

runtime macros/matchit.vim

" Settings
" ========

if has("gui_running")
    " Hide toolbar
    set guioptions-=T
endif

set secure
set nocompatible
filetype plugin on
filetype indent on
syntax on
set mouse=a
set lazyredraw
set wrap
set number
set cursorline
set splitbelow
set splitright
set laststatus=2
set nofoldenable

set autoread
set title
set titleold=
set updatetime=500

" start scrolling when within 5 lines of the top/bottom
set scrolloff=5

" Open moves to the existing buffer instead of reopening it
set switchbuf=useopen,usetab


set textwidth=80
set expandtab tabstop=4 softtabstop=4 shiftwidth=4  " filetype-specific settings below
set autoindent
set breakindent
set hlsearch
set incsearch
set ignorecase
set smartcase

" insert completion: complete up to longest common string, always show a menu
"set completeopt=longest,menuone,preview

" command completion: complete up to longest common string, show menu
set wildmenu
set wildmode=longest:full,full
set wildignore+=.hg,.git,.svn
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest
set wildignore+=*.DS_Store
set wildignore+=*.pyc

set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set backup
set backupskip=/tmp/*

if !isdirectory(&backupdir)
    call mkdir(expand(&backupdir), "p")
endif

if has("persistent_undo")
    set undodir=~/.vim/undodir
    set undofile
    if !isdirectory(&undodir)
        call mkdir(expand(&undodir), "p")
    endif
endif

" Make diffs look better
highlight! link DiffText MatchParen

" write files you opened without the necessary permissions with :w!!
cmap w!! %!sudo tee > /dev/null %

" Use sane regexes
nnoremap / /\v
vnoremap / /\v

set grepprg=grep\ -rnH\ --exclude='*~'\ --exclude='*.svn-base'\ $*

" Mappings
" ========

set pastetoggle=<F2>

nnoremap ; :
let mapleader = ","
nmap \ ,



map <leader>se :Errors<CR>

nmap <script> <silent> <leader>tl :call ToggleLocationList()<CR>
nmap <script> <silent> <leader>tql :call ToggleQuickfixList()<CR>

"cabbrev make silent make
cabbrev grep silent grep
cabbrev Ggrep silent Ggrep
cabbrev Glog silent Glog


nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

map <c-j> j<c-e>
map <c-k> k<c-y>

map <leader>w <c-w>
map <Leader>q :q<CR>

nnoremap <silent> <Esc><Esc> <Esc>:set hlsearch!<CR><Esc>

" Toggle display wrap
map <Leader>tw :setlocal wrap!<CR>

" Copy and paste to/from OS clipboard
noremap <Leader>sy "+y
noremap <Leader>sp "+gPa<cr><esc>

" Resize current window
nmap <left>    :3wincmd <<cr>
nmap <right>   :3wincmd ><cr>
nmap <up>      :3wincmd +<cr>
nmap <down>    :3wincmd -<cr>

" Change to current directory
command! Cwd if expand('%:p') !~ '://' | cd %:p:h | endif

" Disable useless keys
noremap <PageUp> <nop>
noremap <PageDown> <nop>

noremap <F1> :set invfullscreen<CR>
inoremap <F1> <ESC>:set invfullscreen<CR>a
" manual key
nnoremap K <nop>


" Autocommands
" ============

if has("autocmd")
    augroup general
        au!

        au BufEnter * set title

        au QuickFixCmdPost [^l]* nested cwindow | redraw!

        " Highlight cursorline only in the active window
        au WinEnter * setlocal cursorline
        au WinLeave * setlocal nocursorline

        " Remember cursor position
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

        " Close window if it's quickfix and the only one visible
        au WinEnter * if winnr('$') < 2 && &buftype=="quickfix" | quit | endif
        
        au BufNewFile,BufRead *.json,*.jison setlocal filetype=javascript
    augroup END

    augroup ft_java
        au!
        au filetype java setlocal makeprg=javac %
    augroup END

    augroup ft_php
        au!
        au filetype php setlocal makeprg=php\ -l\ %
    augroup END

    augroup ft_tex
        au!
        au filetype tex setlocal makeprg=pdflatex\ %
    augroup END
endif
