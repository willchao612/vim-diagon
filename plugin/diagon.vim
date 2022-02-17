" Maintainer: Will Chao <nerdzzh@gmail.com>
" Version: 1.0
" Last Modified: Thursday, 17 February 2022

if exists('g:loaded_diagon')
    finish
endif
let g:loaded_diagon = 1

" Generate diagrams using Diagon API
function! s:Diagon(start, stop, args) abort
    if !s:IsDiagonInstalled()
        echohl Error
        echomsg 'Diagon not installed or not on PATH!'
        echohl None
        return
    endif

    let args = split(a:args, ' ')
    let options = args[1:]

    let diagonTypes = s:GetDiagonTypes()
    let type = args[0]

    if index(diagonTypes, type) == -1
        echohl Error
        echomsg 'Type not accepted by Diagon.'
        echomsg 'Please try again, like "Sequence".'
        echohl None
        return
    endif

    let lines = []
    for lnum in range(a:start, a:stop)
        let line = getline(lnum)
        call add(lines, line)
    endfor
    let inText = join(lines, "\n")

    let shellCommand = 'echo ' . shellescape(inText) . ' | diagon ' . type . ' '
    for option in options
        let shellCommand .= shellescape(option) . ' '
    endfor
    let outText = split(system(shellCommand), '\n')

    if get(g:, 'diagon_use_echo', 0) == 1
        echo join(outText, "\n")
    else
        exe a:start . ',' . a:stop . 'delete_'
        call cursor(a:start - 1, 1)
        for line in outText
            silent put =line
        endfor
    endif
endfunction

" Return a boolean denoting if has Diagon on $PATH
function! s:IsDiagonInstalled()
    return executable("diagon")
endfunction

" Return a list of accepted types of diagrams.
function! s:GetDiagonTypes()
    return ['Math', 'Sequence', 'Tree', 'Table', 'Grammar', 'Frame', 'GraphDAG', 'GraphPlanar', 'Flowchart']
endfunction

" Generate tab completion list for :Diagon
" Return a list of accepted types of diagrams.
function! s:CompleteDiagonCommand(argstart, cmdline, cursorpos)
    return filter(s:GetDiagonTypes(), 'v:val =~ "^' . a:argstart . '"')
endfunction

" Command :Diagon can accept a range (default is current line)
command! -range -nargs=1 -complete=customlist,s:CompleteDiagonCommand Diagon
            \ call s:Diagon(<line1>, <line2>, <q-args>)
