" Set leader and local leader keys
let mapleader= 'å'

" FZF bindings
nnoremap <leader>t :GFiles --recurse-submodules<CR>
nnoremap <leader>åt :Locate<space>
nnoremap <leader>f :BLines<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>åb :buffers<CR>
nnoremap <leader>s :Rg<space>
nnoremap <leader>ås :Rglit<space>
nnoremap <leader>a *:call FzfRgLiteralString(expand("<cword>"))<CR>
vnoremap <leader>a :<C-u>call VisualFzfRgLiteralString()<CR>
