function! Main()
   
    if &filetype !=? "cpp"
        return
    endif

    echo "C++�p�̐ݒ�𔽉f���܂��B"
    noremap <F4> :call CppCompile() <CR>

endfunction


function! CppCompile()

    if &filetype !=? "cpp"
        echo "�R���p�C���ł��܂���B"
        return
    endif

    call feedkeys("\<C-w>\<C-k>")
    call feedkeys("g++ -Wall -Wextra -o a.out " . expand("%:p") . "\<CR>")

endfunction


call Main()

