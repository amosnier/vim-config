" Return a date and time string that can be used in a file name
function! DateTimeStringNoSpace()
	return strftime("%Y-%m-%d_%H%M")
endfunction

" Function that alternates the spelling language.
" Note: So far, I seem to have applied the strategy of letting Vim download
" the original dictionaries for other languages than English to .vim/spell. At
" least that's what my .gitignore seems to be witnessing of. I suppose that
" should work on every new machine and after every reinstallation of my Vim
" configuration.
function! AlternateSpelllang()
	if &spelllang ==# 'en'
		setlocal spelllang=fr
	elseif &spelllang ==# 'fr'
		setlocal spelllang=sv
	else
		setlocal spelllang=en
	endif
endfunction
