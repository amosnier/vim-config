" Basically, let YCM format any file it can before saving, and when it can't,
" use other solutions. Of course, for the main scenario to work for a given
" extension, a corresponding LSP server with support for formatting needs to
" be configured for YCM. At some point, I have found such a solution for every
" file extension below, although I do not have then all installed at the
" time of writing.
augroup buf_write
	autocmd!
	autocmd BufWrite *.glsl %ClangFormat
	autocmd BufWrite *.{c,cpp,h,hpp,hs,lhs,js,jsx,ts,tsx,prima,rs} YcmCompleter Format
augroup END

