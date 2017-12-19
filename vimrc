"------------------------------------------------------------------------------
" plug.vim
" ------------------------------------------------------------------------------
" .vimrc scriptencoding utf-8 

let s:success_plug_loading = 0
let s:has_win = has('win64') || has('win32')
let s:color16 = s:has_win && !has('gui')
let s:plug_dir = s:has_win ?  '~/vimfiles/plugged' :  '~/.vim/plugged'

if $VIMCOLOR == 16
    let s:color16 = 1
endif

" vim-plugの自動インストール
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

silent! if plug#begin(s:plug_dir)

    Plug 'flazz/vim-colorschemes'     " カラースキーム集
    Plug 'chrisbra/SudoEdit.vim'      " Sudo で保存

    Plug 'osyo-manga/vim-over'        " 置換プレビュー
    Plug 'scrooloose/syntastic'       " シンタックスチェック
    Plug 'tomtom/tcomment_vim'
    Plug 'Shougo/neocomplcache.vim'
    Plug 'godlygeek/tabular'          " 整形ツール

    Plug 'tpope/vim-fugitive'

    Plug 'easymotion/vim-easymotion'
    Plug 'haya14busa/vim-asterisk'
    Plug 'haya14busa/incsearch.vim'
    
    " Unite
    Plug 'Shougo/unite.vim'
    Plug 'Shougo/vimproc.vim', { 'do': 'make' }
    Plug 'Shougo/neomru.vim'
    Plug 'Shougo/neoyank.vim'
    Plug 'ujihisa/unite-locate'
    Plug 'kmnk/vim-unite-giti'
    Plug 'thinca/vim-unite-history'

    Plug 'LeafCage/yankround.vim'

    " Plug 'terryma/vim-multiple-cursors'
    " Plug 'rhysd/clever-f.vim'
    " Plug 'rhysd/vim-shot-f'

    Plug 'rking/ag.vim'
    " Plug 'dyng/ctrlsf.vim'
    
    Plug 'editorconfig/editorconfig-vim'

    Plug 'terryma/vim-expand-region'  " 選択範囲拡張
    Plug 'junegunn/vim-easy-align'    " 整形ツール
    Plug 'godlygeek/tabular'          " 整形ツール

    Plug 'elzr/vim-json', { 'for': 'json' }
    Plug 'othree/html5.vim', { 'for' : 'json' }

    call plug#end()

    let s:success_plug_loading = 1
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
set notitle                            " タイトルを非表示

" ------------------------------------------------------------------------------
" basic
" ------------------------------------------------------------------------------

if !s:color16
    set nocursorline " カーソル行を強調表示しない
    autocmd InsertEnter,InsertLeave * set list!
    autocmd InsertEnter,InsertLeave * set cursorline! " 挿入モードの時のみ、カーソル行をハイライトする
endif

set autoindent               " 自動的にインデントする
set smartindent              " 自動的にインデント量調節
set cindent
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set list                     " タブや改行を表示
set listchars=tab:^\ ,trail:-,extends:<,precedes:> " 表示する文字

set mouse=""                       " マウスモードオフ
set lazyredraw                     " マクロ実行中に再描画しない
set ttyfast                        " ターミナル実行向け設定
set ignorecase                     " 大文字／小文字の区別の無視
set smartcase                      " 大文字を含む時は区別
set hlsearch                       "
set wrapscan                       " 検索時にファイルの最後まで行ったら最初に戻る
set showmatch                      " 括弧入力時に対応する括弧を表示
set matchtime=1                    " 括弧表示時間 0.1秒
set wildmode=longest:full,full     " wildmenu の設定
set formatoptions+=mm              " テキスト挿入中の自動折り返しを日本語に対応させる
set virtualedit=block              " block:virtualモードで文字がないところも選択できる

set clipboard=
if isdirectory(expand('~/.vim/tmp'))
    set backupdir=~/.vim/tmp
    set directory=~/.vim/tmp
    if exists('&undodir')
        set undofile
        set undodir=~/.vim/tmp
    endif
elseif isdirectory(expand('~\vimfiles\tmp'))
    set backupdir=~/vimfiles/tmp
    set directory=~/vimfiles/tmp
    set undofile
    set undodir=~/vimfiles/tmp
else
    set nobackup
    set noswapfile
    if exists('&undodir')
        set noundofile
    endif
endif

set wildmenu                       " コマンドライン補完するときに強化されたものを使う
if s:has_win
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe
else
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.gz,*~
endif
set history=1000

