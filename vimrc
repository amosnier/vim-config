" The comments and the commands below come verbatim from vim91/defaults.vim.
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
if &compatible
  set nocompatible
endif

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
