" vim:set fdm=marker
set nocompatible " be iMprove
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()


" Bundles {{{
runtime! macros/matchit.vim

Bundle 'gmarik/vundle'

" Colors
Bundle 'vheon/vim-colors-solarized'
Bundle 'sjl/badwolf'

" UI
Bundle 'Lokaltog/vim-powerline'
Bundle 'vheon/vim-powerline-settings'

Bundle 'Raimondi/delimitMate'
Bundle 'tpope/vim-sleuth'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-scriptease'
Bundle 'vheon/vim-unimpaired'
Bundle 'kien/ctrlp.vim'

Bundle 'henrik/vim-indexed-search'
Bundle 'scrooloose/nerdtree'
Bundle 'godlygeek/tabular'
Bundle 'majutsushi/tagbar'
Bundle 'SirVer/ultisnips'
Bundle 'sjl/gundo.vim'
" TODO: check the setup for this
" Bundle 'scrooloose/syntastic'
"TODO: check if this works as should
" Bundle 'AndrewRadev/splitjoin.vim'

" More Runtime files
Bundle 'vheon/vim-plasm-js'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-haml'
Bundle 'nelstrom/vim-markdown-folding'
Bundle 'tejr/vim-tmux'
Bundle 'vheon/rfc-syntax'
Bundle 'kchmck/vim-coffee-script'
Bundle 'pangloss/vim-javascript'
Bundle 'leshill/vim-json'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rvm'

" Try to slim the config
" Bundle 'nathanaelkane/vim-indent-guides'
" Bundle 'vheon/Rainbow-Parenthesis-Bundle'
" Bundle 'maksimr/vim-jsbeautify'
" Bundle 'Lokaltog/vim-easymotion'
" Bundle 'kana/vim-arpeggio'
" Bundle 'Smart-Home-Key'
" Bundle 'lukaszb/vim-web-indent'

" }}}
" General Settings {{{

filetype plugin indent on

syntax on

let mapleader=","

colorscheme solarized
set background=dark

set encoding=utf-8

set backspace=indent,eol,start
set showmatch
set complete-=i
set completeopt+=longest

set number

set autoindent
set shiftround
set smarttab

set ttimeout
set timeoutlen=500
set ttimeoutlen=50

set hlsearch
set incsearch
set smartcase
set ignorecase

" TODO: put something in it? Usually I use Powerline :S
" set statusline=?
set laststatus=2
set cmdheight=2
set showmode
set showcmd
set ruler
set wildmenu
set wildmode=list:longest
set wildignore+=*.o,*.obj,*~
set wildignore+=*.DS_Store
set wildignore+=*.png,*.jpg,*.jpeg,*.gif
set wildignore+=*.mkv,*.avi

set scrolloff=1
set sidescrolloff=5
set display+=lastline

set autoread
set hidden
set cursorline

if has("balloon_eval")
  set ballooneval
endif

set history=1000
set viminfo^=!

set noerrorbells
set novisualbell
" TODO: Not sure if this is necessary
set t_vb=

set noswapfile
set nobackup
set nowritebackup

" Seems that a lot of ftplugin rewrite this option
" so I'm wondering if I should learn to live with it
" set formatoptions-=o
set nrformats-=octal

set foldmethod=marker
set foldtext=MyFoldText()

set list
let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"

if has('mouse')
  set mouse=a
endif

if has('gui_running')
  set guioptions-=r
  set guioptions-=R
  set guioptions-=l
  set guioptions-=L
  set guioptions-=T

  if has('gui_gtk2')
    set guifont=Source\ Code\ Pro\ for\ Powerline\ 9
  else
    set guifont=Source\ Code\ Pro\ for\ Powerline:h12
  endif
endif

" }}}
" Plugin Settings {{{

