" Set leader and local leader keys
let mapleader= 'å'

" Single key mappings that make sense with vim.unimpairred on a Swedish
" keyboard
nmap ö [
nmap ä ]

" Single key mappings that make sense on a Swedish keyboard
noremap § `
noremap ½ ~

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
