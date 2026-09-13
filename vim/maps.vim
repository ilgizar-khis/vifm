
" Start shell in current directory
nnoremap s :shell<cr>

" Display sorting dialog
nnoremap S :sort<cr>

" Toggle visibility of preview window
nnoremap w :view<cr>
vnoremap w :view<cr>gv

if $DISPLAY != '' && executable('gvim')
    " Open file in existing instance of gvim
    nnoremap o :!gvim --remote-tab-silent %f<cr>
    " Open file in new instance of gvim
    nnoremap O :!gvim %f<cr>
endif

" Open file in the background using its default program
nnoremap gb :file &<cr>l

" Interaction with system clipboard
if has('win')
    " Yank current directory path to Windows clipboard with forward slashes
    nnoremap yp :!echo %"d:gs!\!/! %i | clip<cr>
    " Yank path to current file to Windows clipboard with forward slashes
    nnoremap yf :!echo %"c:p:gs!\!/! %i | clip<cr>
elseif $WAYLAND_DISPLAY != ''
    if executable('wl-copy')
        " Yank current directory path into primary and selection clipboards
        nnoremap yd :!echo -n %d | wl-copy %i &&
                    \ echo -n %d | wl-copy -p %i<cr>
        " Yank current file path into into primary and selection clipboards
        nnoremap yf :!echo -n %c:p | wl-copy %i &&
                    \ echo -n %c:p | wl-copy -p %i<cr>
    endif
elseif $DISPLAY != ''
    if executable('xclip')
        " Yank current directory path into the clipboard
        nnoremap yd :!echo -n %d | xclip -selection clipboard %i<cr>
        " Yank current file path into the clipboard
        nnoremap yf :!echo -n %c:p | xclip -selection clipboard %i<cr>
    elseif executable('xsel')
        " Yank current directory path into primary and selection clipboards
        nnoremap yd :!echo -n %d | xsel --input --primary %i &&
                    \ echo -n %d | xsel --clipboard --input %i<cr>
        " Yank current file path into into primary and selection clipboards
        nnoremap yf :!echo -n %c:p | xsel --input --primary %i &&
                    \ echo -n %c:p | xsel --clipboard --input %i<cr>
    endif
endif

" Mappings for faster renaming
nnoremap I cw<c-a>
nnoremap cc cw<c-u>
nnoremap A cw

" As above, but without the file extension
" nnoremap I cW<c-a>
" nnoremap cc cW<c-u>
" nnoremap A cW

" Open console in current directory
if $DISPLAY != '' && executable('xterm')
    nnoremap ,t :!xterm &<cr>
elseif $TERMINAL != ''
    nnoremap ,t :!$TERMINAL &<cr>
endif

" Open editor to edit vifmrc and apply settings after returning to vifm
nnoremap ,c :write | edit $MYVIFMRC | restart full<cr>

" Open gvim to edit vifmrc
if $DISPLAY != '' && executable('gvim')
    nnoremap ,C :!gvim --remote-tab-silent $MYVIFMRC &<cr>
endif

" Toggle wrap setting on ,w key
nnoremap ,w :set wrap!<cr>

" Example of standard two-panel file managers mappings
nnoremap <f3> :!less %f<cr>
nnoremap <f4> :edit<cr>
nnoremap <f5> :copy<cr>
nnoremap <f6> :move<cr>
nnoremap <f7> :mkdir<space>
nnoremap <f8> :delete<cr>

" Midnight commander alike mappings
" Open current directory in the other pane
nnoremap <a-i> :sync<cr>
" Open directory under cursor in the other pane
nnoremap <a-o> :sync %c<cr>
" Swap panes (uncomment if you don't need builtin behaviour of Ctrl-U)
" nnoremap <c-u> <c-w>x

" ------------------------------------------------------------------------------
" Panel configuration examples
" ------------------------------------------------------------------------------

" Customize view columns a bit (enable ellipsis for truncated file names)
" set viewcolumns=-{name}..,6{}.

" Show vertical border
" set fillchars=vborder:│

" Filter-out build artifacts and temporary files
" filter! {*.lo,*.o,*.d,*.class,*.pyc,*.pyo,.*~}

" ------------------------------------------------------------------------------
" Various customization examples
" ------------------------------------------------------------------------------

" Use ag (the silver searcher) instead of grep
" set grepprg='ag --line-numbers %i %a %s'

" Add additional place to look for executables
" let $PATH = $HOME.'/bin/fuse:'.$PATH

" Disable particular shortcut
" nnoremap <left> <nop>

" Export IPC name of current instance as environment variable and use it to
" communicate with the instance later.
"
" It can be used in some shell script that gets run from inside vifm, for
" example, like this:
"     vifm --server-name "$VIFM_SERVER_NAME" --remote +"cd '$PWD'"
"
" let $VIFM_SERVER_NAME = v:servername

" Activate screen/tmux support
" screen!
