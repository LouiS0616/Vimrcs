"
"
source namedwindow.vim


function! Subwindow(name)
    execute "Split ".a:name
    terminal ++curwin ++rows=16
endfunction

