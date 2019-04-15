set noswapfile

set number
syntax on

set shiftwidth=4
set tabstop=4
set expandtab

set whichwrap=b,s,[,],<,>
set backspace=indent,eol,start


" edit vimrc
noremap <F4>   :edit    $MYVIMRC <CR>
noremap <S-F4> :tabedit $MYVIMRC <CR>
noremap <F5>   :source  $MYVIMRC <CR>

if !has("vim_starting")
    echo "vimrcが読み込まれました。"
endif


" 参考: https://qiita.com/mitsuru793/items/2d464f30bd091f5d0fef 
augroup LangGroup
    autocmd!
    autocmd BufRead,BufNewFile *.py     setfiletype python
    autocmd BufRead,BufNewFile *.java   setfiletype java
    autocmd BufRead,BufNewFile *.c      setfiletype c
    autocmd BufRead,BufNewFile *.cpp    setfiletype cpp
    autocmd BufRead,BufNewFile *.hs     setfiletype haskell
augroup END


" run terminal
if has("vim_starting")
    terminal++rows=16
    call feedkeys("\<C-w>\<C-j>\<CR>")
endif


"
noremap <Esc><Esc> :noh \| :echo "検索を解除しました。" <CR>

