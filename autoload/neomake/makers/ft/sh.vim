" vim: ts=4 sw=4 et

function! neomake#makers#ft#sh#EnabledMakers()
    return ['sh', 'shellcheck']
endfunction

function! neomake#makers#ft#sh#shellcheck()
    return {
        \ 'args': ['-fgcc'],
        \ 'errorformat':
            \ '%f:%l:%c: %trror: %m,' .
            \ '%f:%l:%c: %tarning: %m,' .
            \ '%I%f:%l:%c: Note: %m',
        \ }
endfunction

function! neomake#makers#ft#sh#checkbashisms()
    return {
        \ 'args': ['-fx'],
        \ 'errorformat':
            \ '%-Gscript %f is already a bash script; skipping,' .
            \ '%Eerror: %f: %m\, opened in line %l,' .
            \ '%Eerror: %f: %m,' .
            \ '%Ecannot open script %f for reading: %m,' .
            \ '%Wscript %f %m,%C%.# lines,' .
            \ '%Wpossible bashism in %f line %l (%m):,%C%.%#,%Z.%#,' .
            \ '%-G%.%#'
        \ }
endfunction

function! neomake#makers#ft#sh#sh()
    let l:shebang = matchstr(getline(1), '^#!\s*\zs.*$')
    let l:sh = l:shebang == '' ? '/bin/sh' : l:shebang

    return {
        \ 'exe': l:sh,
        \ 'args': ['-n'],
        \ 'errorformat': '%f: line %l: %m'
        \}
endfunction
