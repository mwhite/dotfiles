" mwhite's .vimrc, cobbled from various sources
" =============================================
"
"   1. Vundle repos and plugin settings
"   2. General settings
"   3. Mappings
"   4. Autocommands
"
" =============================================

" -----------------------------------
" 1. Vundle repos and plugin settings
" -----------------------------------

filetype off
set rtp+=~/.vim/bundle/vundle/
silent! call vundle#rc()

if exists('*vundle#rc')
    Bundle 'gmarik/vundle'
    Bundle 'kien/ctrlp.vim'
    Bundle 'jQuery'
    Bundle 'scrooloose/nerdcommenter'
    Bundle 'scrooloose/nerdtree'
    Bundle 'msanders/snipmate.vim'
    Bundle 'kien/tabman.vim'
    Bundle 'ap/vim-css-color'
    Bundle 'tpope/vim-fugitive'
    Bundle 'tpope/vim-markdown'
    Bundle 'mikewest/vimroom'
    Bundle 'xml.vim'

    Bundle 'godlygeek/csapprox'
    Bundle 'molokai'
    Bundle 'wgibbs/vim-irblack'

    Bundle 'majutsushi/tagbar'
    let g:tagbar_singleclick = 1

    Bundle 'Raimondi/delimitMate'
    let delimitMate_autoclose = 1
    let delimitMate_expand_cr = 1
    let delimitMate_expand_space = 1
    let delimitMate_balance_matchpairs = 1

    Bundle 'vim-pandoc/vim-pandoc'
    let g:snips_author = "Michael White <m@mwhite.info>"
    let g:pandoc_no_folding = 1

    " Bundle 'Soares/vim-smarttab'  " buggy/several conflicts
endif

filetype on

" -------------------
" 2. General settings
" -------------------

set t_Co=256
colorscheme ir_black

set nocompatible
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

filetype plugin on
filetype indent on
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

" Backups
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set backup
set backupskip=/tmp/*

" Use sane regexes
nnoremap / /\v
vnoremap / /\v

set grepprg=grep\ -rnH\ --exclude='*~'\ --exclude='*.svn-base'\ $*

" -----------
" 3. MappingS
" -----------

set pastetoggle=<F2>
map + :TagbarToggle<CR>
map - :NERDTreeToggle<CR>

map <Leader>v :so ~/.vimrc<CR>
map <Leader>hl :set hlsearch!<CR>
map <Leader>w :set wrap!<CR>

" Merge consecutive empty lines and clean up trailing whitespace
map <Leader>fm :g/^\s*$/,/\S/-j<Bar>%s/\s\+$//<CR>

noremap <C-M> :make<CR><CR>
nnoremap :W :make<CR><CR>

map H ^
map L $
nnoremap ; :

" Scroll viewport with cursor
map <c-j> j<c-e>
map <c-k> k<c-y>

" Scroll within wrapped lines
nnoremap j gj
nnoremap k gk

" move a line of text using ALT+[jk], indent with ALT+[hl]
nnoremap <A-j> :m+<CR>==
nnoremap <A-k> :m-2<CR>==
nnoremap <A-h> <<
nnoremap <A-l> >>
inoremap <A-j> <Esc>:m+<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
inoremap <A-h> <Esc><<]a
inoremap <A-l> <Esc>>>]a
vnoremap <A-j> :m'>+<CR>gv=gv
vnoremap <A-k> :m-2<CR>gv=gv
vnoremap <A-h> <gv
vnoremap <A-l> >gv

map <c-l> :tabn<CR>
imap <c-l> <ESC>:tabn<CR>
map <c-h> :tabp<CR>
imap <c-h> <ESC>:tabp<CR>

map <c-t> :tabnew<CR>i
imap <c-t> <ESC>:tabnew<CR>i

" Map double-tap Esc to clear search highlights
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

" Disable useless keys
" help key
noremap <F1> :set invfullscreen<CR>
inoremap <F1> <ESC>:set invfullscreen<CR>a
" manual key
nnoremap K <nop>
" hash key
inoremap # X<BS>#

" ---------------
" 4. Autocommands
" ---------------

if has("autocmd")
    augroup general
        au!

        " Highlight cursorline only in the active window
        au WinEnter * setlocal cursorline
        au WinLeave * setlocal nocursorline

        " Remember cursor position
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

        " Change to current directory
        au BufEnter * lcd %:p:h

        " au filetype php,ruby,c,cpp,python,javascript,java nested TagbarOpen

        " Always show line numbers, but only in current window
        au WinEnter * if &modifiable | setlocal number | endif
        au WinLeave * setlocal nonumber

        " Automatically resize vertical splits
        " au WinEnter * :set winfixheight
        " au WinEnter * :wincmd =
    augroup END

    augroup tab_settings
        au!
        au filetype c,cpp                     setlocal ts=4 sts=4 sw=4 et tw=80
        au filetype python                    setlocal ts=4 sts=4 sw=4 et tw=80
        au filetype sh,csh,tcsh,zsh           setlocal ts=4 sts=4 sw=4 et
        au filetype php,javascript,css        setlocal ts=4 sts=4 sw=4 noet
        au filetype ruby,eruby,yaml           setlocal ts=2 sts=2 sw=2 et
        au filetype text,txt,markdown,pandoc  setlocal ts=4 sts=4 sw=4 et tw=80
        au filetype html,xhtml,xml            setlocal ts=2 sts=2 sw=2 noet
        au filetype haskell                   setlocal ts=8 sts=8 sw=8 et
        au filetype vim                       setlocal ts=4 sts=4 sw=4 et
    augroup END

    augroup ft_c
        au!
        " au filetype c setlocal foldmethod=syntax
    augroup END

    augroup ft_css
        au!
        au BufNewFile,BufRead *.less setlocal filetype=less

        au filetype less,css setlocal foldmethod=marker
        au filetype less,css setlocal foldmarker={,}
        au filetype less,css setlocal omnifunc=csscomplete#CompleteCSS
        au filetype less,css setlocal iskeyword+=-

        " Use <Leader>S to sort properties by name
        au BufNewFile,BufRead *.less,*.css nnoremap <buffer> <localleader>S?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>

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
        au filetype markdown setlocal makeprg=markdown2pdf\ %
    augroup END

    augroup ft_pandoc
        au!
        au filetype pandoc setlocal makeprg=markdown2pdf\ %
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


