function! Main()
   
    if &filetype !=? "haskell"
        return
    endif

    echo "Haskell用の設定を反映します。"
    noremap <F4> :call HaskellCompile() <CR>

endfunction


function! HaskellCompile()

    if &filetype !=? "haskell"
        echo "コンパイルできません。"
        return
    endif

    call feedkeys("\<C-w>\<C-k>")
    call feedkeys("stack ghc -- -o a.out " . expand("%:p") . "\<CR>")

endfunction


call Main()

