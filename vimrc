" -------------------------------------------
" Begin: code from the official Vimrc example
" -------------------------------------------

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
	finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
	set nobackup		" do not keep a backup file, use versions instead
else
	set backup		" keep a backup file (restore to previous version)
	if has('persistent_undo')
		set undofile	" keep an undo file (undo changes after closing)
	endif
endif

if &t_Co > 2 || has("gui_running")
	" Switch on highlighting the last used search pattern.
	set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
	au!

	" For all text files set 'textwidth' to 78 characters.
	autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
	packadd! matchit
endif

" -------------------------------------------
" End: code from the official Vimrc example
" -------------------------------------------

" Zenburn color scheme
colors zenburn

" Allow local .vimrc
set exrc

" Enable mouse support
set mouse=a

" When joining lines, do not add an extra-space between sentences. For the
" record, such an extra-space is sometimes used to improve readability with
" monospaced fonts, but I am myself not used to that.
set nojoinspaces

" Disable key mapping timeout, since I will use <leader> or otherwise unmapped
" keys. But ensure that ttimeout is enabled, since it is necessary for the escape
" key.
set notimeout
set ttimeout

" Decrease time-out to remove pause when leaving insert mode (see
" https://github.com/vim-airline/vim-airline/wiki/FAQ).
set ttimeoutlen=10

" Enable incremental search
set incsearch

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
let g:ycm_language_server = []
let g:ycm_language_server += [
	\   {
	\     'name': 'haskell-language-server',
	\     'cmdline': [ 'haskell-language-server-wrapper', '--lsp' ],
	\     'filetypes': [ 'haskell', 'lhaskell' ],
	\     'project_root_files': [ 'stack.yaml', 'cabal.project', 'package.yaml', 'hie.yaml' ],
	\   },
	\ ]

" YCM-clangd arguments:
"
" - Point to the current directory for the compilation database, since clangd
"   seems to be looking for a compilation database for every single visited
"   file. For system headers, it will typically not find any.  While generally
"   speaking, system headers are fine, for some libraries, this is not the
"   case. Freetype, for instance, assumes a system include path which
"   typically is not present in the gcc installed by the system (on Ubuntu
"   22.04, for instance). That has to be compensated by a gcc "-I" directive
"   which, if not visible to clangd, leads to it complaining in Freetype
"   header files that include other Freetype header files. Oh well...
"
" - When it comes to compiler white-listing, the following will help for my
"   own standard GNU-arm installation. I no longer have it on by default, for
"   now.
"	\ '--query-driver=' . $HOME . '/custom/bin/gcc-arm-none-eabi*/bin/arm-none-eabi-*',
let g:ycm_clangd_args = [
	\ '--compile-commands-dir=.',
	\ ]

" YCM clangd related values, as recommended by the LLVM project
" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd, in order control its updating
" more easily.
let g:ycm_clangd_binary_path = exepath("clangd")
let g:ycm_enable_semantic_highlighting=1
let g:ycm_enable_inlay_hints=1

" Flake8 variables
" I want my own mapping instead of the standard one.
let g:no_flake8_maps = 1

" clang-format alias
command! -range ClangFormat <line1>,<line2>py3file /usr/share/vim/addons/syntax/clang-format.py

" =======
" Plugins
" =======

call plug#begin()
" GPG support
Plug 'jamessan/vim-gnupg'
" Support for autopep8
Plug 'tell-k/vim-autopep8'
" Support for Python Linting
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
Plug 'benknoble/vim-racket'
" Vim visual search (suggested in Practical Vim)
Plug 'bronson/vim-visual-star-search'
" Haskell indenting
Plug 'alx741/vim-hindent'
" Yet another Vim library, for KeepView
Plug 'vim-scripts/anwolib'
" Doxygen support
Plug 'vim-scripts/DoxygenToolkit.vim'
" Vim airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" Default list of recipients for GPG
let g:GPGDefaultRecipients=[ 'alain@wanamoon.net' ]

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
let g:airline_powerline_fonts = 1

" Autopep8 settings
let g:autopep8_disable_show_diff=1
let g:autopep8_aggressive=2
let g:autopep8_on_save = 1

augroup filetypes
	" Clear group to provide support for multiple sourcing
	autocmd!
	" Auto-PEP8 formatting filter. Requires `pip install autopep8`.
	" Doubly-aggressive (break lines and stuff). Ended with hyphen to
	" indicate standard in as a source.
	autocmd FileType python setlocal formatprg=autopep8\ -aa\ -
	autocmd FileType python map <buffer> <F3> :call flake8#Flake8()<CR>
	autocmd FileType html setlocal textwidth=106
	" Use `clang-format` for C family indentation
	autocmd FileType c,cpp,glsl setlocal equalprg=clang-format
	autocmd FileType c,cpp,glsl,sh setlocal textwidth=120
	autocmd FileType c,cpp,glsl set comments^=:///
	autocmd FileType markdown setlocal textwidth=72
	autocmd FileType markdown,gitcommit,c,cpp,glsl,vim,python,lisp,scheme,racket,sh setlocal spell
	autocmd FileType markdown,gitcommit setlocal complete+=kspell
	autocmd FileType markdown setlocal autoindent
	" Alternate spellcheck language
	autocmd FileType markdown nnoremap <buffer> <F2> :call AlternateSpelllang()<cr>
	" No tabs in Lisp..., or in cmake
	autocmd FileType lisp,scheme,racket,cmake setlocal expandtab
	" Pair parentheses in Lisp
	autocmd FileType lisp,scheme,racket inoremap ( ()<Esc>ha
	autocmd FileType scheme,racket inoremap [ []<Esc>ha
	" vim-racket automatically uses `raco fmt` as the format program, but
	" it does not format comments, and the standard Vim formatter does
	" that well enough.
	autocmd FileType racket setlocal formatprg=
	autocmd FileType racket setlocal equalprg=raco\ fmt
augroup END

" Auto-commands that trigger when writing files
augroup writing
	autocmd!
	" Same kind of auto-format as for Python for C/C++, but with clang-format
	autocmd BufWritePre *.c,*.cpp,*.glsl,*.h,*.hpp %ClangFormat
	" Automatically format Lisp family languages on save, with our
	" workaround.
	autocmd BufWritePre *.rkt KeepView %!raco fmt
	autocmd BufWritePost *.py call flake8#Flake8()
augroup END

" Automatic write before make (among others)
set autowrite

" Function that alternates the spelling language.
" Note: So far, I seem to have applied the strategy of letting Vim download
" the original dictionaries for other languages than English to .vim/spell. At
" least that's what my .gitignore seems to be witnessing of. I suppose that
" should work on every new machine and after every reinstallation of my Vim
" configuration.
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
cnoremap <leader>md .md.gpg<cr>:q<cr>

" YouCompleteMe bindings
nmap <leader>c <plug>(YCMHover)
nmap <leader>w <Plug>(YCMFindSymbolInWorkspace)
nmap <leader>d <Plug>(YCMFindSymbolInDocument)
nnoremap <leader>g :YcmCompleter GoTo<cr>
nnoremap <leader>r :YcmCompleter GoToReferences<cr>
nnoremap <silent> <localleader>h <Plug>(YCMToggleInlayHints)

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
