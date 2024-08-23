" Quite many of the following settings come from vim91/defaults.vim.
" "sensible.vim" quite often agrees with them.

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

set history=1000	" keep 1000 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set wildmenu		" display completion matches in a status line

set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key

" Show @@@ in the last line if it is truncated.
set display=truncate

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Do incremental searching when it's possible to timeout.
if has('reltime')
	set incsearch
endif

if &t_Co > 2 || has("gui_running")
	" Switch on highlighting the last used search pattern.
	set hlsearch
	" Mapping from Practical Vim, to clear current search highlighting, as
	" part of the existing clearing and screen redrawing command.
	" "sensible.vim" has a more advanced version that involves diff, but
	" we keep it simple.
	nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
endif

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Same as the previous one for CTRL-W, which deletes the word before the
" cursor.
inoremap <C-W> <C-G>u<C-W>

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
" Revert with ":filetype off".
filetype plugin indent on

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid, when inside an event handler
" (happens when dropping a file on gvim), for a commit or rebase message
" (likely a different one than last time), and when using xxd(1) to filter
" and edit binary files (it transforms input files back and forth, causing
" them to have dual nature, so to speak)
augroup to_last_know_cursor_position
	autocmd!
	autocmd BufReadPost *
		\ let line = line("'\"")
		\ | if line >= 1 && line <= line("$") && &filetype !~# 'commit'
		\      && index(['xxd', 'gitrebase'], &filetype) == -1
		\ |   execute "normal! g`\""
		\ | endif
augroup END

" Switch syntax highlighting on.
if has('syntax')
	" Compared with "on", "enable" is supposed to "keep most of your
	" current color settings".
	syntax enable
	" I like highlighting strings inside C comments.
	" Revert with ":unlet c_comment_strings".
	let c_comment_strings=1
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif

if has('langmap') && exists('+langremap')
	" Prevent that the langmap option applies to characters that result from a
	" mapping.  If set (default), this may break plugins (but it's backward
	" compatible).
	set nolangremap
endif

set backup		" keep a backup file (restore to previous version)
if has('persistent_undo')
	set undofile	" keep an undo file (undo changes after closing)
endif

" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
	packadd! matchit
endif

" Allow local .vimrc
set exrc

" Enable mouse support
set mouse=a

" Although that is not very clear when reading the help, the following seems
" to make copy/paste a lot easier between VIM and the clipboard. More
" specifically, doing it as usual in both worlds just seems to work.
set clipboard=unnamedplus

" Hide unloaded buffers, do not abandon them. This is really important when
" indexing large source code files, in order to not reindex every time the
" file is re-entered.
set hidden

" When joining lines, do not add an extra-space between sentences. For the
" record, such an extra-space is sometimes used to improve readability with
" monospaced fonts, but I am myself not used to that.
set nojoinspaces

" Better tab completion. Like Bash, but even a little better.
set wildmode=longest,list,full

" Expand current file directory, courtesy Practical Vim
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
