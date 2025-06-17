" Tinymist claims to be integrated with typstyle, but YCM does not
" seem to be getting any reply to its "rangeFormatting" requests.
" Hence the following workaround, using a mark to avoid moving.
function! FormatTypst()
	normal mw
	%!typstyle
	normal 'w
endfunction

" Basically, let YCM format any file it can before saving, and when it can't,
" use other solutions. Of course, for the main scenario to work for a given
" extension, a corresponding LSP server with support for formatting needs to
" be configured for YCM. At some point, I have found such a solution for every
" file extension below, although I do not have them all installed at the
" time of writing.
augroup buf_write
	autocmd!
	autocmd BufWrite *.{glsl,vert,frag,tesc,tese,geom,comp} %ClangFormat
	autocmd BufWrite *.typ call FormatTypst()
	autocmd BufWrite *.{c,cpp,h,hpp,hs,lhs,js,jsx,ts,tsx,prima,py,rs} YcmCompleter Format
augroup END