let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" ------------------------------------------------------------------------------
" Japanese
" ------------------------------------------------------------------------------
if exists('&imsearch')
    set imsearch=0
endif
if exists('&iminsert')
    set iminsert=0
endif


set encoding=utf-8
set fileencoding=utf-8

"" 読み込んだファイルのエンコーディングを試す順番
"" gitのためにutf-8とisoを入れ替えてみた。うまくいかないことがあったらその時修正する
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,default,latin
"" 日本語の行の連結時には空白を入力しない。
set formatoptions+=mM
"" □や○の文字があってもカーソル位置がずれないようにする。
set ambiwidth=double
"" 画面最後の行をできる限り表示する。
set display+=lastline

"" ペーストモードをトグルする。状態も表示。
set pastetoggle=<F2>

"" 行末にセミコロン;をつけて改行するキーバインド
"" http://yuheikagaya.hatenablog.jp/entry/20110216/1297842433
function! IsEndSemicolon()
    let c = getline(".")[col("$")-2]
    if c != ';'
        return 1
    else
        return 0
    endif
endfunction
inoremap <expr>;; IsEndSemicolon() ? "<C-O>$;<CR>" : "<C-O>$<CR>"


"" 折り返し行に対してもjkで移動を行う
nnoremap j gj
nnoremap k gk

"" 現在のバッファのディレクトリへのショートカット (:e %:p:h or %:h)
cnoremap %% <C-R>=expand('%:h').'/'<cr>

"x キー削除でデフォルトレジスタに入れない
nnoremap x "_x
vnoremap x "_x

"" vimrcを開く
nnoremap <space>.  :<C-U>edit $MYVIMRC<ENTER>
"" vimrcを読み込む
nnoremap <space>s.  :<C-U>source $MYVIMRC<ENTER>

nnoremap Y y$
" nnoremap + <C-a>
" nnoremap - <C-x>

" kwbd.vim : ウィンドウレイアウトを崩さないでバッファを閉じる
" http://nanasi.jp/articles/vim/kwbd_vim.html
com! Kwbd let kwbd_bn= bufnr("%")|enew|exe "bdel ".kwbd_bn|unlet kwbd_bn

" インサートモード時の移動
inoremap <C-e> <End>
inoremap <C-a> <Home>
inoremap <C-n> <Down>
inoremap <C-p> <Up>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-d> <Del>
inoremap <C-h> <BS>

" コマンドモード時の移動
cnoremap <C-e> <End>
cnoremap <C-a> <Home>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-d> <Del>
cnoremap <C-h> <BS>

inoremap <silent> jj <ESC>

" ------------------------------------------------------------------------------
" filetype
" ------------------------------------------------------------------------------
" 特的のファイルタイプでインデント幅を変更
autocmd BufNewFile,BufRead *.md set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd BufNewFile,BufRead *.yml set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd BufNewFile,BufRead *.html set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd BufNewFile,BufRead *.json set tabstop=2 softtabstop=2 shiftwidth=2 expandtab


" 自動で改行を除去
" http://stackoverflow.com/questions/356126/how-can-you-automatically-remove-trailing-whitespace-in-vim
autocmd BufWritePre *.py :%s/\s\+$//e
autocmd BufWritePre *.php :%s/\s\+$//e
autocmd BufWritePre *.yml :%s/\s\+$//e

" json のダブルクオートを非表示にするオプションを無効化
autocmd Filetype json setl conceallevel=0

autocmd BufRead,BufNewFile .bashenv set syntax=sh

" ------------------------------------------------------------------------------
" others
" ------------------------------------------------------------------------------
"
source $VIMRUNTIME/macros/matchit.vim
let b:match_words = "<if>:</if>"


nnoremap <silent> ~ :call Tilde()<CR>
function! Tilde()
    let l:from = '!"#$%&''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~'
    let l:to   = '=''#$%|"[]/_,+.\0123456789:;(!)?@abcdefghijklmnopqrstuvwxyz{*}^-`ABCDEFGHIJKLMNOPQRSTUVWXYZ<&>~'

    let l:current_line = getline('.')
    let l:current_line_num = line('.')
    let l:current_column_num = col('.')
    let l:cursor_char = matchstr(l:current_line, '.', l:current_column_num - 1)
    let l:charbytes = strlen(l:cursor_char)
    let l:split_index = match(l:current_line, '.', l:current_column_num - 1)
    let l:head = l:current_line[: l:split_index - 1]
    let l:tail = l:current_line[l:split_index + l:charbytes :]
    let l:newchar = tr(l:cursor_char, l:from, l:to)

    call setline(line('.'), l:head . l:newchar . l:tail)
    call cursor(l:current_line_num, l:current_column_num + l:charbytes)
