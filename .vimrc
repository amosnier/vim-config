" Zenburn color scheme
colors zenburn

" Allow local .vimrc
set exrc

" Enable mouse support
set mouse=a

" Disable key mapping timeout, since I will use <leader> or otherwise unmapped
" keys. But ensure that ttimeout is not, since it is necessary for the escape
" key.
set notimeout
set ttimeout

" Enable search highlighting and incremental search
set hlsearch
set incsearch

" Decrease time-out to remove pause when leaving insert mode (see
" https://github.com/vim-airline/vim-airline/wiki/FAQ).
set ttimeoutlen=10

" Better tab completion. Like Bash, but even a little better.
set wildmode=longest,list,full

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

" YCM variables
let g:ycm_log_level='debug'
let g:ycm_autoclose_preview_window_after_completion = 1

" White list my default ARM cross-compiling compiler for clangd
let g:ycm_clangd_args = [
	\ '--query-driver=' . $HOME . '/custom/bin/gcc-arm-none-eabi*/bin/arm-none-eabi-*',
	\ ]

" YCM clangd related values, as recommended by the LLVM project
" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")

" vim-cmake variables
let g:cmake_export_compile_commands=1

" Auto-commands for various file types, before plugin before we do some plugin
" remapping that they must be able to detect.
augroup filetypes
	" Clear group to provide support for multiple sourcing
	autocmd!
	autocmd FileType markdown setlocal textwidth=72
	autocmd FileType html setlocal textwidth=106
	autocmd FileType c,cpp,sh setlocal textwidth=120
	autocmd FileType c,cpp set comments^=:///
	autocmd FileType c,cpp noremap <C-K> :py3file /usr/share/vim/addons/syntax/clang-format.py<cr>
	autocmd FileType markdown,gitcommit,c,cpp,vim,python setlocal spell
	autocmd FileType markdown,gitcommit setlocal complete+=kspell
	autocmd FileType markdown setlocal autoindent
	" Alternate spellcheck language
	autocmd FileType markdown nnoremap <buffer> <F2> :call AlternateSpelllang()<cr>

	" Auto-PEP8 formatting filter. Requires `pip install autopep8`.
	" Doubly-aggressive (break lines and stuff). Ended with hyphen to
	" indicate standard in as a source.
	autocmd FileType python setlocal formatprg=autopep8\ -aa\ --max-line-length\ 120\ -
	autocmd FileType python map <buffer> <F3> :call flake8#Flake8()<CR>
augroup END

" =======
" Plugins
" =======

call plug#begin()
" GPG support
Plug 'jamessan/vim-gnupg'
" Better C/C++ syntax highlighting
Plug 'bfrg/vim-cpp-modern'
" Enforce PEP8 auto-indentation
Plug 'Vimjas/vim-python-pep8-indent'
" Support for Python Linting (F7 by default)
Plug 'nvie/vim-flake8'
" YouCompleteMe
Plug 'ycm-core/YouCompleteMe', { 'do': function('BuildYCM') }
" ASyncRun. Run commands asynchronously and get results in QuickFix list.
Plug 'skywind3000/asyncrun.vim'
" CMake support
Plug 'vhdirk/vim-cmake'
" FZF support. Let Vim Plug do the whole FZF work, including for the FZF that
" we use outside of Vim.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" GLSL support
Plug 'tikhomirov/vim-glsl'
" Support for .gitignore
Plug 'gisphm/vim-gitignore'
call plug#end()


" Default list of recipients for GPG
let g:GPGDefaultRecipients=[ 'alain@wanamoon.net' ]

" Status line always on
set laststatus=2

" Make airline compatible with C/C++ quite usual mixed indentation (also
" applies to the following type of comments for instance):
"
" 	/*
" 	 * Comment here
" 	 */
"
" Note: handling mixed-indent-file is very difficult when using tabs for
" indentation and spaces for alignment (at indentation level zero, there will
" be leading spaces without any tabs before them). This is better taken care
" of by a global clang-format anyway.
let g:airline#extensions#whitespace#mixed_indent_algo = 2
let g:airline#extensions#whitespace#skip_indent_check_ft = {
	\ 'cpp': ['mixed-indent-file'],
	\ 'c': ['mixed-indent-file']
	\ }

" Auto-commands that trigger when writing files
augroup writing
	autocmd!
	autocmd BufWritePost *.py call flake8#Flake8()
augroup END

" Automatic write before make (among others)
set autowrite

" Function that alternates the spelling language
function! AlternateSpelllang()
	if &spelllang ==# 'en'
		setlocal spelllang=fr
	elseif &spelllang ==# 'fr'
		setlocal spelllang=sv
	else
		setlocal spelllang=en
	endif
endfunction

" Return a date and time string that can be used in a file name
function! DateTimeStringNoSpace()
	return strftime("%Y-%m-%d_%H%M")
endfunction


" ==================
" Keyboard shortcuts
" ==================

" Make some keys that are often used in normal mode more easily accessible
map å \
map ö [
map ä ]
map <C-h> <C-[>
map <C-l> <C-]>
map ¤ ^
cmap ¤ ^

" Insert date and time with no space
cnoremap <expr> <leader>dt DateTimeStringNoSpace()

" Insert markdown and GPG extension, open the file, and accept the default list of recipients
cnoremap <leader>nmd .md.gpg<cr>:q<cr>

" YouCompleteMe bindings
nmap <leader>c <plug>(YCMHover)
nnoremap <leader>g :YcmCompleter GoTo<cr>
nnoremap <leader>r :YcmCompleter GoToReferences<cr>
nnoremap <leader>s :<C-u>execute 'YcmCompleter GoToSymbol '.input('Symbol: ')<cr>

" Make command and key bindings
set makeprg=make\ -C\ build
nnoremap <F7> :make<cr>
nnoremap <F8> :CMake<cr>

" Quickfix list bindings
nnoremap <leader>n :cnext<cr>
nnoremap <leader>p :cprevious<cr>

" FZF bindings
nnoremap <leader>t :GFiles<cr>
nnoremap <leader>f :BLines<cr>
