" Disable vi compatibility as early as possible
set nocompatible

" Enable loading of plugin files for specific file types, and if not yet
" enabled, filetype detection
filetype plugin on

" Set leader and local leader keys
let mapleader = 'å'
let maplocalleader = "\<Space>"

" Mappings to:
" - Edit Vim configuration file in a horizontal split, that works even if Vim
"   was started with "-u"
" - Source the same file
let s:this_script = fnameescape(expand('<sfile>'))
execute 'nnoremap <Leader>ve :split'  s:this_script . '<CR>'
execute 'nnoremap <Leader>vs :source'  s:this_script . '<CR>'
