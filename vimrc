
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"  ���̂�F11�y��F12�������Ȃ��̂ŁA�L�[�o�C���f�B���O�͔����邱�ƁB
"
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"
" Load other source
set runtimepath+=$HOME/vimfiles
runtime! namedwindow.vim
runtime! machinedependent.vim


" 
" Edition
set noswapfile

set number
syntax on

set shiftwidth=4
set tabstop=4
set expandtab
set nowrap

set whichwrap=b,s,[,],<,>
set backspace=indent,eol,start

inoremap <C-o> <Esc>o


"
" Reload vimrc
noremap <F5>   :source  $MYVIMRC <CR>

if !has("vim_starting")
    echo "vimrc���ǂݍ��܂�܂����B"
endif


"
" When entered
function! s:whenentered()
    call AddNameToWindow("main")
    call Subwindow("terminal")
    JumpToWindow main
endfunction

augroup WhenEntered
    autocmd!
    autocmd VimEnter * call s:whenentered()
augroup END


"
" When save
augroup WhenSave
    autocmd!
    autocmd BufWrite * "%s/\s\+$//e"
augroup END


"
" Terminal
" TODO: terminal�ȊO�̃o�b�t�@���qa�����ۂ������悤�ɂ��邱�ƁB 
augroup WhenQuit
    autocmd!
    autocmd QuitPre *cmd.exe* q! 
augroup END


"
" Regex expression
noremap <Esc><Esc> :noh \| :echo "�������������܂����B" <CR>


"
" Compile
function! s:compile()
    let commands = {
\       'c'         : 'gcc -Wall -Wextra -o a.out "%s"' ,
\       'cpp'       : 'g++ -Wall -Wextra -o a.out "%s'  ,
\       'java'      : 'javac -Xlint:all "%s"'           ,
\       'haskell'   : 'stack ghc -- -o a.out "%s"'      ,
\   }

    if !has_key(commands, &filetype)
        echo '�R���p�C���ł��܂���B'
        return
    endif

    "
    let command = printf(commands[&filetype], expand('%:p'))
    
    if HasWindow('terminal')
        JumpToWindow terminal
        call feedkeys(command)
    else
        call Subwindow('terminal')
        call feedkeys(command)
    endif

endfunction

noremap <F4> :call <SID>compile()<CR>
