" Run ripgrep through fzf with a fixed string
function! FzfRgLiteralString(string, bang = 0)
	call fzf#vim#grep(
		\ 'rg --column --line-number --no-heading --color=always --fixed-strings -- ' . shellescape(a:string),
		\ 1, fzf#vim#with_preview(), a:bang)
endfunction

" Command for the previous function
command! -bang -nargs=* Rglit call FzfRgLiteralString(<q-args>, <bang>0)

" Visual version of the previous function, with the help of
" visual-start-search.
function! VisualFzfRgLiteralString()
	call VisualStarSearchSet('/', 'raw')
	call FzfRgLiteralString(@/)
endfunction
