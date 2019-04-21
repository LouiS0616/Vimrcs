"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Copied from http://d.hatena.ne.jp/osyo-manga/20120826/1345944705  "
" コメントを適宜加え、デバッグ用のコードも埋め込んだ。              "
"                                                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ref:  https://vim-jp.org/vimdoc-ja/eval.html
" 
"   - tabpagenr([{arg}])
"           現在のタブ番号を取得。引数が$の場合、タブの総数を取得。
"   - tabpagewinnr({tabarg} [, {arg}])  
"           指定のタブページのウィンドウ数を取得。指定が無い場合、カレントタブを調査。
"   - gettabwinvar({tabnr}, {winnr}, {varname} [, {def}])
"           指定のタブの指定のウィンドウのvarnameの値を取得。
"
"
" Ref:  https://vim-jp.org/vimdoc-ja/usr_41.html#41.8
"   リストや辞書周りの操作など。
"
" Ref:  https://ja.stackoverflow.com/questions/1685/vim起動時にウィンドウ縦分割→右側にファイルを開く方法
"   ウィンドウ操作など。
"
" Ref:  https://vim-jp.org/vimdoc-ja/map.html#user-commands
"       https://vim-jp.org/vimdoc-ja/usr_40.html#40.2
"   コマンドの設定など。
"
" Ref:  https://thinca.hatenablog.com/entry/20120619/1340061987
"   変数のスコープについて。
"
" Ref:  http://d.hatena.ne.jp/osyo-manga/20110717/1310932538
"   可変長引数の取り扱いについて。


" 引数が数値あるいは数字列であるか判定する。
function! s:is_number(str)
    return (type(a:str) == type(0)) || (a:str =~ '^\d\+$')
endfunction


" 指定のタブにウィンドウがいくつ開いているか調べ、[1..タブ数] のリストを返す。
" 引数が省略された場合、カレントタブを調べる。
function! s:winnrlist(...)
    return a:0
\       ? range(1, tabpagewinnr(a:1, "$"))
\       : range(1, tabpagewinnr(tabpagenr(), "$"))
endfunction


" 以下のような辞書オブジェクトのリストを生成して返却する。
"   {
"       "winnr":    ウィンドウの番号
"       "name":     ウィンドウのname属性 (取得に失敗した場合、空文字が返る)
"   }
"
" 調査対象のタブは引数で指定可、省略した場合はカレントタブ。
function! s:winlist(...)
    let tabnr = a:0 == 0 ? tabpagenr() : a:1
    return map(s:winnrlist(tabnr), '{
\       "winnr" : v:val,
\       "name"  : gettabwinvar(tabnr, v:val, "name")
\   }')
endfunction


" 標準のwinnrの拡張で、
"       引数が無い場合及び引数が "$" or "#" であった場合の挙動は同じ。
"
" 引数に数字列と解釈できない文字列を与えた場合、
"       - 指定のname属性を持つウィンドウを見つけた場合: ウィンドウ番号を返す。
"       - otherwise: -1
"
" そうでない場合、引数をそのまま返す。
function! s:winnr(...)
    return a:0 == 0    ? winnr()
\        : a:1 ==# "$" ? winnr("$")
\        : a:1 ==# "#" ? winnr("#")
\        : !s:is_number(a:1) ? (filter(s:winlist(), 'v:val.name ==# a:1') + [{'winnr' : '-1'}])[0].winnr
\        : a:1
endfunction


" ウィンドウのname属性を返す。
"       - 引数が数字列の場合:   指定番号のウィンドウ
"       - 引数が文字列の場合:   引数と同じname属性を持つウィンドウのname属性
"                               (大文字と小文字を区別する)
function! s:winname(...)
    return a:0 == 0    ? s:winname(winnr())
\        : a:1 ==# "$" ? s:winname(winnr("$"))
\        : a:1 ==# "#" ? s:winname(winnr("#"))
\        : !s:is_number(a:1) ? (filter(s:winlist(), 'v:val.name ==# a:1') + [{'name' : ''}])[0].name
\        : (filter(s:winlist(), 'v:val.winnr ==# a:1') + [{'name' : ''}])[0].name
endfunction


" 指定のname属性を持つウィンドウに移動する。
" 存在しない場合、cmdを実行し、同時にウィンドウローカルのname変数を設定する。
function! s:split(cmd, name)
    let winnr = s:winnr(a:name)

    if winnr == -1
        silent execute a:cmd
        let w:name = a:name
    else
        silent execute winnr . "wincmd w"
    endif
endfunction


" ウィンドウ名を指定して split する
" 既に存在するウィンドウ名であればそこに移動する
command! -count=0 -nargs=1
\   Split call s:split("split", <q-args>) | if <count> | silent execute <count> | endif

" 行番号を指定して preview ウィンドウを開く
" 123ss
" nnoremap <silent> ss :<C-u>execute v:count."Split preview"<CR>



"""""""""""""""""""""
" Written by myself "
"                   "
"""""""""""""""""""""
command! -nargs=1
\   VSplit call s:split("vsplit", <q-args>)

function! s:echowinnames()
    echo join(
\       map(
\           s:winlist(),
\           'v:val.name'
\       ), ', '
\   )
endfunction


function! AddNameToWindow(name)
    let w:name = a:name
endfunction


command! -nargs=1
\   JumpToWindow call s:split("throw 'no such window.'", <q-args>)


"
nnoremap <silent> lsbuf :ls                       <CR>
nnoremap <silent> lswin :call <SID>echowinnames() <CR>
