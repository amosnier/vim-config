" Zenburn color scheme
colors zenburn

" Enable mouse support
set mouse=a

" YCM installation function
function! BuildYCM(info)
	" info is a dictionary with 3 fields
	" - name:   name of the plugin
	" - status: 'installed', 'updated', or 'unchanged'
	" - force:  set on PlugInstall! or PlugUpdate!
	if a:info.status == 'installed' || a:info.force
		!./install.py --clangd-completer
	endif
endfunction

" Plugins
call plug#begin()
Plug 'jamessan/vim-gnupg'
Plug 'ycm-core/YouCompleteMe', { 'do': function('BuildYCM') }
call plug#end()

" Statusline always on
set laststatus=2

" Decrease time-out to remove pause when leaving insert mode (see
" https://github.com/vim-airline/vim-airline/wiki/FAQ).
set ttimeoutlen=10

" Settings for Markdown
autocmd FileType markdown setlocal textwidth=72
autocmd FileType markdown setlocal spell
autocmd FileType markdown setlocal complete+=kspell

" Debug YCM
let g:ycm_log_level='debug'
