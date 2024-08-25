" Because we use a modern plugin manager, we can be sure that the contents of
" the plugin directory will be executed before any external plugin, and hence
" we can have one file per configuration section in the plugin directory,
" which gives us structure clarity.

" Exception to the rule above, according to vim91/defaults.vim. This must be
" first, because it changes other options as a side effect. Avoid side effects
" when it was already reset.
if &compatible
  set nocompatible
endif
