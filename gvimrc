" colorscheme lucius
" LuciusDark
" colorscheme jellybeans

set columns=85         " ウインドウの幅
set lines=50           " ウインドウの高さ
set cmdheight=2        " コマンドラインの高さ(GUI使用時)


set guifont=Ricty_Diminished:h13:cSHIFTJIS
gui
"set transparency=240
" set rop=type:directx
set rop=type:directx,renmode:5,taamode:3

" vimrcを開く
nnoremap <space>g.  :<C-U>edit $MYGVIMRC<ENTER>
" vimrcを読み込む
nnoremap <space>gs.  :<C-U>source $MYGVIMRC<ENTER>

" set fileencoding=shift_jis
" set fileformat=dos

set mouse=a
