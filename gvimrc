" colorscheme lucius
" LuciusDark
" colorscheme jellybeans

set columns=85         " �E�C���h�E�̕�
set lines=50           " �E�C���h�E�̍���
set cmdheight=2        " �R�}���h���C���̍���(GUI�g�p��)


set guifont=Ricty_Diminished:h13:cSHIFTJIS
gui
"set transparency=240
" set rop=type:directx
set rop=type:directx,renmode:5,taamode:3

" vimrc���J��
nnoremap <space>g.  :<C-U>edit $MYGVIMRC<ENTER>
" vimrc��ǂݍ���
nnoremap <space>gs.  :<C-U>source $MYGVIMRC<ENTER>

" set fileencoding=shift_jis
" set fileformat=dos

set mouse=a
