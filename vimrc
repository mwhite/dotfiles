" mwhite's .vimrc
set nocompatible
silent! colorscheme ir_black

set rtp+=~/.vim/bundle/vundle/
silent! call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Github repos:
Bundle 'msanders/snipmate.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-markdown'

" Vim.org scripts
Bundle 'Smart-Tabs'
Bundle 'jQuery'

set smartindent
set wrap
set autowrite
set number
set incsearch
set mouse=a
set pastetoggle=<F2>	" toggle whether to auto-indent external pasted text

set grepprg=grep\ -rnH\ --exclude='*~'\ --exclude='*.svn-base'\ $*

" set default indentation (per-language settings below)
set tabstop=4 softtabstop=4 shiftwidth=4

filetype plugin on
filetype indent on

" Case insensitive searches except with capitals
set smartcase
set hlsearch

" only complete up to longest common string, always show a menu
set completeopt=longest,menuone,preview

" Merge consecutive empty lines and clean up trailing whitespace
map <Leader>fm :g/^\s*$/,/\S/-j<Bar>%s/\s\+$//<CR>

" reload vimrc
map <Leader>v :so ~/.vimrc<CR>

if has("autocmd")

	autocmd BufRead,BufNewFile *.md setlocal filetype=markdown

	" language-specific indentation settings
	autocmd FileType c,cpp				setlocal ts=4 sts=4 sw=4 tw=80 et
	autocmd FileType sh,csh,tcsh,zsh	setlocal ts=4 sts=4 sw=4
	autocmd FileType php,javascript,css	setlocal ts=4 sts=4 sw=4
	autocmd FileType ruby,eruby,yaml	setlocal ts=2 sts=2 sw=2 et
	autocmd FileType text,txt,mkd		setlocal ts=4 sts=4 sw=4 tw=80 et
	autocmd FileType html,xhtml,xml		setlocal ts=2 sts=2 sw=2
	autocmd FileType haskell			setlocal ts=8 sts=8 sw=8

	" Make programs
	autocmd FileType markdown			setlocal makeprg=markdown2pdf\ %
	autocmd FileType php				setlocal makeprg=php\ -l\ %

endif

noremap <C-M> :make<CR><CR>

nnoremap <Space> <PageDown>
nnoremap <S-Space> <PageUp>		" only works in GVim
