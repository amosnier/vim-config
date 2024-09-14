" An command to let clang-format format the buffer or a range of lines. Of
" course, that only makes sense if YCM is not already taking care of that.
" When I first created this, it was for GLSL.
command! -range ClangFormat <line1>,<line2>py3file /usr/share/vim/addons/syntax/clang-format.py
