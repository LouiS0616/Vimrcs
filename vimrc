
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"  ���̂�F11�y��F12�������Ȃ��̂ŁA�L�[�o�C���f�B���O�͔����邱�ƁB
"
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"
set noswapfile

set number
syntax on

set shiftwidth=4
set tabstop=4
set expandtab
set nowrap

set whichwrap=b,s,[,],<,>
set backspace=indent,eol,start


" edit vimrc
" noremap <F4>   :edit    $MYVIMRC <CR>
" noremap <S-F4> :tabedit $MYVIMRC <CR>
noremap <F5>   :source  $MYVIMRC <CR>

if !has("vim_starting")
    echo "vimrc���ǂݍ��܂�܂����B"
endif


" �Q�l: https://qiita.com/mitsuru793/items/2d464f30bd091f5d0fef
" �ǂ����filetype�͎����I�ɓǂݍ��܂�Ă���悤���B:echo &filetype �Ŋm�F�ł���B
"
"augroup LangGroup
"    autocmd!
"    autocmd BufRead,BufNewFile *.py     setfiletype python
"    autocmd BufRead,BufNewFile *.java   setfiletype java
"    autocmd BufRead,BufNewFile *.cpp    setfiletype cpp
"    autocmd BufRead,BufNewFile *.c      setfiletype c
"    autocmd BufRead,BufNewFile *.hs     setfiletype haskell
"augroup END

augroup WhenEntered
    autocmd!
    autocmd VimEnter * source vimenter.vim
augroup END

augroup WhenWritten
    autocmd!
    autocmd BufWrite * "%s/\s\+$//e"
augroup END

source terminalsetting.vim


"
noremap <Esc><Esc> :noh \| :echo "�������������܂����B" <CR>
