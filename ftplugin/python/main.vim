function! Main()
   
    if &filetype !=? "python"
        return
    endif

    echo "Python用の設定を反映します。"
    setlocal fileencoding=utf-8

endfunction


call Main()
