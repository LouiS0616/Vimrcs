echo "C�p�̐ݒ�𔽉f���܂��B"

"
function! CCompile()
    " Ref http://nanasi.jp/articles/code/io/file-path.html
    "     http://nanasi.jp/articles/code/compare/string.html

    if expand("%:e") !=? "c"
        echo "�R���p�C���ł��܂���B"
        return
    endif

    call feedkeys("\<C-w>\<C-k>\<CR>")
    call feedkeys("gcc -Wall -Wextra -o a.out " . expand("%:p") . "\<CR>")

endfunction

noremap <F4> :call CCompile() <CR>

