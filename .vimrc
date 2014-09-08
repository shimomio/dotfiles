if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=utf-8,latin1
endif

set bs=indent,eol,start     " allow backspacing over everything in insert mode
"set ai         " always set autoindenting on
"set backup     " keep a backup file
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
            " than 50 lines of registers
set history=50      " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set wildmenu
set hidden
set autoindent
set laststatus=2
set visualbell
set t_vb=
set mouse=a
set number
set shiftwidth=4
set tabstop=4
set softtabstop=0

inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
vnoremap { "zdi^V{<C-R>z}<ESC>
vnoremap [ "zdi^V[<C-R>z]<ESC>
vnoremap ( "zdi^V(<C-R>z)<ESC>
vnoremap " "zdi^V"<C-R>z^V"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>

autocmd FileType javascript
	\ :setl omnifunc=jscomplete#CompleteJS

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
    " In text files, always limit the width of text to 78 characters
    autocmd BufRead *.txt set tw=78
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END 
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst 
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if &term=="xterm"
     set t_Co=8
     set t_Sb=^[[4%dm
     set t_Sf=^[[3%dm
endif

filetype off

function! s:open_kobito(...)
	if a:0 == 0
		call system('open -a Kobito '.expand('%:p'))
	else
		call system('open -a Kobito '.join(a:000, ' '))
	endif
endfunction


"---------------------------------------------------
""	Kobitoと連携する
"---------------------------------------------------
" 引数のファイル(複数指定可)を
" Kobitoで開く
"
"（引数無しのときはカレントバッファを開く
command! -nargs=* Kobito call s:open_kobito(<f-args>)
" Kobito を閉じる
command! -nargs=0 KobitoClose call system("osascript -e 'tell application \"Kobito\" to quit'")
" Kobito にフォーカスを移す
command! -nargs=0 KobitoFocus call system("osascript -e 'tell application \"Kobito\" to activate'")

"---------------------------------------------------
""	neobuncle.vim
"---------------------------------------------------

set nocompatible

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc'

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'gmarik/vundle'
NeoBundle 'fholgado/minibufexpl.vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'ZenCoding.vim'
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'teramako/jscomplete-vim'
NeoBundle 'Lokaltog/vim-easymotion'

filetype plugin indent on
NeoBundleCheck

"---------------------------------------------------
""	neocomplcache
"---------------------------------------------------
" 起動時に有効化
let g:neocomplcache_enable_at_startup = 1
" 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1
" シンタックスをキャッシュするときの最小文字長
let g:neocomplcache_min_syntax_length = 3
" キャメルケースの補完を有効化
let g:neocomplcache_enable_camel_case_completion = 1
" _(アンダースコア)区切りの補完を有効化
let g:neocomplcache_enable_underbar_completion = 1

" 改行で補完ウィンドウを閉じる
inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"

" 辞書
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'javascript' : $HOME.'/.vim/dict/javascript.dict',
    \ }


"---------------------------------------------------
""	vime-easymotion
"---------------------------------------------------
" ホームポジションに近いキーを使う
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
" 「'」 + 何かにマッピング
let g:EasyMotion_leader_key="'"
" 1 ストローク選択を優先する
let g:EasyMotion_grouping=1
" カラー設定変更
hi EasyMotionTarget ctermbg=none ctermfg=red
hi EasyMotionShade  ctermbg=none ctermfg=blue


