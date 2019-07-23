"------------------------------------------------------------------------------
" plug.vim
" ------------------------------------------------------------------------------
if has('nvim')
  let s:plug_dir = has('win64') ? '~/AppData/Local/nvim/plugged' : '~/.local/share/nvim/plugged'
else
  let s:plug_dir = has('win64') ? '~/vimfiles/plugged' :  '~/.vim/plugged'
endif


if plug#begin(s:plug_dir)
  Plug 'flazz/vim-colorschemes'     " カラースキーム集
  Plug 'tyru/caw.vim'
  Plug 'osyo-manga/vim-anzu'
  Plug 'editorconfig/editorconfig-vim'

  Plug 'w0rp/ale'
  Plug 'Shougo/denite.nvim'
  Plug 'Shougo/neomru.vim'

  if !has('win64')
    Plug 'chrisbra/SudoEdit.vim'
  endif

  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif
  let g:deoplete#enable_at_startup = 1

  call plug#end()

  let g:success_plug_loading = 1
endif

" ------------------------------------------------------------------------------
" appearance
" ------------------------------------------------------------------------------
set t_Co=256

set number                             " 行数表示
set ruler                              " ルーラーを表示
set backspace=eol,indent,start         " バックスペースで削除可能な文字
set wrap                               " 長い行を折り返して表示
set laststatus=2                       " 常にステータス行を表示
set cmdheight=2                        " コマンドラインの高さ
set showcmd                            " コマンドをステータス行に表示
set title                              " タイトルを表示

colorscheme molokai

" ------------------------------------------------------------------------------
" basic
" ------------------------------------------------------------------------------
set autoindent               " 自動的にインデントする
set smartindent              " 自動的にインデント量調節
set cindent
set tabstop=4 softtabstop=2 shiftwidth=2 expandtab
set list                     " タブや改行を表示
set listchars=tab:^\ ,trail:-,extends:<,precedes:> " 表示する文字
:set fileencodings=utf-8,cp932,euc-jp,sjis

set mouse=""                       " マウスモードオフ
set lazyredraw                     " マクロ実行中に再描画しない
set ignorecase                     " 大文字／小文字の区別の無視
set smartcase                      " 大文字を含む時は区別
set hlsearch                       "
set wrapscan                       " 検索時にファイルの最後まで行ったら最初に戻る
set showmatch                      " 括弧入力時に対応する括弧を表示
set matchtime=1                    " 括弧表示時間 0.1秒
set formatoptions+=mm              " テキスト挿入中の自動折り返しを日本語に対応させる
set virtualedit=block              " block:virtualモードで文字がないところも選択できる
if !has('nvim')
  set ttyfast                        " ターミナル実行向け設定
endif

if has('nvim')
  "" レジスタ周りの設定
  vnoremap <S-Del> "+x
  vnoremap <C-Insert> "+y
  noremap! <S-Insert> <C-R>+
endif

set wildmenu                       " コマンドライン補完するときに強化されたものを使う
set wildmode=longest:full,full     " wildmenu の設定
if has('win64')
  set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe
else
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.gz,*~
endif


"" 現在のバッファのディレクトリへのショートカット (:e %:p:h or %:h)
cnoremap %% <C-R>=expand('%:h').'/'<cr>

"" vimrcを開く
nnoremap <space>.  :<C-U>edit $MYVIMRC<ENTER>
"" vimrcを読み込む
nnoremap <space>s.  :<C-U>source $MYVIMRC<ENTER>

if g:success_plug_loading
  " vim-anzu
  nmap n <Plug>(anzu-n-with-echo)
  nmap N <Plug>(anzu-N-with-echo)
  nmap * <Plug>(anzu-star-with-echo)
  nmap # <Plug>(anzu-sharp-with-echo)

  " saw.vim
  if has('win64')
    nmap <C-/> <Plug>(caw:hatpos:toggle)
    vmap <C-/> <Plug>(caw:hatpos:toggle)
  else
    nmap <C-_> <Plug>(caw:hatpos:toggle)
    vmap <C-_> <Plug>(caw:hatpos:toggle)
  endif

  " denite.vim
  "
  call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
  call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')

  nnoremap <Space>m :<C-u>Denite file_mru<CR>

endif
