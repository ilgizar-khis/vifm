fileviewer {*.wav,*.mp3,*.flac,*.m4a,*.wma,*.ape,*.ac3,*.og[agx],*.spx,*.opus,
           \*.aac,*.mpga},
          \<audio/*>
         \ ffprobe -hide_banner -pretty %c 2>&1

fileviewer {*.avi,*.mp4,*.wmv,*.dat,*.3gp,*.ogv,*.mkv,*.mpg,*.mpeg,*.vob,
           \*.fl[icv],*.m2v,*.mov,*.webm,*.mts,*.m4v,*.r[am],*.qt,*.divx,
           \*.as[fx],*.unknown_video},
          \<video/*>
         \ ffprobe -hide_banner -pretty %c 2>&1

fileviewer {*.[1-8]},<text/troff> man ./%c | col -b
fileviewer {*.bmp,*.jpg,*.jpeg,*.png,*.gif,*.xpm},<image/*>
         \ identify %f
fileviewer {*.torrent},<application/x-bittorrent>
         \ dumptorrent -v %c,
         \ transmission-show %c
fileviewer *.zip,*.jar,*.war,*.ear,*.oxt unzip -l %f
fileviewer *.tgz,*.tar.gz tar -tzf %c
fileviewer *.tar.bz2,*.tbz2 tar -tjf %c
fileviewer *.tar.xz,*.txz tar -tJf %c
fileviewer *.tar.zst,*.tzst tar -t --zstd -f %c
fileviewer {*.tar},<application/x-tar> tar -tf %c
fileviewer {*.cpio},<application/x-cpio> cpio -t < %c
fileviewer {*.rpm},<application/x-rpm> rpm -q --list %c%q 2> /dev/null

fileviewer {*.rar},<application/x-rar> unrar v %c
fileviewer {*.7z},<application/x-7z-compressed> 7z l %c
fileviewer {*.doc},<application/msword> catdoc %c
fileviewer {*.docx},
          \<application/
           \vnd.openxmlformats-officedocument.wordprocessingml.document>
         \ docx2txt.pl %f -


" Syntax highlighting in preview
"
" Explicitly set highlight type for some extensions
"
" 256-color terminal
fileviewer *.[ch],*.[ch]pp highlight -O xterm256 -s dante --syntax c %c
fileviewer *.py,*.java,*.lua,*.rust,*.json highlight -O xterm256 -s dante --syntax c %c
fileviewer Makefile,Makefile.* highlight -O xterm256 -s dante --syntax make %c
"
" 16-color terminal
" fileviewer *.c,*.h highlight -O ansi -s dante %c
"
" Or leave it for automatic detection
" fileviewer *[^/] pygmentize -O style=monokai -f console256 -g

" Displaying pictures in terminal
" Image preview for Kitty terminal
fileviewer *.bmp,*.jpg,*.jpeg,*.png,*.gif,*.webp,*.xpm
    \ kitten icat --silent --scale-up --place=%pwx%ph@%pxx%py %c >/dev/tty </dev/tty %N
    \ %pc
    \ kitten icat --silent --clear >/dev/tty </dev/tty %N
