"
"
source namedwindow.vim

if 1
endif


function! Subwindow()
    Split "terminal"    
    terminal ++curwin ++rows=16

    return "terminal"
endfunction

