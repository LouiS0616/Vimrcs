function! Main()
   
    if &filetype !=? "cpp"
        return
    endif

    echo "C++用の設定を反映します。"
    noremap <F4> :call CppCompile() <CR>

endfunction


function! CppCompile()

    if &filetype !=? "cpp"
        echo "コンパイルできません。"
        return
    endif

    call feedkeys("\<C-w>\<C-k>")
    call feedkeys("g++ -Wall -Wextra -o a.out " . expand("%:p") . "\<CR>")

endfunction


call Main()

