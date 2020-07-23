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
" Better C/C++ syntax highlighting
Plug 'bfrg/vim-cpp-modern'
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

" Make airline compatible with C/C++ quite usual mixed indentation (also
" applies to the following type of comments for instance):
"
" 	/*
" 	 * Comment here
" 	 */
"
let g:airline#extensions#whitespace#mixed_indent_algo = 2

" Disable key mapping timeout, since I will use <leader> or otherwise unmapped
" keys. But ensure that ttiemout is not, since it is necessary for Esc.
set notimeout
set ttimeout

" Decrease time-out to remove pause when leaving insert mode (see
" https://github.com/vim-airline/vim-airline/wiki/FAQ).
set ttimeoutlen=10

" Settings for various file types
autocmd FileType markdown setlocal textwidth=72
autocmd FileType markdown,gitcommit,c,cpp,vim setlocal spell
autocmd FileType markdown,gitcommit setlocal complete+=kspell
autocmd FileType markdown setlocal autoindent

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
" Change map leader
:let mapleader = 'ö'
" Alternate spellcheck language
autocmd FileType markdown nnoremap <buffer> <F2> :call AlternateSpelllang()<CR>
" Insert date and time with no space
cnoremap <expr> <leader>dt DateTimeStringNoSpace()
" Insert markdown and GPG extension, open the file, and accept the default list of recipients
cnoremap <leader>nmd .md.gpg<CR>:q<CR>
" YouComplete me bindings
nmap <leader>d <plug>(YCMHover)
nnoremap <leader>g :YcmComplete GoTo<CR>
nnoremap <leader>r :YcmComplete GoToReferences<CR>
