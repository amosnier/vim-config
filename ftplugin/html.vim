" We can use HTML in Markdown but we do not want these settings to apply to
" Markdown files.
if &ft=="markdown"
	finish
endif

setlocal textwidth=106
