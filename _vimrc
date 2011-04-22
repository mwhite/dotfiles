" mwhite's .vimrc  

" SuperTab preferences: use omnicompletion, then context completion

let g:SuperTabCompletionContexts = ['s:ContextText' , 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:SuperTabContextDiscoverDiscovery = ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]

" include scripts in ~/.vim/bundle/ using vim-pathogen
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

colorscheme ir_black

set number				" line numbers on left side
set incsearch			" incremental search
set mouse=a				" enable mouse features
set pastetoggle=<F2>	" toggle whether to auto-indent external pasted text

set grepprg=grep\ -rnH\ --exclude='*~'\ --exclude='*.svn-base'\ $*

" set default indentation (per-language settings below)
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab

filetype plugin on
filetype indent on

" Case insensitive searches become sensitive with capitals
set smartcase  
set hlsearch

" only complete up to longest common string, always show a menu
set completeopt=longest,menuone,preview

if has("autocmd")
	" language-specific indentation settings
	autocmd FileType c,cpp				setlocal ts=4 sts=4 sw=4 et tw=80 nowrap
	autocmd FileType sh,csh,tcsh,zsh	setlocal ts=4 sts=4 sw=4 noet
	autocmd FileType php,javascript,css	setlocal ts=4 sts=4 sw=4 noet
	autocmd FileType ruby,eruby,yaml	setlocal ts=2 sts=2 sw=2 et
	autocmd FileType text,txt,mkd		setlocal ts=4 sts=4 sw=4 noet tw=80 wrap
	autocmd FileType html,xhtml,xml		setlocal ts=2 sts=2 sw=2 noet
	autocmd FileType haskell			setlocal ts=8 sts=8 sw=8 et

	" language-specific general settings
	autocmd FileType php noremap <C-M> :w!<CR>:!php %<CR>		" run file
	autocmd FileType php noremap <C-L> :w!<CR>:!php -l %<CR>	" check syntax

endif


nnoremap <Space> <PageDown>
nnoremap <S-Space> <PageUp>		" only works in GVim
