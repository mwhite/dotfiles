" mwhite's .vimrc, cobbled from various sources

filetype off
set backspace=2
set rtp+=~/.vim/bundle/vundle/
silent! call vundle#rc()

" Plugins
" =======

if exists('*vundle#rc')
    Bundle 'gmarik/vundle'
    Bundle 'wgibbs/vim-irblack'
    "Bundle 'endel/vim-github-colorscheme'
    colorscheme ir_black

    Bundle 'kien/ctrlp.vim'
    let g:ctrlp_root_markers= ['.git/']   " Search root git dir, not submodule
    let g:ctrlp_regexp = 1

    Bundle 'tpope/vim-fugitive'
    Bundle 'airblade/vim-gitgutter'

    Bundle 'scrooloose/syntastic'
    let g:syntastic_check_on_open=1
    let g:syntastic_enable_signs=0
    
    Bundle 'sjl/gundo.vim'

    Bundle 'bling/vim-airline'
    let g:airline_left_sep=''
    let g:airline_right_sep=''
    let g:airline_enable_syntastic=0

    Bundle 'michaeljsmith/vim-indent-object'
    Bundle 'scrooloose/nerdcommenter'
    "Bundle 'scrooloose/nerdtree'
    let NERDTreeIgnore=[
        \ '\~$',
        \ '\.pyc$',
        \ ]
    
    Bundle 'Raimondi/delimitMate'
    let delimitMate_balance_matchpairs = 1

    Bundle 'guns/vim-clojure-static'


    Bundle 'jmcantrell/vim-virtualenv'
    Bundle 'davidhalter/jedi-vim'
    let g:jedi#popup_on_dot = 0
    let g:jedi#popup_select_first = 0
    let g:jedi#use_tabs_not_buffers = 0
    
    Bundle 'marijnh/tern_for_vim'


    Bundle 'tpope/vim-unimpaired'
    
    Bundle 'ervandew/supertab'
    let g:SuperTabDefaultCompletionType = "context"

    Bundle 'jamessan/vim-gnupg'
    Bundle 'sukima/xmledit'
    Bundle 'tpope/vim-git'
    Bundle 'othree/html5.vim'
    Bundle 'gregsexton/MatchTag'
    Bundle 'pangloss/vim-javascript'
    Bundle 'ap/vim-css-color'
    Bundle 'groenewege/vim-less'
    Bundle 'tpope/vim-markdown'
    Bundle 'vim-pandoc/vim-pandoc'
    let g:pandoc_no_folding = 1
    let g:pandoc_use_hard_wraps = 1

    Bundle 'majutsushi/tagbar'
    let g:tagbar_singleclick = 1

    " Make high-color colorschemes look better on low-color terminals
    Bundle 'godlygeek/csapprox'
    let g:CSApprox_verbose_level = 0
    
    "Bundle 'mattn/zencoding-vim'
    "Bundle 'tpope/vim-surround'
endif

filetype on
syntax on

runtime macros/matchit.vim

" Settings
" ========

if has("gui_running")
    " Hide toolbar
    set guioptions-=T
endif

set nocompatible
filetype plugin on
filetype indent on
set mouse=a
set lazyredraw
set wrap
set number
set cursorline
set splitbelow
set splitright
set laststatus=2
set nofoldenable

" start scrolling when within 5 lines of the top/bottom
set scrolloff=5

" Open moves to the existing buffer instead of reopening it
set switchbuf=useopen,usetab


set expandtab tabstop=4 softtabstop=4 shiftwidth=4  " filetype-specific settings below
set autoindent
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

if has("persistent_undo")
    set undodir=~/.vim/undodir
    set undofile
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

map - :NERDTreeToggle<CR>
map + :TagbarToggle<CR>

map <leader>p :CtrlP<CR>
map <leader>b :CtrlPBuffer<CR>
map <leader>t :CtrlPBufTag<CR>
map <leader>cq :CtrlPQuickfix<CR>

map <leader>a2 :Accordion 2<CR>
map <leader>a3 :Accordion 3<CR>

map <leader>gb :Gblame<CR>
map <leader>gd :Gdiff<CR>
map <leader>gh :Gbrowse<CR>
map <leader>gs :Gstatus<CR>
map <leader>gc :Gcommit<CR>
map <leader>gl :Glog<CR>
map <leader>ge :Gedit<CR>
map <leader>gg :Ggrep<space>

