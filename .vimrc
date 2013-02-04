" mwhite's .vimrc, cobbled from various sources

filetype off
set backspace=2
set rtp+=~/.vim/bundle/vundle/
silent! call vundle#rc()

nnoremap ; :
let mapleader = ","
nmap \ ,

" Plugins
" =======

if exists('*vundle#rc')

    " The best Vim plugin manager
    Bundle 'gmarik/vundle'

    " The best dark colorscheme
    Bundle 'wgibbs/vim-irblack'

    " Make high-color colorschemes look better on low-color terminals
    Bundle 'godlygeek/csapprox'
    let g:CSApprox_verbose_level = 0

    " Color CSS colors with themselves
    Bundle 'ap/vim-css-color'

    " Quickly find files
    Bundle 'kien/ctrlp.vim'
    " Search root git dir, not submodule
    let g:ctrlp_root_markers= ['.git/']

    " Git goodness
    Bundle 'tpope/vim-fugitive'
    map <leader>gb :Gblame<CR>
    map <leader>gd :Gdiff<CR>
    map <leader>gh :Gbrowse<CR>
    map <leader>gs :Gstatus<CR>

    " Transparent editing of encrypted files
    Bundle 'jamessan/vim-gnupg'

    " Snazzy modelines
    Bundle 'Lokaltog/vim-powerline'

    " Syntax and style checking
    Bundle 'scrooloose/syntastic'
    let g:syntastic_check_on_open=1

    " Highlight matching HTML tags
    Bundle 'gregsexton/MatchTag'

    " Easy comment handling
    Bundle 'scrooloose/nerdcommenter'

    " Display a sidebar with directory structure
    Bundle 'scrooloose/nerdtree'
    let NERDTreeIgnore=[
        \ '\~$',
        \ '\.pyc$',
        \ ]
    map - :NERDTreeTabsToggle<CR>

    " Synchronize NERDTree across windows
    Bundle 'jistr/vim-nerdtree-tabs'

    " Awesome snippets
    Bundle 'garbas/vim-snipmate'
    Bundle 'honza/snipmate-snippets'
    Bundle "MarcWeber/vim-addon-mw-utils.git"
    Bundle "tomtom/tlib_vim.git"

    " Do code completion with <tab>
    Bundle 'ervandew/supertab'
    let g:SuperTabDefaultCompletionType = "context"

    
    Bundle 'tpope/vim-surround'


    " Display a sidebar with class outline
    Bundle 'majutsushi/tagbar'
    let g:tagbar_singleclick = 1
    map + :TagbarToggle<CR>

    Bundle 'jmcantrell/vim-virtualenv'

    " Automatically insert closing delimiters
    Bundle 'Raimondi/delimitMate'
    let delimitMate_autoclose = 1
    let delimitMate_expand_cr = 1
    let delimitMate_expand_space = 0
    let delimitMate_balance_matchpairs = 1

    """ Language-specific
    
    " Python completion
    Bundle 'davidhalter/jedi-vim'
    let g:jedi#popup_on_dot = 0

    Bundle 'sukima/xmledit'
    Bundle 'pangloss/vim-javascript'
    Bundle 'groenewege/vim-less'
    Bundle 'tpope/vim-markdown'
    Bundle 'juvenn/mustache.vim'

    " Pandoc goodies, including pandoc extended Markdown syntax support
    Bundle 'vim-pandoc/vim-pandoc'
    let g:pandoc_no_folding = 1
    let g:pandoc_use_hard_wraps = 1

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

set t_Co=256
colorscheme ir_black

set nocompatible
filetype plugin on
filetype indent on
set mouse=a
set wrap
set number
set cursorline
set splitbelow
set splitright

" start scrolling when within 5 lines of the top/bottom
set scrolloff=5

" Open moves to the existing buffer instead of reopening it
set switchbuf=useopen,usetab

" write files you opened without the necessary permissions with :w!!
cmap w!! %!sudo tee > /dev/null %

set expandtab tabstop=4 softtabstop=4 shiftwidth=4  " filetype-specific settings below
set autoindent
set autowrite
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

" Use sane regexes
nnoremap / /\v
vnoremap / /\v

set grepprg=grep\ -rnH\ --exclude='*~'\ --exclude='*.svn-base'\ $*

" Mappings
" ========

set pastetoggle=<F2>

" wincmd (e.g. s, v, h, H)
map <Leader>w <C-W>

" Scroll within wrapped lines
nnoremap j gj
nnoremap k gk

" Scroll viewport with cursor
map <c-j> j<c-e>
map <c-k> k<c-y>

" Switch between tabs
map <c-l> :tabn<CR>
imap <c-l> <ESC>:tabn<CR>
map <c-h> :tabp<CR>
imap <c-h> <ESC>:tabp<CR>

" Tab management
map <Leader>t :tabnew<CR>:edit<Space>
map <Leader>q :q<CR>

" Reload vimrc
map <Leader>v :so ~/.vimrc<CR>

" Toggle search highlighting
map <Leader>hl :set hlsearch!<CR>

" <Esc><Esc> to clear search highlights
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

" Toggle display wrap
map <Leader>tw :setlocal wrap!<CR>

" Merge consecutive empty lines and clean up trailing whitespace
map <Leader>fm :g/^\s*$/,/\S/-j<Bar>%s/\s\+$//<CR>

" Copy and paste to/from OS clipboard
noremap <Leader>yy "+y
noremap <Leader>pp "+gPa<cr><esc>

" Resize current window
nmap <left>    :3wincmd <<cr>
nmap <right>   :3wincmd ><cr>
nmap <up>      :3wincmd +<cr>
nmap <down>    :3wincmd -<cr>

" Disable useless keys
noremap <F1> :set invfullscreen<CR>
inoremap <F1> <ESC>:set invfullscreen<CR>a
" manual key
nnoremap K <nop>
" hash key
inoremap # X<BS>#

" Autocommands
" ============

if has("autocmd")
    augroup general
        au!

        au BufNewFile,BufRead *.json,*.jison setlocal filetype=javascript
        au BufNewFile,BufRead *.txt,*.log,README,INSTALL setlocal filetype=text
        au BufNewFile,BufRead .gitaliases,.gituser setlocal filetype=gitconfig
        au BufNewFile,BufRead .bash_aliases setlocal filetype=sh

        " Change to current directory
        au BufEnter * if expand('%:p') !~ '://' | cd %:p:h | endif

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

    augroup ft_css
        au!
        au BufNewFile,BufRead *.less setlocal filetype=less

        " au filetype less,css setlocal foldmethod=marker
        " au filetype less,css setlocal foldmarker={,}
        au filetype less,css setlocal omnifunc=csscomplete#CompleteCSS
        au filetype less,css setlocal iskeyword+=-

        " Use <Leader>S to sort properties by name
        au BufNewFile,BufRead *.less,*.css nnoremap <buffer> <localLeader>S?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>

        " Make {<CR> insert a pair of brackets with the cursor positioned
        " inside of them AND the following code doesn't get unfolded
        au BufNewFile,BufRead *.less,*.css inoremap <buffer> {<CR> {}<left><CR><Space><Space><Space><Space>.<CR><ESC>kA<BS>
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
        au filetype html,jinja nnoremap <buffer> <s-cr>vit<ESC>a<CR><ESC>vito<ESC>i<CR><ESC>
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
