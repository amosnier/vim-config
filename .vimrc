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

" Expand current file directory, courtesy Practical Vim
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

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

" Define alias for clang-format, since we now use it twice
command! -range ClangFormat <line1>,<line2>py3file /usr/share/vim/addons/syntax/clang-format.py

" Auto-commands for various file types, before we do some plugin remapping
" that they must be able to detect.
augroup filetypes_before_plugins
	" Auto-PEP8 formatting filter. Requires `pip install autopep8`.
	" Doubly-aggressive (break lines and stuff). Ended with hyphen to
	" indicate standard in as a source.
	autocmd FileType python setlocal formatprg=autopep8\ -aa\ -
	autocmd FileType python map <buffer> <F3> :call flake8#Flake8()<CR>
	" Racket scmindent.rkt for Scheme family indenting. Requires in
	" scmindent on the path (typically under /usr/local/bin, which
	" requires Racket as an interpreter.
	autocmd FileType lisp,scheme,racket setlocal equalprg=scmindent.rkt
augroup END

" =======
" Plugins
" =======

" Load some plugins distributed with Vim
runtime macros/matchit.vim

call plug#begin()
" GPG support
Plug 'jamessan/vim-gnupg'
" Better C/C++ syntax highlighting
Plug 'bfrg/vim-cpp-modern'
" Support for autopep8
Plug 'tell-k/vim-autopep8'
" Support for Python Linting (F7 by default)
Plug 'nvie/vim-flake8'
" YouCompleteMe
Plug 'ycm-core/YouCompleteMe', { 'do': function('BuildYCM') }
" ASyncRun. Run commands asynchronously and get results in QuickFix list.
Plug 'skywind3000/asyncrun.vim'
" FZF support. Let Vim Plug do the whole FZF work, including for the FZF that
" we use outside of Vim.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" GLSL support
Plug 'tikhomirov/vim-glsl'
" Support for .gitignore
Plug 'gisphm/vim-gitignore'
" Support for Jupyter notebooks
Plug 'goerz/jupytext.vim'
" Pope's plugins
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-abolish'
" Racket support
Plug 'wlangstroth/vim-racket'
" Vim visual search (suggested in Practical Vim)
Plug 'bronson/vim-visual-star-search'
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
	\ 'glsl': ['mixed-indent-file'],
	\ 'cpp': ['mixed-indent-file'],
	\ 'c': ['mixed-indent-file']
	\ }

" Autopep8 settings
let g:autopep8_disable_show_diff=1
let g:autopep8_aggressive=2
let g:autopep8_on_save = 1

augroup filetypes
	" Clear group to provide support for multiple sourcing
	autocmd!
	autocmd FileType markdown setlocal textwidth=72
	autocmd FileType html setlocal textwidth=106
	autocmd FileType c,cpp,glsl,sh setlocal textwidth=120
	autocmd FileType c,cpp,glsl set comments^=:///
	autocmd FileType c,cpp,glsl noremap <C-K> :ClangFormat<cr>
	autocmd FileType markdown,gitcommit,c,cpp,glsl,vim,python setlocal spell
	autocmd FileType markdown,gitcommit setlocal complete+=kspell
	autocmd FileType markdown setlocal autoindent
	" Alternate spellcheck language
	autocmd FileType markdown nnoremap <buffer> <F2> :call AlternateSpelllang()<cr>
	" No tabs in Lisp...
	autocmd FileType lisp,scheme,racket setlocal expandtab
augroup END

" Auto-commands that trigger when writing files
augroup writing
	autocmd!
	" Same kind of auto-format as for Python for C/C++, but with clang-format
	autocmd BufWritePre *.c,*.cpp,*.glsl,*.h,*.hpp :%ClangFormat
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

" Run ripgrep through fzf with a fixed string
function! FzfRgLiteralString(string, bang = 0)
	call fzf#vim#grep(
		\ 'rg --column --line-number --no-heading --color=always --fixed-strings -- ' . shellescape(a:string),
		\ 1, fzf#vim#with_preview(), a:bang)
endfunction

" Command for the previous function
command! -bang -nargs=* Rglit call FzfRgLiteralString(<q-args>, <bang>0)

" ==================
" Keyboard shortcuts
" ==================

" Make some keys that are often used in normal mode more easily accessible
map å \
map ö [
map ä ]
map Ö <c-[>
map Ä <c-]>
map ¤ ^
map § `
map g¤ g^
cmap ¤ ^

" Mappings for jumping around
map § `
map '' ``
map '. `.
map '¤ `^
map 'ö `[
map 'ä `]
map '< `<
map '> `>

" Insert date and time with no space
cnoremap <expr> <leader>dt DateTimeStringNoSpace()

" Insert markdown and GPG extension, open the file, and accept the default
" list of recipients
cnoremap <leader>nmd .md.gpg<cr>:q<cr>

" YouCompleteMe bindings
nmap <leader>c <plug>(YCMHover)
nnoremap <leader>g :YcmCompleter GoTo<cr>
nnoremap <leader>r :YcmCompleter GoToReferences<cr>
nnoremap <leader>s :<C-u>execute 'YcmCompleter GoToSymbol '.input('Symbol: ')<cr>

" Bind f5 to pastetoggle, helps with pasting from the clipboard
set pastetoggle=<f5>

" Make command and key bindings
nnoremap <f7> :make<cr>

" FZF bindings
nnoremap <leader>t :GFiles<cr>
nnoremap <leader>f :BLines<cr>

" Mappings partly related to visual star search, customized for ripgrep
" through FZF. Run the equivalent of Rg, with an automatically fetched literal
" string. In normal mode, the string is the current search pattern. In visual
" mode, we take the help of visual star search to get the current selection as
" the literal string.
nnoremap <leader>* :call FzfRgLiteralString(expand("<cword>"))<cr>
vnoremap <leader>* :<C-u>call VisualStarSearchSet('/', 'raw')<cr>:call FzfRgLiteralString(@/)<cr>
