function! Main()
   
    if &filetype !=? "java"
        return
    endif

    echo "Java�p�̐ݒ�𔽉f���܂��B"
    noremap <F4> :call JavaCompile() <CR>

endfunction


function! JavaCompile()

    if &filetype !=? "java"
        echo "�R���p�C���ł��܂���B"
        return
    endif

    call feedkeys("\<C-w>\<C-k>")
    call feedkeys("javac " . expand("%:p") . "\<CR>")

endfunction


call Main()

