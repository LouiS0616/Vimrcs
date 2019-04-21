"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Copied from http://d.hatena.ne.jp/osyo-manga/20120826/1345944705  "
" �R�����g��K�X�����A�f�o�b�O�p�̃R�[�h�����ߍ��񂾁B              "
"                                                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ref:  https://vim-jp.org/vimdoc-ja/eval.html
" 
"   - tabpagenr([{arg}])
"           ���݂̃^�u�ԍ����擾�B������$�̏ꍇ�A�^�u�̑������擾�B
"   - tabpagewinnr({tabarg} [, {arg}])  
"           �w��̃^�u�y�[�W�̃E�B���h�E�����擾�B�w�肪�����ꍇ�A�J�����g�^�u�𒲍��B
"   - gettabwinvar({tabnr}, {winnr}, {varname} [, {def}])
"           �w��̃^�u�̎w��̃E�B���h�E��varname�̒l���擾�B
"
"
" Ref:  https://vim-jp.org/vimdoc-ja/usr_41.html#41.8
"   ���X�g�⎫������̑���ȂǁB
"
" Ref:  https://ja.stackoverflow.com/questions/1685/vim�N�����ɃE�B���h�E�c�������E���Ƀt�@�C�����J�����@
"   �E�B���h�E����ȂǁB
"
" Ref:  https://vim-jp.org/vimdoc-ja/map.html#user-commands
"       https://vim-jp.org/vimdoc-ja/usr_40.html#40.2
"   �R�}���h�̐ݒ�ȂǁB
"
" Ref:  https://thinca.hatenablog.com/entry/20120619/1340061987
"   �ϐ��̃X�R�[�v�ɂ��āB
"
" Ref:  http://d.hatena.ne.jp/osyo-manga/20110717/1310932538
"   �ϒ������̎�舵���ɂ��āB


" ���������l���邢�͐�����ł��邩���肷��B
function! s:is_number(str)
    return (type(a:str) == type(0)) || (a:str =~ '^\d\+$')
endfunction


" �w��̃^�u�ɃE�B���h�E�������J���Ă��邩���ׁA[1..�^�u��] �̃��X�g��Ԃ��B
" �������ȗ����ꂽ�ꍇ�A�J�����g�^�u�𒲂ׂ�B
function! s:winnrlist(...)
    return a:0
\       ? range(1, tabpagewinnr(a:1, "$"))
\       : range(1, tabpagewinnr(tabpagenr(), "$"))
endfunction


" �ȉ��̂悤�Ȏ����I�u�W�F�N�g�̃��X�g�𐶐����ĕԋp����B
"   {
"       "winnr":    �E�B���h�E�̔ԍ�
"       "name":     �E�B���h�E��name���� (�擾�Ɏ��s�����ꍇ�A�󕶎����Ԃ�)
"   }
"
" �����Ώۂ̃^�u�͈����Ŏw��A�ȗ������ꍇ�̓J�����g�^�u�B
function! s:winlist(...)
    let tabnr = a:0 == 0 ? tabpagenr() : a:1
    return map(s:winnrlist(tabnr), '{
\       "winnr" : v:val,
\       "name"  : gettabwinvar(tabnr, v:val, "name")
\   }')
endfunction


" �W����winnr�̊g���ŁA
"       �����������ꍇ�y�ш����� "$" or "#" �ł������ꍇ�̋����͓����B
"
" �����ɐ�����Ɖ��߂ł��Ȃ��������^�����ꍇ�A
"       - �w���name���������E�B���h�E���������ꍇ: �E�B���h�E�ԍ���Ԃ��B
"       - otherwise: -1
"
" �����łȂ��ꍇ�A���������̂܂ܕԂ��B
function! s:winnr(...)
    return a:0 == 0    ? winnr()
\        : a:1 ==# "$" ? winnr("$")
\        : a:1 ==# "#" ? winnr("#")
\        : !s:is_number(a:1) ? (filter(s:winlist(), 'v:val.name ==# a:1') + [{'winnr' : '-1'}])[0].winnr
\        : a:1
endfunction


" �E�B���h�E��name������Ԃ��B
"       - ������������̏ꍇ:   �w��ԍ��̃E�B���h�E
"       - ������������̏ꍇ:   �����Ɠ���name���������E�B���h�E��name����
"                               (�啶���Ə���������ʂ���)
function! s:winname(...)
    return a:0 == 0    ? s:winname(winnr())
\        : a:1 ==# "$" ? s:winname(winnr("$"))
\        : a:1 ==# "#" ? s:winname(winnr("#"))
\        : !s:is_number(a:1) ? (filter(s:winlist(), 'v:val.name ==# a:1') + [{'name' : ''}])[0].name
\        : (filter(s:winlist(), 'v:val.winnr ==# a:1') + [{'name' : ''}])[0].name
endfunction


" �w���name���������E�B���h�E�Ɉړ�����B
" ���݂��Ȃ��ꍇ�Acmd�����s���A�����ɃE�B���h�E���[�J����name�ϐ���ݒ肷��B
function! s:split(cmd, name)
    let winnr = s:winnr(a:name)

    if winnr == -1
        silent execute a:cmd
        let w:name = a:name
    else
        silent execute winnr . "wincmd w"
    endif
endfunction


" �E�B���h�E�����w�肵�� split ����
" ���ɑ��݂���E�B���h�E���ł���΂����Ɉړ�����
command! -count=0 -nargs=1
\   Split call s:split("split", <q-args>) | if <count> | silent execute <count> | endif

" �s�ԍ����w�肵�� preview �E�B���h�E���J��
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
