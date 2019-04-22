# Vimrcs

全くvimに慣れていない人間が書いたvimrcです。\
ですので、決して参考になるものではありません。

おかしな点があったらご指摘頂けると幸いです。


# Sample of "machinedepent.vim"
ターミナルウィンドウを上側に開く
```Vim
source namedwindow.vim


function! Subwindow(name)
    execute "Split ".a:name
    terminal ++curwin ++rows=16
endfunction
```

ターミナルウィンドウを右側に開く
```Vim
source namedwindow.vim


function! Subwindow(name)
    execute "VSplit ".a:name
    terminal ++curwin

    wincmd L
    vertical resize 119
endfunction
```
