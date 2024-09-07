" Return a date and time string that can be used in a file name
function! DateTimeStringNoSpace()
	return strftime("%Y-%m-%d_%H%M")
endfunction
