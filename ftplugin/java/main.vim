function! Main()
   
    if &filetype !=? "java"
        return
    endif

    echo "Java用の設定を反映します。"
    noremap <F4> :call JavaCompile() <CR>

endfunction


function! JavaCompile()

    if &filetype !=? "java"
        echo "コンパイルできません。"
        return
    endif

    call feedkeys("\<C-w>\<C-k>")
    call feedkeys("javac " . expand("%:p") . "\<CR>")

endfunction


call Main()

