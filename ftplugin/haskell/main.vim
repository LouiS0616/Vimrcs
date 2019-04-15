function! Main()
   
    if &filetype !=? "haskell"
        return
    endif

    echo "Haskell�p�̐ݒ�𔽉f���܂��B"
    noremap <F4> :call HaskellCompile() <CR>

endfunction


function! HaskellCompile()

    if &filetype !=? "haskell"
        echo "�R���p�C���ł��܂���B"
        return
    endif

    call feedkeys("\<C-w>\<C-k>")
    call feedkeys("stack ghc -- -o a.out " . expand("%:p") . "\<CR>")

endfunction


call Main()

