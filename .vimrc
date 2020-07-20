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

" =======
" Plugins
" =======
call plug#begin()
" GPG support
Plug 'jamessan/vim-gnupg'
" YouCompleteMe
Plug 'ycm-core/YouCompleteMe', { 'do': function('BuildYCM') }
" ASyncRun. Run commands asynchronously and get results in QuickFix list.
Plug 'skywind3000/asyncrun.vim'
" CMake support
Plug 'vhdirk/vim-cmake'
call plug#end()

" Default list of recipients for GPG
let g:GPGDefaultRecipients=[ 'alain@wanamoon.net' ]

" Statusline always on
set laststatus=2

" Disable key mapping timeout, since I will use <Leader> or otherwise unmapped
" keys. But ensure that ttiemout is not, since it is necessary for Esc.
set notimeout
set ttimeout

" Decrease time-out to remove pause when leaving insert mode (see
" https://github.com/vim-airline/vim-airline/wiki/FAQ).
set ttimeoutlen=10

" Settings for Markdown
autocmd FileType markdown setlocal textwidth=72
autocmd FileType markdown setlocal spell
autocmd FileType markdown setlocal complete+=kspell

" Settings for gitcommit
autocmd FileType gitcommit setlocal spell
autocmd FileType gitcommit setlocal complete+=kspell

" Autowrite before make (among others)
set autowrite

" Automatically go to QuickFix window if not empty
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" Debug YCM
let g:ycm_log_level='debug'

" Function that alternates the spelling language
function AlternateSpelllang()
	if &spelllang ==# 'en'
		setlocal spelllang=fr
	elseif &spelllang ==# 'fr'
		setlocal spelllang=sv
	else
		setlocal spelllang=en
	endif
endfunction

" Return a date and time string that can be used in a file name
function DateTimeStringNoSpace()
	return strftime("%Y-%m-%d_%H%M")
endfunction

" ==================
" Keyboard shortcuts
" ==================
" Alternate spellcheck language
autocmd FileType markdown nnoremap <buffer> <F5> :call AlternateSpelllang()<CR>
" Insert date and time with no space
cnoremap <expr> <Leader>dt DateTimeStringNoSpace()
" Insert markdown and GPG extension, open the file, and accept the default list of recipients
cnoremap <Leader>nmd .md.gpg<CR>:q<CR>
" Compile
nnoremap <F7> :make<CR>
" Previous and next quick fix
nnoremap <F3> :cprevious<CR>
nnoremap <F4> :cnext<CR>
