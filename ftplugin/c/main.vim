function! Main()
   
    if &filetype !=? "c"
        return
    endif

    echo "C用の設定を反映します。"
    noremap <F4> :call CCompile() <CR>

endfunction


function! CCompile()

    if &filetype !=? "c"
        echo "コンパイルできません。"
        return
    endif

    call feedkeys("\<C-w>\<C-k>")
    call feedkeys("gcc -Wall -Wextra -o a.out " . expand("%:p") . "\<CR>")

endfunction


call Main()
