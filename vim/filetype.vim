filextype {*.pdf},<application/pdf> firefox %c %i, chromium %c, xpdf %c

" Audio
filetype {*.wav,*.mp3,*.flac,*.m4a,*.wma,*.ape,*.ac3,*.og[agx],*.spx,*.opus,
         \*.aac,*.mpga},
        \<audio/*>
       \ {Play using MPlayer}
       \ mplayer %f,
       \ {Play using mpv}
       \ mpv --no-video %f %s,
       \ {Play using ffplay}
       \ ffplay -nodisp -hide_banner -autoexit %c,

" Video
filextype {*.avi,*.mp4,*.wmv,*.dat,*.3gp,*.ogv,*.mkv,*.mpg,*.mpeg,*.vob,
          \*.fl[icv],*.m2v,*.mov,*.webm,*.mts,*.m4v,*.r[am],*.qt,*.divx,
          \*.as[fx],*.unknown_video},
         \<video/*>
        \ {View using ffplay}
        \ ffplay -fs -hide_banner -autoexit %f,
        \ {View using Dragon}
        \ dragon %f:p,
        \ {View using mplayer}
        \ mplayer %f,
        \ {Play using mpv}
        \ mpv %f,

" Web
filextype {*.xhtml,*.html,*.htm},<text/html>
        \ {Open with firefox}
        \ firefox %f &,
        \ {Open with chromium}
        \ chromium %f &,

filetype {*.xhtml,*.html,*.htm},<text/html> links, lynx

" Man page
filetype {*.[1-8]},<text/troff> man ./%c

filextype {*.bmp,*.jpg,*.jpeg,*.png,*.gif,*.xpm},<image/*>
        \ {View in sxiv}
        \ satty --filename %f,
        \ {View in gpicview}
        \ gpicview %c,
        \ {View in shotwell}
        \ shotwell,

" GPG signature
filetype {*.asc},<application/pgp-signature>
       \ {Check signature}
       \ !!gpg --verify %c,

" Torrent
filetype {*.torrent},<application/x-bittorrent> ktorrent %f &

" Fuse7z and 7z archives
filetype {*.7z},<application/x-7z-compressed>
       \ {Mount with fuse-7z}
       \ FUSE_MOUNT|fuse-7z %SOURCE_FILE %DESTINATION_DIR,

" Office files
filextype {*.odt,*.doc,*.docx,*.xls,*.xlsx,*.odp,*.pptx,*.ppt},
         \<application/vnd.openxmlformats-officedocument.*,
          \application/msword,
          \application/vnd.ms-excel>
          \libreoffice %f &

" Directories
filextype */
        \ {View in thunar}
        \ Thunar %f &,
