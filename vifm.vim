" vim: filetype=vim :
"
" Sample configuration file for vifm (last updated: 11 February 2026)
"
" You can edit this file by hand.  The " character at the beginning of a line
" comments out the line.  Blank lines are ignored.  The basic format for each
" item is shown with an example.
"
" The purpose of this file
" ========================
" 1. Provide a sensible default configuration out of the box.
" 2. Demonstrate how a typical configuration file might look like.
" 3. Familiarize a user with commonly used features.
" 4. Provide some ideas/settings for various use cases.
"
" How to use this file
" ====================
" - Go through it top to bottom while reading comments.
" - Adjust/remove/comment/uncomment lines as you see fit.
" - Look up :commands or 'options' in the documentation to learn more.
"
" Some settings are set to provide more useful defaults without breaking
" compatibility and others are just a great fit (e.g., some bindings) and are
" almost universally useful, but most lines are provided simply as usage
" examples and can be removed without hesitation.  Make configuration specific
" to your needs using this file as a starting point.

" ------------------------------------------------------------------------------
" Main settings
" ------------------------------------------------------------------------------
"
" Command used to edit files in various contexts.  The default is vim.
" If you would like to use another vi clone such as Elvis or Vile
" you will need to change this setting.
if executable('vim')
    set vicmd=vim
elseif executable('nvim')
    set vicmd=nvim
elseif executable('elvis')
    set vicmd=elvis\ -G\ termcap
elseif executable('vile')
    set vicmd=vile
elseif $EDITOR != ''
    echo 'Note: using `'.$EDITOR.'` as an editor'
    let &vicmd = $EDITOR
elseif executable('vi')
    set vicmd=vi
endif

" This makes vifm perform file operations on its own instead of relying on
" standard utilities like `cp`.  While using `cp` and alike is a more universal
" solution, it's also much slower when processing large amounts of files and
" doesn't support progress measuring.
set syscalls

" Trash Directory
" The default is to move files that are deleted with dd or :d to
" the trash directory.  If you change this you will not be able to move
" files by deleting them and then using p to put the file in the new location.
" I recommend not changing this until you are familiar with vifm.
" This probably shouldn't be an option.
set trash

" What should be saved automatically on restarting vifm.  Drop "savedirs"
" value if you don't want vifm to remember last visited directories for you.
set vifminfo=dhistory,savedirs,chistory,state,tui,tabs,shistory,ehistory,
            \phistory,fhistory,dirstack,registers,bookmarks,bmarks,mchistory

" This is size of all of the many kinds of histories, in particular it's the
" number of last visited directories (not necessarily distinct ones) stored in
" the directory history.
set history=100

" Automatically resolve symbolic links on l or Enter.
set nofollowlinks

" Natural sort of (version) numbers within text.
set sortnumbers

" Maximum number of changes that can be undone.
set undolevels=100

" Use Vim's format of help file (has highlighting and "hyperlinks").
" If you would rather use a plain text help file set novimhelp.
set vimhelp

" If you would like to run an executable file when you
" press Enter, l or Right Arrow, set this.
set norunexec

" Format for displaying time in file list. For example:
" TIME_STAMP_FORMAT=%m/%d-%H:%M
" See man date or man strftime for details.
set timefmt='%Y/%m/%d %H:%M'

" Show list of matches on tab completion in command-line mode
set wildmenu

" Display completions in a form of popup with descriptions of the matches
set wildstyle=popup

" Display suggestions in normal, visual and view modes for keys, marks and
" registers (at most 5 files).  In other view, when available.
set suggestoptions=normal,visual,view,otherpane,keys,marks,registers

" Ignore case in search patterns unless it contains at least one uppercase
" letter
set ignorecase
set smartcase

" Don't select search matches automatically
set nohlsearch

" Use increment searching (search while typing)
set incsearch

" Try to leave some space from cursor to upper/lower border in lists
set scrolloff=4

" Don't do too many requests to slow file systems
if !has('win')
    set slowfs=curlftpfs
endif

" Set custom status line look
if !has('win')
    set statusline="  Hint: %z%= %A %10u:%-7g %15s %20d  "
else
    set statusline="  Hint: %z%= %A %15s %20d  "
endif

" Suppress "Permission denied" errors using syntax specific to GNU find
if system("find --version | grep -c 'GNU findutils'") != 0
    set findprg='find %s %a -print , -type d \( ! -readable -o ! -executable \) -prune'
endif

" Add -s to the default value to suppress "Permission denied" errors
set grepprg="grep -n -H -I -r -s %i %a %s"

