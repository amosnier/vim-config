" Set leader and local leader keys
let mapleader= 'å'

" Single key mappings that make sense with vim.unimpairred on a Swedish
" keyboard
nmap ö [
nmap ä ]

" Single key mappings that make sense on a Swedish keyboard
noremap § `
noremap ½ ~

" Expand current file directory, courtesy Practical Vim
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" FZF mappings
nnoremap <leader>t :GFiles --recurse-submodules<CR>
nnoremap <leader>åt :Locate<space>
nnoremap <leader>f :BLines<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>åb :buffers<CR>
nnoremap <leader>s :Rg<space>
nnoremap <leader>ås :Rglit<space>
nnoremap <leader>a *:call FzfRgLiteralString(expand("<cword>"))<CR>
vnoremap <leader>a :<C-u>call VisualFzfRgLiteralString()<CR>

" YouCompleteMe mappings.
nmap <leader>c <plug>(YCMHover)
nmap <leader>w <Plug>(YCMFindSymbolInWorkspace)
nmap <leader>d <Plug>(YCMFindSymbolInDocument)
nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap <leader>r :YcmCompleter GoToReferences<CR>
nnoremap <leader>z :YcmCompleter FixIt<CR>
noremap <leader>e :YcmCompleter Format<CR>
nnoremap <leader>h <Plug>(YCMToggleInlayHints)

" Make mapping
nnoremap <F7> :make<CR>

" Insert date and time with no space
cnoremap <expr> <leader>dt DateTimeStringNoSpace()

" Insert markdown and GPG extension, open the file, and accept the default
" list of recipients
cnoremap <leader>md .md.gpg<cr>:q<cr>
