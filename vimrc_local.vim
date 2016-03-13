" Kaoriya-vim 用のファイル
" $VIM にコピーする
"
" また、 $VIM/switches/catalog から" $VIM/switches/enabled に 
" disable-vimproc.vim と utf-8.vimをコピーしておく

if has('win32') || has('win64')
    let plugin_autodate_disable  = 1
    let plugin_cmdex_disable     = 1
    let plugin_dicwin_disable    = 1
    let plugin_format_disable    = 1
    let plugin_hz_ja_disable     = 1
    let plugin_scrnmode_disable  = 1
    let plugin_verifyenc_disable = 1

    let g:vimrc_local_finish     = 1
    let g:gvimrc_local_finish    = 1
endif

if filereadable(expand("~/_vimrc"))
  finish
endif
