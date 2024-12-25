let g:ycm_log_level = 'debug'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_always_populate_location_list = 1
let g:ycm_language_server = []

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
"   own standard GNU-arm installation.
let g:ycm_clangd_args = [
	\ '--query-driver=' . $HOME . '/.local/bin/arm-none-eabi-gcc',
	\ '--compile-commands-dir=.',
	\ ]

" YCM clangd related values, as recommended by the LLVM project
" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0

" Use installed clangd, not YCM-bundled clangd, in order to control its
" updating more easily (will only be used if found, apparently, which is
" good).
let g:ycm_clangd_binary_path = exepath("clangd")

let g:ycm_enable_semantic_highlighting=1
let g:ycm_enable_inlay_hints=1

" Python LSP, see https://github.com/python-lsp/python-lsp-server
let g:ycm_language_server += [
	\   {
	\     'name': 'pylsp',
	\     'cmdline': [ 'pylsp' ],
	\     'filetypes': [ 'python' ],
	\   },
	\ ]
