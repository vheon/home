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

Bundle 'kana/vim-textobj-user'
Bundle 'kana/vim-textobj-line'
Bundle 'kana/vim-textobj-function'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'thinca/vim-textobj-function-javascript'
Bundle 'vheon/vim-textobj-underscore'

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

Bundle 'derekwyatt/vim-scala'

" Bundle 'Yggdroot/indentLine'
" Try to slim the config
" Bundle 'nathanaelkane/vim-indent-guides'
" Bundle 'vheon/Rainbow-Parenthesis-Bundle'
" Bundle 'maksimr/vim-jsbeautify'
" Bundle 'Lokaltog/vim-easymotion'
" Bundle 'kana/vim-arpeggio'
" Bundle 'Smart-Home-Key'
" Bundle 'lukaszb/vim-web-indent'

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
" Markdown Folding {{{
let g:markdown_fold_style = 'nested'
" }}}
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

" Next and Last
" From steve losh .vimrc https://github.com/sjl/dotfiles/blob/master/vim/vimrc

" Motion for "next/last object".  "Last" here means "previous", not "final".
" Unfortunately the "p" motion was already taken for paragraphs.
"
" Next acts on the next object of the given type, last acts on the previous
" object of the given type.  These don't necessarily have to be in the current
" line.
"
" Currently works for (, [, {, and their shortcuts b, r, B. 
"
" Next kind of works for ' and " as long as there are no escaped versions of
" them in the string (TODO: fix that).  Last is currently broken for quotes
" (TODO: fix that).
"
" Some examples (C marks cursor positions, V means visually selected):
"
" din'  -> delete in next single quotes                foo = bar('spam')
"                                                      C
"                                                      foo = bar('')
"                                                                C
"
" canb  -> change around next parens                   foo = bar('spam')
"                                                      C
"                                                      foo = bar
"                                                               C
"
" vin"  -> select inside next double quotes            print "hello ", name
"                                                       C
"                                                      print "hello ", name
"                                                             VVVVVV

onoremap an :<c-u>call <SID>NextTextObject('a', '/')<cr>
xnoremap an :<c-u>call <SID>NextTextObject('a', '/')<cr>
onoremap in :<c-u>call <SID>NextTextObject('i', '/')<cr>
xnoremap in :<c-u>call <SID>NextTextObject('i', '/')<cr>

onoremap al :<c-u>call <SID>NextTextObject('a', '?')<cr>
xnoremap al :<c-u>call <SID>NextTextObject('a', '?')<cr>
onoremap il :<c-u>call <SID>NextTextObject('i', '?')<cr>
xnoremap il :<c-u>call <SID>NextTextObject('i', '?')<cr>


function! s:NextTextObject(motion, dir)
    let c = nr2char(getchar())
    let d = ''

    if c ==# "b" || c ==# "(" || c ==# ")"
        let c = "("
    elseif c ==# "B" || c ==# "{" || c ==# "}"
        let c = "{"
    elseif c ==# "r" || c ==# "[" || c ==# "]"
        let c = "["
    elseif c ==# "'"
        let c = "'"
    elseif c ==# '"'
        let c = '"'
    else
        return
    endif

    " Find the next opening-whatever.
    execute "normal! " . a:dir . c . "\<cr>"

    if a:motion ==# 'a'
        " If we're doing an 'around' method, we just need to select around it
        " and we can bail out to Vim.
        execute "normal! va" . c
    else
        " Otherwise we're looking at an 'inside' motion.  Unfortunately these
        " get tricky when you're dealing with an empty set of delimiters because
        " Vim does the wrong thing when you say vi(.

        let open = ''
        let close = ''

        if c ==# "("
            let open = "("
            let close = ")"
        elseif c ==# "{"
            let open = "{"
            let close = "}"
        elseif c ==# "["
            let open = "\\["
            let close = "\\]"
        elseif c ==# "'"
            let open = "'"
            let close = "'"
        elseif c ==# '"'
            let open = '"'
            let close = '"'
        endif

        " We'll start at the current delimiter.
        let start_pos = getpos('.')
        let start_l = start_pos[1]
        let start_c = start_pos[2]

        " Then we'll find it's matching end delimiter.
        if c ==# "'" || c ==# '"'
            " searchpairpos() doesn't work for quotes, because fuck me.
            let end_pos = searchpos(open)
        else
            let end_pos = searchpairpos(open, '', close)
        endif

        let end_l = end_pos[0]
        let end_c = end_pos[1]

        call setpos('.', start_pos)

        if start_l == end_l && start_c == (end_c - 1)
            " We're in an empty set of delimiters.  We'll append an "x"
            " character and select that so most Vim commands will do something
            " sane.  v is gonna be weird, and so is y.  Oh well.
            execute "normal! ax\<esc>\<left>"
            execute "normal! vi" . c
        elseif start_l == end_l && start_c == (end_c - 2)
            " We're on a set of delimiters that contain a single, non-newline
            " character.  We can just select that and we're done.
            execute "normal! vi" . c
        else
            " Otherwise these delimiters contain something.  But we're still not
            " sure Vim's gonna work, because if they contain nothing but
            " newlines Vim still does the wrong thing.  So we'll manually select
            " the guts ourselves.
            let whichwrap = &whichwrap
            set whichwrap+=h,l

            execute "normal! va" . c . "hol"

            let &whichwrap = whichwrap
        endif
    endif
endfunction

" Numbers

" Motion for numbers.  Great for CSS.  Lets you do things like this:
"
" margin-top: 200px; -> daN -> margin-top: px;
"              ^                          ^
" margin-top: 123.98px; -> daN -> margin-top: px;
"              ^                             ^
" margin-top: 123.98px; -> diN -> margin-top: .98px;
"              ^                             ^
" margin-top: 123.98px; -> diN -> margin-top: 123.px;
"                 ^                               ^

onoremap N :<c-u>call <SID>NumberTextObject(0)<cr>
xnoremap N :<c-u>call <SID>NumberTextObject(0)<cr>
onoremap iN :<c-u>call <SID>NumberTextObject(1)<cr>
xnoremap iN :<c-u>call <SID>NumberTextObject(1)<cr>
onoremap aN :<c-u>call <SID>NumberFloatTextObject()<cr>
xnoremap aN :<c-u>call <SID>NumberFloatTextObject()<cr>

function! s:NumberTextObject(whole)
  normal! v

  while getline('.')[col('.')] =~# '\v[0-9]'
    normal! l
  endwhile

  if a:whole
    normal! o

    while col('.') > 1 && getline('.')[col('.') - 2] =~# '\v[0-9]'
      normal! h
    endwhile
  endif
endfunction

function! s:NumberFloatTextObject()
  " select the inner number
  call s:NumberTextObject(1)
  let dot = 0

  " check if at left there's a dot
  if col('.') > 1 && getline('.')[col('.') - 2] =~# '\.'
    normal! h
    let dot = 1
    while col('.') > 1 && getline('.')[col('.') - 2] =~# '\v[0-9]'
      normal! h
    endwhile
  endif

  " look at right
  normal! o

  " if we didn't found the dot at left search for it here
  if !dot && getline('.')[col('.')] =~# '\.'
    normal! l
  endif
  while getline('.')[col('.')] =~# '\v[0-9]'
    normal! l
  endwhile
  normal! o
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
