" mwhite's .vimrc
silent! colorscheme ir_black

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Github repos:
Bundle 'gmarik/vundle'
Bundle 'msanders/snipmate.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-markdown'
Bundle 'majutsushi/tagbar'

" Tabs (or spaces if expandtab is set) for indentation, spaces elsewhere
Bundle 'Soares/vim-smarttab'

" Vim.org scripts (from vim-scripts github mirror)
Bundle 'jQuery'
Bundle 'xml.vim'

set nocompatible
set number
set wrap
set mouse=a
set autowrite
set incsearch
set smartcase	" Case-insensitive unless search string has capitals

" only complete up to longest common string, always show a menu
set completeopt=longest,menuone,preview

set et ts=4 sts=4 sw=4

set autoindent

filetype plugin on
filetype indent on

set showmatch

set wildmode=longest,full

if has("autocmd")

    autocmd BufRead,BufNewFile *.md setlocal filetype=markdown
    autocmd BufRead,BufNewFile *.jison setlocal filetype=javascript

    autocmd FileType c,cpp              setlocal ts=4 sts=4 sw=4 et tw=80
    autocmd FileType sh,csh,tcsh,zsh    setlocal ts=4 sts=4 sw=4 et
    autocmd FileType php,javascript,css setlocal ts=4 sts=4 sw=4 noet
    autocmd FileType ruby,eruby,yaml    setlocal ts=2 sts=2 sw=2 et
    autocmd FileType text,txt,markdown  setlocal ts=4 sts=4 sw=4 et tw=80
    autocmd FileType html,xhtml,xml     setlocal ts=2 sts=2 sw=2 noet
    autocmd FileType haskell            setlocal ts=8 sts=8 sw=8 et
    autocmd FileType vim                setlocal ts=4 sts=4 sw=4 et

    autocmd FileType markdown           setlocal makeprg=markdown2pdf\ %
    autocmd FileType php                setlocal makeprg=php\ -l\ %

endif

set pastetoggle=<F2>    " toggle whether to auto-indent external pasted text

set grepprg=grep\ -rnH\ --exclude='*~'\ --exclude='*.svn-base'\ $*

nnoremap <silent> <F9> :TagbarToggle<CR>

noremap <C-M> :make<CR><CR>

" Merge consecutive empty lines and clean up trailing whitespace
map <Leader>fm :g/^\s*$/,/\S/-j<Bar>%s/\s\+$//<CR>
map <Leader>v :so ~/.vimrc<CR>

map <Leader>hl :set hlsearch!<CR>

map - :Explore<cr>
map <c-j> j<c-e>
map <c-k> k<c-y>

map <c-l> :tabnext<enter>
imap <c-l> <esc>:tabnext<enter>
map <c-h> :tabprevious<enter>
imap <c-h> <esc>:tabprevious<enter>

map <c-t> :tabnew<enter>i
imap <c-t> <esc>:tabnew<enter>i
