"
"
source namedwindow.vim


function! Subwindow()
    Split "terminal"    
    terminal ++curwin ++rows=16

    return "terminal"
endfunction

