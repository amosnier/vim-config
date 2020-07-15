"Zenbun theme
colors zenburn

" Plugins
call plug#begin()
Plug 'jamessan/vim-gnupg'
call plug#end()

" Powerline
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

" Statusline always on
set laststatus=2

