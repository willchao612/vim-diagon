" Maintainer: Will Chao <nerdzzh@gmail.com>
" Version: 1.0
" Last Change: 10/27/2021 06:10:38 PM +0800

if exists('g:loaded_diagon')
    finish
endif
let g:loaded_diagon = 1

" Generate diagrams using Diagon API
function! s:Diagon(start, stop, args) abort
    if !s:IsDiagonInstalled()
        echo 'Diagon not installed or not on $PATH!'
        return
    endif

    let args = split(a:args, ' ')
    let options = args[1:]

    let diagonTypes = s:GetDiagonTypes()
    let type = args[0]

    if index(diagonTypes, type) == -1
        echo 'Type not accepted by Diagon.'
        echo 'Please try again, like "Sequence".'
    else
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

        exe a:start.','.a:stop.'delete_'
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
    return ['Math', 'Sequence', 'Tree', 'Table', 'Grammar', 'Frame', 'GraphDAG', 'GraphPlanar', 'Flowchart']
endfunction

" Command :Diagon can accept a range (default is current line)
command! -range -nargs=1 -complete=customlist,s:CompleteDiagonCommand Diagon
            \ call s:Diagon(<line1>, <line2>, <q-args>)
