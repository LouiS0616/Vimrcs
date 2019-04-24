
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"  何故かF11及びF12が効かないので、キーバインディングは避けること。
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
    echo "vimrcが読み込まれました。"
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
" TODO: terminal以外のバッファ上でqaした際も働くようにすること。 
augroup WhenQuit
    autocmd!
    autocmd QuitPre *cmd.exe* q! 
augroup END


"
" Regex expression
noremap <Esc><Esc> :noh \| :echo "検索を解除しました。" <CR>


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
        echo 'コンパイルできません。'
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
