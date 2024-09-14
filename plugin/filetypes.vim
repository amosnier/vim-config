" Using ftplugin for the settings below would arguably be cleaner, but because
" many of the settings are common to multiple file types, that would be fairly
" inefficient (a lot of copy/paste). This solution seems like a good
" compromise.
augroup filetypes
	" Clear group to provide support for multiple sourcing
	autocmd!
	autocmd FileType c,cpp,glsl,sh setlocal textwidth=120
	autocmd FileType markdown,gitcommit,c,cpp,glsl,vim,python,lisp,scheme,racket,sh,haskell setlocal spell
	autocmd FileType markdown,gitcommit setlocal complete+=kspell
	" Not (at the time of writing) totally understood trick that seems to
	" provide better handling of formatting lists in comments or markdown,
	" yet seems to break no other formatting (to be confirmed).
	autocmd FileType markdown,gitcommit,c,cpp setlocal formatoptions-=2 ai
	autocmd FileType markdown,cabal,prisma setlocal autoindent
	" No tabs in Lisp..., or in cmake, cabal, ...
	autocmd FileType r,lisp,scheme,racket,cmake,cabal,prisma setlocal expandtab
	autocmd FileType r,prisma setlocal tabstop=2 | setlocal shiftwidth=2
augroup END
