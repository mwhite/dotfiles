" mwhite's .vimrc, cobbled from various sources

" Plugins
" =======

filetype off
set backspace=2
set rtp+=~/.vim/bundle/vundle/
silent! call vundle#rc()

if exists('*vundle#rc')
    Bundle 'gmarik/vundle'
    Bundle 'wgibbs/vim-irblack'
    Bundle 'godlygeek/csapprox'
    let g:CSApprox_verbose_level = 0

    Bundle 'mikewest/vimroom'
    Bundle 'majutsushi/tagbar'
    Bundle 'scrooloose/nerdcommenter'
    Bundle 'scrooloose/nerdtree'
    Bundle 'jistr/vim-nerdtree-tabs'

    Bundle 'acustodioo/vim-enter-indent'
    Bundle 'gregsexton/MatchTag'
    Bundle 'garbas/vim-snipmate'
    Bundle 'Raimondi/delimitMate'
    let delimitMate_autoclose = 1
    let delimitMate_expand_cr = 1
    let delimitMate_expand_space = 1
    let delimitMate_balance_matchpairs = 1

    Bundle 'ap/vim-css-color'
    Bundle 'pangloss/vim-javascript'
    Bundle 'tpope/vim-markdown'
    Bundle 'juvenn/mustache.vim'
    Bundle 'vim-pandoc/vim-pandoc'
    let g:pandoc_no_folding = 1
    let g:pandoc_use_hard_wraps = 1
    Bundle 'nvie/vim-flake8'
    Bundle 'xml.vim'

    " dependencies of snipmate
    Bundle "MarcWeber/vim-addon-mw-utils.git"
    Bundle "tomtom/tlib_vim.git"
    Bundle 'honza/snipmate-snippets'

endif

filetype on
syntax on

" Settings
" ========

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
set completeopt=longest,menuone,preview

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

nnoremap ; :
let mapleader = ","
nmap \ ,

set pastetoggle=<F2>
map + :TagbarToggle<CR>
map - :NERDTreeTabsToggle<CR>

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
map <Leader>t :tabnew<CR>
map <Leader>q :q<CR>

" Reload vimrc
map <Leader>v :so ~/.vimrc<CR>

" Toggle search highlighting
map <Leader>hl :set hlsearch!<CR>

" <Esc><Esc> to clear search highlights
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

" Toggle display wrap
map <Leader>w :set wrap!<CR>

" Merge consecutive empty lines and clean up trailing whitespace
map <Leader>fm :g/^\s*$/,/\S/-j<Bar>%s/\s\+$//<CR>

" Copy and paste to/from OS clipboard
noremap <Leader>yy "+y
noremap <Leader>pp "+gP

" From http://www.agillo.net/simple-vim-window-management/
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr()) "we havent moved
        if (match(a:key,'[jk]')) "were we going up/down
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

" Switch to or create new windows in the given direction
map <Leader>h  :call WinMove('h')<cr>
map <Leader>k  :call WinMove('k')<cr>
map <Leader>l  :call WinMove('l')<cr>
map <Leader>j  :call WinMove('j')<cr>
map <Leader>wc :wincmd q<cr>
map <Leader>wr <C-W>r

" Move current window to the given edge of the frame
map <Leader>H  :wincmd H<cr>
map <Leader>K  :wincmd K<cr>
map <Leader>L  :wincmd L<cr>
map <Leader>J  :wincmd J<cr>

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

        " Change to current directory
        au BufEnter * lcd %:p:h

        " Highlight cursorline only in the active window
        au WinEnter * setlocal cursorline
        au WinLeave * setlocal nocursorline

        " Remember cursor position
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

        " Leave insert mode after 15 seconds without input
        au CursorHoldI * stopinsert
        au InsertEnter * let updaterestore=&updatetime | set updatetime=15000
        au InsertLeave * let &updatetime=updaterestore

    augroup END

    augroup tab_settings
        au!
        au filetype c,cpp                     setlocal ts=4 sts=4 sw=4 et tw=80
        au filetype python                    setlocal ts=4 sts=4 sw=4 et tw=79
        au filetype sh,csh,tcsh,zsh           setlocal ts=4 sts=4 sw=4 et
        au filetype php,javascript,css        setlocal ts=4 sts=4 sw=4 et tw=80
        au filetype ruby,eruby,yaml           setlocal ts=2 sts=2 sw=2 et
        au filetype text,txt,markdown,pandoc  setlocal ts=4 sts=4 sw=4 et tw=80
        au filetype html,xhtml,xml            setlocal ts=2 sts=2 sw=2 noet
        au filetype haskell                   setlocal ts=8 sts=8 sw=8 et
        au filetype vim                       setlocal ts=4 sts=4 sw=4 et
        au filetype tex                       setlocal ts=4 sts=4 sw=4 et tw=80
    augroup END

    augroup ft_bib
        au!
        au filetype bib setlocal makeprg=bibclean\ %
    augroup END

    augroup ft_c
        au!
        " au filetype c setlocal foldmethod=syntax
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
        au filetype java setlocal foldmethod=marker
        au filetype java setlocal foldmarker={,}
        au filetype java setlocal makeprg=javac %
    augroup END

    augroup ft_javascript
        au!
        au BufNewFile,BufRead *.json,*.jison setlocal filetype=javascript

        au filetype javascript setlocal foldmethod=marker
        au filetype javascript setlocal foldmarker={,}
    augroup END

    augroup ft_markdown
        au!
        au filetype markdown setlocal makeprg=pan\ %
    augroup END

    augroup ft_pandoc
        au!
        au filetype pandoc setlocal makeprg=pan\ %
    augroup END

    augroup ft_php
        au!
        au filetype php setlocal makeprg=php\ -l\ %
    augroup END

    augroup ft_python
        au!
    augroup END

    augroup ft_ruby
        au!
        au filetype ruby setlocal foldmethod=syntax
    augroup END

    augroup ft_tex
        au!
        au filetype tex setlocal makeprg=pdflatex\ %
    augroup END

    augroup ft_text
        au!
        au BufRead,BufNewFile *.txt,*.log,README,INSTALL setlocal filetype=text
    augroup END
endif


