# vim-config
Alain Mosnier's vim config

## Building and installing Vim from source

I believe I had to do the following to build and install a so-called
huge Vim, with every option I could think of, after cloning
github.com/vim/vim (commit e638acc, on Xubuntu 22.10):

    $ cd vim

    $ sudo apt install libncurses5-dev libgtk2.0-dev libatk1.0-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python2-dev \
    python3-dev ruby-dev lua5.2 liblua5.2-dev libperl-dev git \
    libtcl8.6

    $ sudo apt build-dep vim-gtk3

    $ ./configure --with-features=huge --enable-multibyte --enable-rubyinterp=yes \
    --enable-python3interp=yes --with-python3-config-dir=$(python3-config --configdir) \
    --enable-perlinterp=yes --enable-luainterp=yes --enable-gui=gtk3 --enable-cscope \
    --enable-tclinterp=yes --prefix=/usr/local

    $ make -j

    $ make test

The test actually ended up with:

    Executed:  5753 Tests
     Skipped:    46 Tests
      FAILED:     1 Tests


    Failures:
        From test_startup.vim:
        Found errors in Test_geometry():
        command line..script /home/alain/custom/repos/vim/src/testdir/runtest.vim[569]..function RunTheTest[52]..Test_geometry line 30: Expected '13' but got '9'

But Vim still seems to be working and reports:

    $ ./src/vim --version

    VIM - Vi IMproved 9.0 (2022 Jun 28, compiled Mar 15 2023 20:28:02)
    Included patches: 1-1404
    Compiled by alain@computer
    Huge version with GTK3 GUI.  Features included (+) or not (-):
    +acl               +file_in_path      +mouse_urxvt       -tag_any_white
    +arabic            +find_in_path      +mouse_xterm       +tcl
    +autocmd           +float             +multi_byte        +termguicolors
    +autochdir         +folding           +multi_lang        +terminal
    -autoservername    -footer            -mzscheme          +terminfo
    +balloon_eval      +fork()            +netbeans_intg     +termresponse
    +balloon_eval_term +gettext           +num64             +textobjects
    +browse            -hangul_input      +packages          +textprop
    ++builtin_terms    +iconv             +path_extra        +timers
    +byte_offset       +insert_expand     +perl              +title
    +channel           +ipv6              +persistent_undo   +toolbar
    +cindent           +job               +popupwin          +user_commands
    +clientserver      +jumplist          +postscript        +vartabs
    +clipboard         +keymap            +printer           +vertsplit
    +cmdline_compl     +lambda            +profile           +vim9script
    +cmdline_hist      +langmap           -python            +viminfo
    +cmdline_info      +libcall           +python3           +virtualedit
    +comments          +linebreak         +quickfix          +visual
    +conceal           +lispindent        +reltime           +visualextra
    +cryptv            +listcmds          +rightleft         +vreplace
    +cscope            +localmap          +ruby              +wildignore
    +cursorbind        +lua               +scrollbind        +wildmenu
    +cursorshape       +menu              +signs             +windows
    +dialog_con_gui    +mksession         +smartindent       +writebackup
    +diff              +modify_fname      +sodium            +X11
    +digraphs          +mouse             +sound             -xfontset
    +dnd               +mouseshape        +spell             +xim
    -ebcdic            +mouse_dec         +startuptime       +xpm
    +emacs_tags        -mouse_gpm         +statusline        +xsmp_interact
    +eval              -mouse_jsbterm     -sun_workshop      +xterm_clipboard
    +ex_extra          +mouse_netterm     +syntax            -xterm_save
    +extra_search      +mouse_sgr         +tag_binary
    -farsi             -mouse_sysmouse    -tag_old_static
       system vimrc file: "$VIM/vimrc"
         user vimrc file: "$HOME/.vimrc"
     2nd user vimrc file: "~/.vim/vimrc"
          user exrc file: "$HOME/.exrc"
      system gvimrc file: "$VIM/gvimrc"
        user gvimrc file: "$HOME/.gvimrc"
    2nd user gvimrc file: "~/.vim/gvimrc"
           defaults file: "$VIMRUNTIME/defaults.vim"
        system menu file: "$VIMRUNTIME/menu.vim"
      fall-back for $VIM: "/usr/local/share/vim"
    Compilation: gcc -c -I. -Iproto -DHAVE_CONFIG_H -DFEAT_GUI_GTK -pthread -I/usr/include/gtk-3.0 -I/usr/include/at-spi2-atk/2.0 -I/usr/include/at-spi-2.0 -I/usr/include/dbus-1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include -I/usr/include/gtk-3.0 -I/usr/include/gio-unix-2.0 -I/usr/include/cairo -I/usr/include/pango-1.0 -I/usr/include/harfbuzz -I/usr/include/pango-1.0 -I/usr/include/fribidi -I/usr/include/harfbuzz -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/pixman-1 -I/usr/include/uuid -I/usr/include/freetype2 -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/libpng16 -I/usr/include/x86_64-linux-gnu -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -g -O2 -D_REENTRANT -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1
    Linking: gcc -Wl,-E -L/usr/local/lib -Wl,--as-needed -o vim -lgtk-3 -lgdk-3 -lpangocairo-1.0 -lpango-1.0 -lharfbuzz -latk-1.0 -lcairo-gobject -lcairo -lgdk_pixbuf-2.0 -lgio-2.0 -lgobject-2.0 -lglib-2.0 -lSM -lICE -lXpm -lXt -lX11 -lXdmcp -lSM -lICE -lm -ltinfo -lselinux -lcanberra -lsodium -L/usr/lib -llua5.2 -Wl,-E -fstack-protector-strong -L/usr/local/lib -L/usr/lib/x86_64-linux-gnu/perl/5.34/CORE -lperl -ldl -lm -lpthread -lcrypt -L/usr/lib/python3.10/config-3.10-x86_64-linux-gnu -lpython3.10 -lcrypt -ldl -lm -lm -L/usr/lib/x86_64-linux-gnu -ltcl8.6 -ldl -lz -lpthread -lm -lruby-3.0 -lm -L/usr/lib

And then:

    $ sudo make install

To get an installation under /usr/local/bin.

Then the Ubuntu Vim can be removed:

    $ sudo apt remove vim vim-airline vim-common vim-gui-common vim-runtime \
    vim-scripts
