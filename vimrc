" mwhite's .vimrc
silent! colorscheme ir_black

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Github repos:
Bundle 'gmarik/vundle'
Bundle 'msanders/snipmate.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-markdown'
" Tabs (or spaces if expandtab is set) for indentation, spaces elsewhere
Bundle 'Soares/vim-smarttab'

" Vim.org scripts (from vim-scripts github mirror)
Bundle 'jQuery'

set nocompatible
set number
set wrap
set mouse=a
set autowrite
set incsearch
set smartcase	" Case-insensitive unless search string has capitals

" only complete up to longest common string, always show a menu
set completeopt=longest,menuone,preview

set noet ts=4 sts=4 sw=4

set autoindent

filetype plugin on
filetype indent on

set showmatch

set wildmode=longest,full

if has("autocmd")

    autocmd BufRead,BufNewFile *.md setlocal filetype=markdown

    autocmd FileType c,cpp              setlocal ts=4 sts=4 sw=4 et tw=80
    autocmd FileType sh,csh,tcsh,zsh    setlocal ts=4 sts=4 sw=4 et
    autocmd FileType php,javascript,css setlocal ts=4 sts=4 sw=4 noet
    autocmd FileType ruby,eruby,yaml    setlocal ts=2 sts=2 sw=2 et
    autocmd FileType text,txt,mkd       setlocal ts=4 sts=4 sw=4 et tw=80
    autocmd FileType html,xhtml,xml     setlocal ts=2 sts=2 sw=2 noet
    autocmd FileType haskell            setlocal ts=8 sts=8 sw=8 et
    autocmd FileType vim                setlocal ts=4 sts=4 sw=4 et

    autocmd FileType markdown           setlocal makeprg=markdown2pdf\ %
    autocmd FileType php                setlocal makeprg=php\ -l\ %

endif

set pastetoggle=<F2>    " toggle whether to auto-indent external pasted text

set grepprg=grep\ -rnH\ --exclude='*~'\ --exclude='*.svn-base'\ $*

noremap <C-M> :make<CR><CR>

" Merge consecutive empty lines and clean up trailing whitespace
map <Leader>fm :g/^\s*$/,/\S/-j<Bar>%s/\s\+$//<CR>
map <Leader>v :so ~/.vimrc<CR>

map <Leader>hl :set hlsearch!<CR>

