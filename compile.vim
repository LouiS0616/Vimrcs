source namedwindow.vim
source machinedependent.vim


function! Compile()
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
