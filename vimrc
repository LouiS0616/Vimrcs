
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"  何故かF11及びF12が効かないので、キーバインディングは避けること。
"
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"
source namedwindow.vim
source machinedependent.vim

if !exists('*Subwindow') 
    throw "prepare function 'Subwindow'"
endif


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
    echo "vimrcが読み込まれました。"
endif


" 参考: https://qiita.com/mitsuru793/items/2d464f30bd091f5d0fef 
" どうやらfiletypeは自動的に読み込まれているようだ。:echo &filetype で確認できる。
"
"augroup LangGroup
"    autocmd!
"    autocmd BufRead,BufNewFile *.py     setfiletype python
"    autocmd BufRead,BufNewFile *.java   setfiletype java
"    autocmd BufRead,BufNewFile *.cpp    setfiletype cpp
"    autocmd BufRead,BufNewFile *.c      setfiletype c
"    autocmd BufRead,BufNewFile *.hs     setfiletype haskell
"augroup END


" run terminal
" どうやら、VimEnterイベントに結び付けないといけないようである。
if has("vim_starting")
    let w:name="main"
    call Subwindow()
    wincmd j
    "JumpToWindow "main"
endif


"
noremap <Esc><Esc> :noh \| :echo "検索を解除しました。" <CR>
