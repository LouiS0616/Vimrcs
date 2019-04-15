echo "C用の設定を反映します。"

"
function! CCompile()
    " Ref http://nanasi.jp/articles/code/io/file-path.html
    "     http://nanasi.jp/articles/code/compare/string.html

    if expand("%:e") !=? "c"
        echo "コンパイルできません。"
        return
    endif

    call feedkeys("\<C-w>\<C-k>\<CR>")
    call feedkeys("gcc -Wall -Wextra -o a.out " . expand("%:p") . "\<CR>")

endfunction

noremap <F4> :call CCompile() <CR>