" Vundle {{{
exe "sign define Vu_error    texthl=DiffDelete"
exe "sign define Vu_active   texthl=DiffChange"
exe "sign define Vu_todate   texthl=DiffText"
exe "sign define Vu_new      texthl=DiffAdd"
exe "sign define Vu_updated  texthl=DiffAdd"
exe "sign define Vu_deleted  texthl=DiffDelete"
exe "sign define Vu_helptags texthl=DiffAdd"

" }}}
" Ctrlp {{{
let g:ctrlp_max_height = 15
let g:ctrlp_map        = '<leader>t'
" }}}
" DelimitMate {{{
let g:delimitMate_expand_cr = 1
" }}}
" GunDo {{{
let g:gundo_width           = 60
let g:gundo_preview_height  = 30
let g:gundo_right           = 1
let g:gundo_close_on_revert = 1
let g:gundo_preview_bottom  = 0
" }}}
" NERDTree {{{
let g:NERDTreeMinimalUI  = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeDirArrows  = 1
let g:NERDChristmasTree  = 1
" }}}
" Powerline {{{
let g:Powerline_symbols     = 'fancy'
let g:Powerline_colorscheme = 'darkSolarized'
let g:Powerline_theme       = 'vheon'
" }}}
" Ultisnips {{{
let g:UltiSnipsSnippetDirectories = ["personal-UltiSnips"]
let g:UltiSnipsEditSplit          = "vertical"
" }}}
" Tagbar {{{
let g:tagbar_iconchars   = ['▾', '▸']
let g:tagbar_autofocus   = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_autoclose   = 1
" }}}

" }}}
" Functions & Commands {{{

function! MyFoldText()
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction

function! s:setProperPowerline()
  let g:Powerline_colorscheme = &background."Solarized"
endfunction

function! s:ToggleSolarized()
  ToggleBG
  call s:setProperPowerline()
  PowerlineReloadColorscheme
endfunction
command! ToggleSolarized call s:ToggleSolarized()

" Sudo write
command! W exec 'w !sudo tee % > /dev/null' | e!

function! s:FollowSymlink()

  let b:orig_file = fnameescape(expand('%:p'))
  if getftype(b:orig_file) == 'link'
    let b:target_file = fnamemodify(resolve(b:orig_file))
    execute 'silent! file ' . fnameescape(b:target_file) . ' | e'
  endif
endfunction
command! FollowSymlink call <SID>FollowSymlink()

" Toggle number & relativenumber
function! s:NumberToggle()
  if &number
    set relativenumber
  else
    set number
  endif
endfunction
command! NumberToggle call <SID>NumberToggle()

" }}}
" Mappings {{{

" Avoid Bad Abits!
map <Left>  <nop>
map <Right> <nop>
map <Up>    <nop>
map <Down>  <nop>

imap <Left>  <nop>
imap <Right> <nop>
imap <Up>    <nop>
imap <Down>  <nop>

nnoremap Y y$

if has("gui_macvim")

  imap <silent> <D-j> _
  cnoremap <D-j> _
  omap <D-j> _

  " TODO: this require a gvimrc to unmap <D-l>"
  imap <silent> <D-l> -
  cnoremap <D-l> -
endif

cnoremap      <C-n>  <Down>
cnoremap      <C-p>  <Up>
cnoremap      <C-A>  <C-B>
cnoremap <C-X><C-A>  <C-A>

" Easy splits navigation
nnoremap gh <C-w>h
nnoremap gj <C-w>j
nnoremap gk <C-w>k
nnoremap gl <C-w>l

" All this for let Ultisnips and delimitMate work together:
function! JumpKey(key)
  " let char = delimitMate#GetCharFromCursor(0)
  let char = getline('.')[col('.')-1]
  let list = b:_l_delimitMate_right_delims + b:_l_delimitMate_quotes_list

  " Closing delimiter on the right.
  if (index(list, char) > -1)
    return "\<Right>"
  endif

  return a:key
endfunction


" TODO: fork ultisnips for a ShouldExpand()
let g:ulti_expand_res = 0
function! Ulti_ExpandSnippet()
  call UltiSnips_ExpandSnippet()
  return g:ulti_expand_res
