" Ref:  http://secret-garden.hatenablog.com/entry/2017/11/14/113127
" Ref:  https://vim-jp.org/vimdoc-ja/autocmd.html#BufEnter
" 

function! s:whenentered()
    if &buftype == "terminal" && &filetype == ""
        set filetype=terminal
    endif
endfunction


augroup TerminalSettings
    autocmd!
    autocmd BufEnter * call s:whenentered()
augroup END