" List of color schemes to try (picks the first one supported by the terminal)
colorscheme gruvbox Default

" ------------------------------------------------------------------------------
" Bookmarks
" ------------------------------------------------------------------------------

" :mark mark /full/directory/path [filename]

mark b ~/bin/
mark h ~/

" ------------------------------------------------------------------------------
" Commands
" ------------------------------------------------------------------------------

" :com[mand][!] command_name action
"
" These are some of the macros that can be used in the action part:
"  %a for user arguments
"  %c for current file under the cursor
"  %C for current file under the cursor of inactive pane
"  %f for selected file(s)
"  %F for selected file(s) of inactive pane
"  %b is the same as %f %F
"  %d for current directory name
"  %D for current directory name of inactive pane
"  %r{x} for list of files in register {x}
"  %m runs the command in a menu window
"  %u uses command's output to build a file list
"  see `:help vifm-macros` and `:help vifm-filename-modifiers` for more

command! df df -h %m 2> /dev/null
command! diff vim -d %f %F
command! zip zip -r %c.zip %f
command! run !! ./%f
command! make !!make %a
command! mkcd :mkdir %a | cd %a
command! vgrep vim "+grep %a"
command! reload :write | restart full

" ------------------------------------------------------------------------------
" File handlers and previewers
" ------------------------------------------------------------------------------

" Setting up handlers that are considered in all environments:
"   filetype {pattern1,pattern2} program1,{Optional description}program2
"
" Setting up handlers that are considered only in a graphical environment:
"   filextype {pattern} graphical-program %c
"
" Setting up previewers:
"   fileviewer {pattern1,pattern2} console-viewer1,console-viewer2
"
" ORDER MATTERS!  Both handlers and previewers are considered in the order of
" their definition, therefore they should be defined from most to least
" specific.  In particular, catch-all patterns like `*`, `*/`, `.*`, `*.*`
" should be defined after all others.
"
" All entries matching a particular file are considered in order until an
" existing command is found.  Other entries are accessible via :file command
" for handlers or via `a` and `A` keys for previewers in view mode.
"
" The ordering can be checked at run-time by running
" :filetype/:filextype/:fileviewer with a file name as the only argument.
" This displays a menu of defined entries annotated with availability of
" commands.
"
" More on syntax and usage:
"  - macros like %c, %f, %d, etc. may be used in the commands
"  - the %a macro is ignored
"  - to insert a literal % use %%
"  - spaces in an app name must be escaped, for example:
"    + QuickTime\ Player.app
"    + "c:/Program Files (x86)/app/app.exe"

" For automated FUSE mounts, you must register an extension with :file[x]type
" in one of the following formats:
"
" :filetype patterns FUSE_MOUNT|mount_cmd %SOURCE_FILE %DESTINATION_DIR
"
" %SOURCE_FILE and %DESTINATION_DIR are filled in at runtime.
"
" Example:
"   :filetype *.zip,*.[jwe]ar FUSE_MOUNT|fuse-zip %SOURCE_FILE %DESTINATION_DIR
"
" :filetype patterns FUSE_MOUNT2|mount_cmd %PARAM %DESTINATION_DIR
"
" %PARAM and %DESTINATION_DIR are filled in at runtime.
"
" Example:
"   :filetype *.ssh FUSE_MOUNT2|sshfs %PARAM %DESTINATION_DIR
"
" %PARAM value is the first line of the matched file, example: root@127.0.0.1:/
"
" You can also add %CLEAR if you want to clear screen before running FUSE
" program.  There is also %FOREGROUND, which is useful for entering passwords.

" Pdf

source ~/.config/vifm/vim/filetype.vim

source ~/.config/vifm/vim/fileviewer.vim
" Open all other files with default system programs (you can also remove all
" :file[x]type commands above to ensure they don't interfere with system-wide
" settings).  By default all unknown files are opened with 'vi[x]cmd'
" uncommenting one of lines below will result in ignoring 'vi[x]cmd' option
" for unknown file types.
" For *nix:
" filetype * xdg-open
" For OS X:
" filetype * open
" For Windows:
" filetype * explorer %"f &

" ------------------------------------------------------------------------------
" Sample keyboard mappings
" ------------------------------------------------------------------------------

source ~/.config/vifm/vim/maps.vim
" ------------------------------------------------------------------------------
" Icon decorations example
" ------------------------------------------------------------------------------

" https://github.com/cirala/vifm_devicons
source ~/.config/vifm/vifm_devicons/favicons.vifm
