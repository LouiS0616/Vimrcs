" Ref:  http://secret-garden.hatenablog.com/entry/2017/11/14/113127
" Ref:  https://vim-jp.org/vimdoc-ja/autocmd.html#BufEnter
" Ref:  https://stackoverflow.com/questions/1313171/vim-combining-autocmd


function! s:whenentered()
    echo "entered"
    if &buftype == "terminal" && &filetype == ""
        set filetype=terminal
    endif
endfunction


augroup TerminalSettings
    autocmd!
    autocmd BufEnter * call s:whenentered()
augroup END