endfunction

let g:UltiSnipsExpandTrigger="<F18>"
inoremap <silent> <Tab> <C-R>=Ulti_ExpandSnippet() > 0
      \ ? ""
      \ : JumpKey("\<Tab>")<CR>
      " \ : delimitMate#JumpAny("\<Tab>")<CR>

" Skip all delimiters with S-Tab
inoremap <silent> <S-Tab> <C-R>=delimitMate#JumpMany()<CR>

" Quickly edit the vimrc file
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>

" Toggle fold
nnoremap <Space> za

" Stolen from tpope
if exists(":nohls")
  nnoremap <silent> <C-L> :nohls<CR><C-L>
endif

" Toggle Solarized Theme as well as Powerline
call togglebg#map("<F5>")
nnoremap <F5> :ToggleSolarized<cr>
inoremap <F5> <esc>:ToggleSolarized<cr>a

nnoremap <Leader>b :CtrlPBuffer<cr>
nnoremap <silent> <Leader>u :GundoToggle<cr>
nnoremap <C-f> :NERDTreeToggle<cr>
nnoremap <C-o> :TagbarToggle<cr>

" visual shifting (does not exit Visual mode)
" TODO: Maybe is not right to remap plain '<' & '>'
vnoremap < <gv
vnoremap > >gv

" Make selecting inside an HTML tag better
vnoremap <silent> it itVkoj
vnoremap <silent> at atV

" Motion for 'next/last object'. For example, 'din(' would go to the next '()' pair
" and delete its contents.
" TODO: It not handle wery well empty '()'
onoremap an :<c-u>call <SID>NextTextObject('a', 'f')<cr>
xnoremap an :<c-u>call <SID>NextTextObject('a', 'f')<cr>
onoremap in :<c-u>call <SID>NextTextObject('i', 'f')<cr>
xnoremap in :<c-u>call <SID>NextTextObject('i', 'f')<cr>
onoremap al :<c-u>call <SID>NextTextObject('a', 'F')<cr>
xnoremap al :<c-u>call <SID>NextTextObject('a', 'F')<cr>
onoremap il :<c-u>call <SID>NextTextObject('i', 'F')<cr>
xnoremap il :<c-u>call <SID>NextTextObject('i', 'F')<cr>
function! s:NextTextObject(motion, dir)
  let c = nr2char(getchar())

  if c ==# "b"
    let c = "("
  elseif c ==# "B"
    let c = "{"
  elseif c ==# "d"
    let c = "["
  endif

  exe "normal! ".a:dir.c."v".a:motion.c
endfunction

" Always move through visual lines:
nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk

"TODO: Test it a bit an see
nmap o o<Plug>DiscretionaryEnd

" }}}
" Autocommands {{{

if has('autocmd')


  augroup cursor_line
    au!
    au BufEnter,WinEnter,InsertLeave * set cursorline
    au BufLeave,WinLeave,InsertEnter * set nocursorline
  augroup END

  " augroup set_list
  "     au!
  "     au InsertEnter * setlocal nolist
  "     au InsertLeave * setlocal list
  " augroup END

  augroup reload_vimrc
    au!
    au BufWritePost $MYVIMRC source $MYVIMRC |
          \ call s:setProperPowerline() |
          \ call Pl#Load()
    au BufWritePost ~/.vim/vimrc source ~/.vim/vimrc |
          \ call s:setProperPowerline() |
          \ call Pl#Load()
  augroup END

  " Enable omni completion
  " TODO: are these going to stay here?
  augroup omnifunc
    au!
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  augroup END

  augroup line_return
    au!
    au BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   execute 'normal! g`"zvzz' |
          \ endif
  augroup END

  augroup bundle_keyword
    au!
    au BufReadPre $MYVIMRC exe 'syn keyword vimCommand Bundle'
  augroup END

endif

" }}}
