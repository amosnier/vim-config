"Zenbun theme
colors zenburn

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

" Settings for Markdown
autocmd FileType markdown setlocal textwidth=72
autocmd FileType markdown setlocal spell
autocmd FileType markdown setlocal complete+=kspell