endfunction
"}}


" 高速移動モード
let s:fast_move = 0
" nnoremap <silent> s :call ToggleHJKLStep()<CR>
function! ToggleHJKLStep()
    if s:fast_move != 0
        nnoremap j j
        nnoremap k k
        nnoremap h h
        nnoremap l l
        let s:fast_move = 0
    else
        nnoremap j 5j
        nnoremap k 5k
        nnoremap h 5h
        nnoremap l 5l
        let s:fast_move = 5
    endif
endfunction

function! ToggleBinJump()
    if s:bin_jump = 0
        call InitBinJump()
    else
        nnoremap j j
        nnoremap k k
    endif

    let b:height = winheight(0)
    let b:r_current_line = winline()
    let b:current_line = line(".")
    let b:first_line = b:current_line - b:r_current_line + 1
    let b:last_line  = b:current_line - b:r_current_line + b:height
    let b:next_line = b:first_line + ( b:current_line - b:first_line ) / 2
    call cursor( b:next_line, 0)

    echo [b:first_line, b:last_line, b:next_line, b:current_line]

    " echo getpos(".")
endfunction

function! BinJump()
    let b:height = winheight(0)
    let b:r_current_line = winline()
    let b:current_line = line(".")
    let b:first_line = b:current_line - b:r_current_line + 1
    let b:last_line  = b:current_line - b:r_current_line + b:height
    let b:next_line = b:first_line + ( b:current_line - b:first_line ) / 2
    call cursor( b:next_line, 0)

    echo [b:first_line, b:last_line, b:next_line, b:current_line]

    " echo getpos(".")
endfunction

