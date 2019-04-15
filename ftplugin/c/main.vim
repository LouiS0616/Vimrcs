function! Main()
   
    if &filetype !=? "c"
        return
    endif

    echo "C�p�̐ݒ�𔽉f���܂��B"
    noremap <F4> :call CCompile() <CR>

endfunction


function! CCompile()

    if &filetype !=? "c"
        echo "�R���p�C���ł��܂���B"
        return
    endif

    call feedkeys("\<C-w>\<C-k>")
    call feedkeys("gcc -Wall -Wextra -o a.out " . expand("%:p") . "\<CR>")

endfunction


call Main()
