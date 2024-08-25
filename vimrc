" Because we use a modern plugin manager, we can be sure that the contents of
" the plugin directory will be executed before any external plugin, and hence
" we can have one file per configuration section in the plugin directory,
" which gives us structure clarity. This also allows us to limits this file
" to:
" - Setting `nocompatible`.
" - Installing external plugins.

" According to vim91/defaults.vim. This must be first, because it changes
" other options as a side effect. Avoid side effects when it was already
" reset.
if &compatible
	set nocompatible
endif

" Install external plugins
call plug#begin()

	" Zenburn colorsccheme
	Plug 'jnurmine/Zenburn'

	" Vim airline
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	" fzf
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'

call plug#end()