if s:success_plug_loading == 1
    " colorscheme
    if !s:color16
        set background=dark
        colorscheme hybrid
        au BufNewFile,BufRead *.php  colorscheme jellybeans
    else
        set background=dark
        colorscheme monokai-chris
    endif

    " leader key
    let mapleader = "\<Space>"

    " ------------------------------------------------------------------------------
    " unite.vim
    " ------------------------------------------------------------------------------
    let g:unite_source_grep_max_candidates = 200
    if executable('pt')
        let g:unite_source_grep_command = 'pt'
        let g:unite_source_grep_default_opts = '--nogroup --nocolor'
        let g:unite_source_grep_recursive_opt = ''
        let g:unite_source_grep_encoding = 'utf-8'
    endif

    let g:unite_source_rec_async_command = 'pt --nogroup --nocolor -S -g .'
    let g:neomru#file_mru_ignore_pattern = '\~$\|\.\%(o\|exe\|dll\|bak\|zwc\|pyc\|sw[po]\)$'.
        \'\|\%(^\|/\)\.\%(hg\|git\|bzr\|svn\)\%($\|/\)'.
        \'\|^\%(\\\\\|/media/\|/temp/\|/tmp/\|\%(/private\)\=/var/folders/\)'.
        \'\|\%(^\%(fugitive\)://\)'.
        \'\|\%(^\%(term\)://\)'

    let g:neomru#directory_mru_ignore_pattern = '\%(^\|/\)\.\%(hg\|git\|bzr\|svn\)\%($\|/\)'.
        \'\|^\%(\\\\\|/media/\|/temp/\|/tmp/\|\%(/private\)\=/var/folders/\)'

    " call unite#custom#profile('default', 'context', { 'unite_candidate_icon': '1'})
    " mappings

    " 重要
    nnoremap <Space>m :<C-u>Unite<Space>file_mru -start-insert<CR>
    nnoremap <Space>G :<C-u>Unite grep:. -buffer-name=search-buffer -no-quit<CR>
    nnoremap <Space>R :<C-u>UniteResume<CR>
    " nnoremap <Space>r :<C-u>Unite<Space>register<CR>
    nnoremap <Space>r :<C-u>Unite<Space>yankround<CR>
    nnoremap <Space>fr :<C-u>Unite file_rec/async<CR>
    nnoremap <Space>fg :<C-u>Unite file_rec/git -start-insert<CR>
    nnoremap <Space>b :<C-u>Unite buffer -start-insert -no-quit<CR>
    nnoremap <Space>: :<C-u>Unite<Space>

    nnoremap <Space>gt :<C-u>Unite<Space>giti<CR>

    " 要らないショートカット？
    " nnoremap <Space>b :<C-u>Unite buffer -quick-match<CR>
    " nnoremap <Space>ff :<C-u>Unite file<CR>
    " nnoremap <Space>ff :<C-u>VimFiler<CR>
    " nnoremap <Space>fm :<C-u>Unite git_modified<CR>
    " nnoremap <Space>fg :<C-u>Unite file_rec/git -start-insert<CR>
    " nnoremap <Space>a :<C-u>Unite buffer file file_mru bookmark<CR>
    nnoremap <Space>y :<C-u>Unite history/yank<CR>
    nnoremap <Space>/ :<C-u>Unite line:al<CR>

    " ------------------------------------------------------------------------------
    " yankround
    " ------------------------------------------------------------------------------
    nmap p <Plug>(yankround-p)
    xmap p <Plug>(yankround-p)
    nmap P <Plug>(yankround-P)
    nmap gp <Plug>(yankround-gp)
    xmap gp <Plug>(yankround-gp)
    nmap gP <Plug>(yankround-gP)
    nmap <C-p> <Plug>(yankround-prev)
    nmap <C-n> <Plug>(yankround-next)

    " ------------------------------------------------------------------------------
    " neocomplcache
    " ------------------------------------------------------------------------------
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_max_list = 30
    let g:neocomplcache_auto_completion_start_length = 2
    let g:neocomplcache_enable_smart_case = 1
    let g:neocomplcache_enable_underbar_completion = 1
    inoremap <expr><C-g> neocomplcache#undo_completion()
    inoremap <expr><C-l> neocomplcache#complete_common_string()
    "" <CR>: close popup and save indent.
    "inoremap <expr><CR> neocomplcache#smart_close_popup() . (&indentexpr != '' ?
    ""\<C-f>\<CR>X\<BS>":"\<CR>")
    inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
    "" <TAB>: completion.
    inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    "" <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplcache#smart_close_popup() . "\<C-h>"
    inoremap <expr><BS> neocomplcache#smart_close_popup() . "\<C-h>"
    inoremap <expr><C-y> neocomplcache#close_popup()
    inoremap <expr><C-e> neocomplcache#cancel_popup()

    " ------------------------------------------------------------------------------
    " easy motion
    " ------------------------------------------------------------------------------
    let g:EasyMotion_startofline=0
    map s <Plug>(easymotion-s2)
    map <Space>j <Plug>(easymotion-j)
    map <Space>k <Plug>(easymotion-k)

    "" incsearch.vim
    map /  <Plug>(incsearch-forward)
    map ?  <Plug>(incsearch-backward)
    map g/ <Plug>(incsearch-stay)

    "" vim-asterisk
    map *   <Plug>(asterisk-*)
    map #   <Plug>(asterisk-#)
    map g*  <Plug>(asterisk-g*)
    map g#  <Plug>(asterisk-g#)
    map z*  <Plug>(asterisk-z*)
    map gz* <Plug>(asterisk-gz*)
    map z#  <Plug>(asterisk-z#)
    map gz# <Plug>(asterisk-gz#)

    " ------------------------------------------------------------------------------
    " others plugins
    " ------------------------------------------------------------------------------

    " over.vim
    noremap <Space>s :OverCommandLine<CR>

    " vim-multiple-cursors
    let g:multi_cursor_use_default_mapping=0

    " ag.vim
    if filereadable($HOME . "/.local/bin/pt")
        let g:ag_prg=$HOME."/.local/bin/pt --column"
    elseif filereadable($GOPATH . "/bin/pt")
        let g:ag_prg=$GOPATH."/bin/pt --column"
    elseif filereadable($GOPATH . "\\bin\\pt.exe")
        let g:ag_prg=$GOPATH."\\bin\\pt.exe --column"
    endif


    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    " let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 0
    let g:syntastic_check_on_wq = 0

    let g:Align_xstrlen=3
    let g:syntastic_enable_signs=1
    " let g:syntastic_auto_loc_list=2
    let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
    let g:syntastic_php_phpcs_args=' --standard=psr2'

    cabbrev sr SudoRead%
    cabbrev sw SudoWrite%

    "" easy-align
    vmap <Enter> <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)
endif
