function! Main()
   
    if &filetype !=? "python"
        return
    endif

    echo "Python�p�̐ݒ�𔽉f���܂��B"
    setlocal fileencoding=utf-8

endfunction


call Main()