map <leader>se :Errors<CR>
map <leader>uu :GundoToggle<CR>

map <leader>ag :Ack<space>

map <leader>gf :Ggrep <cword><cr>
map <leader>af :Ack <cword><cr>

cabbrev make silent make
cabbrev grep silent grep
cabbrev Ggrep silent Ggrep
cabbrev Glog silent Glog

cabbrev ft set filetype=

let g:jedi#goto_assignments_command = "<leader>l"
let g:jedi#goto_definition_command = "<leader>d"
let g:jedi#rename_command = "<leader>jr"
let g:jedi#usages_command = "<leader>jn"

nnoremap j gj
nnoremap k gk

map <c-j> j<c-e>
map <c-k> k<c-y>

map <leader>w <c-w>
map <Leader>q :q<CR>
map <Leader>v :so ~/.vimrc<CR>

nnoremap <silent> <Esc><Esc> <Esc>:set hlsearch!<CR><Esc>

" Toggle display wrap
map <Leader>tw :setlocal wrap!<CR>

" Merge consecutive empty lines and clean up trailing whitespace
map <Leader>fm :g/^\s*$/,/\S/-j<Bar>%s/\s\+$//<CR>

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

        au BufNewFile,BufRead *.json,*.jison setlocal filetype=javascript
        au BufNewFile,BufRead *.txt,*.log,README,INSTALL setlocal filetype=text
        au BufNewFile,BufRead .gitaliases,.gituser setlocal filetype=gitconfig
        au BufNewFile,BufRead .bash_aliases setlocal filetype=sh

        au QuickFixCmdPost [^l]* nested cwindow | redraw!

        " Highlight cursorline only in the active window
        au WinEnter * setlocal cursorline
        au WinLeave * setlocal nocursorline

        " Remember cursor position
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

        " Leave insert mode after 15 seconds without input
        au CursorHoldI * stopinsert
        au InsertEnter * let updaterestore=&updatetime | set updatetime=15000
        au InsertLeave * let &updatetime=updaterestore

        " Close window if it's quickfix and the only one visible
        au WinEnter * if winnr('$') < 2 && &buftype=="quickfix" | quit | endif
    augroup END

    augroup tab_settings
        au!
        au filetype c,cpp                     setlocal ts=4 sts=4 sw=4 et tw=80
        au filetype python                    setlocal ts=4 sts=4 sw=4 et tw=79
        au filetype sh,csh,tcsh,zsh           setlocal ts=4 sts=4 sw=4 et
        au filetype php,javascript,css        setlocal ts=4 sts=4 sw=4 et tw=80
        au filetype ruby,eruby,yaml           setlocal ts=2 sts=2 sw=2 et
        au filetype text,txt,markdown,pandoc  setlocal ts=4 sts=4 sw=4 et tw=80
        au filetype html,xhtml,xml            setlocal ts=4 sts=4 sw=4 et
        au filetype haskell                   setlocal ts=8 sts=8 sw=8 et
        au filetype vim                       setlocal ts=4 sts=4 sw=4 et
        au filetype tex                       setlocal ts=4 sts=4 sw=4 et tw=80
    augroup END

    augroup ft_javascript
        au!
        au filetype javascript nnoremap <buffer> <leader>d :TernDef<CR>
        au filetype javascript nnoremap <buffer> K :TernDoc<CR>
        au filetype javascript nnoremap <buffer> <leader>jr :TernRename<CR>
        au filetype javascript nnoremap <buffer> <leader>jn :TernRefs<CR>
    augroup END

    augroup ft_html
        au!
        " Use Shift-Return to turn this:
        "   <tag>|</tag>
        "
        " into this:
        "   <tag>
        "        |
        "   </tag>
        au filetype html,htmldjango,jinja nnoremap <buffer> <s-cr>vit<ESC>a<CR><ESC>vito<ESC>i<CR><ESC>
    augroup END

    augroup ft_java
        au!
        au filetype java setlocal makeprg=javac %
    augroup END

    augroup ft_php
        au!
        au filetype php setlocal makeprg=php\ -l\ %
    augroup END

    augroup ft_python
        au! filetype python setlocal formatoptions+=t
    augroup END

    augroup ft_tex
        au!
        au filetype tex setlocal makeprg=pdflatex\ %
    augroup END
endif
