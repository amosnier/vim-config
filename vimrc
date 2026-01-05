" Because we use a modern plugin manager, we can be sure that the contents of
" the plugin directory will be executed before any external plugin, and hence
" we can have one file per configuration section in the plugin directory,
" which gives us structure clarity. This also allows us to limit this file
" to:
" - Setting 'nocompatible'.
" - Setting 'exrc' (local vimrc, when applicable, is executed before the
"   plugin files).
" - Installing external plugins.

" From to vim91/defaults.vim:
" This must be first, because it changes other options as a side effect. Avoid
" side effects when it was already reset.
if &compatible
	set nocompatible
endif

" Allow local .vimrc
set exrc

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

	" Vim visual search (suggested in Practical Vim)
	Plug 'bronson/vim-visual-star-search'

	" Various good-to-have plugins from Tim Pope
	Plug 'tpope/vim-abolish'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-repeat'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-unimpaired'

	" YouCompleteMe. Follow the official plugin instructions for complete
	" installation after initial installation by Vim.
	" https://github.com/ycm-core/YouCompleteMe?tab=readme-ov-file#linux-64-bit
	" at the time of writing.
	Plug 'ycm-core/YouCompleteMe'

	" GPG support
	Plug 'jamessan/vim-gnupg'

	" MD TOC
	Plug 'mzlogin/vim-markdown-toc'

	" GLSL
	Plug 'tikhomirov/vim-glsl'

	" Snippets
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'

	" Edit tags
	Plug 'AndrewRadev/tagalong.vim'

	" Easy align
	Plug 'junegunn/vim-easy-align'

call plug#end()
