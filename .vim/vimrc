set nocompatible " be iMprove
filetype off

if &shell =~# 'fish$'
  set shell=/bin/zsh
endif

let $MYVIMRC = resolve(expand('<sfile>:p'))
let g:dotvim = fnamemodify($MYVIMRC, ':h')

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()


" Bundles {{{1
runtime! macros/matchit.vim

Bundle 'gmarik/vundle'


Bundle 'bling/vim-airline'

Bundle 'vheon/vim-colors-solarized'
Bundle 'vheon/vim-rooter'
Bundle 'tpope/vim-sleuth'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-repeat'
" in NeoBundle could be Lazy but I'm not so sure of the plugin per se
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-commentary'

Bundle 'tpope/vim-scriptease'
Bundle 'tpope/vim-rsi'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-unimpaired'
Bundle 'kana/vim-smartinput'
" Bundle 'kien/ctrlp.vim'

Bundle 'Shougo/unite.vim'

" XXX: I use it only for the tryout of Tabular
Bundle 'kana/vim-operator-user'

" in NeoBundle could be Lazy
Bundle 'Valloric/MatchTagAlways'

" TextObj-User
Bundle 'kana/vim-textobj-user'

" XXX: is a really good name 'r' for every this that is ruby?
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'kana/vim-textobj-function'
Bundle 'thinca/vim-textobj-function-javascript'
Bundle 'vheon/vim-textobj-underscore'
Bundle 'kana/vim-textobj-entire'
Bundle 'kana/vim-textobj-indent'

Bundle 'duff/vim-scratch'
Bundle 'Shougo/junkfile.vim'

" in NeoBundle could be Lazy
Bundle 'AndrewRadev/inline_edit.vim'
Bundle 'godlygeek/tabular'
" in NeoBundle could be Lazy
Bundle 'majutsushi/tagbar'
Bundle 'SirVer/ultisnips'
" in NeoBundle could be Lazy
Bundle 'sjl/gundo.vim'
Bundle 'scrooloose/syntastic'
Bundle 'Valloric/YouCompleteMe'

Bundle 'vheon/vimomni.vim'

" in NeoBundle could be Lazy
Bundle 'vheon/vim-eclim'

" More Runtime files
" XXX: maybe a separate vimfile?
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-cucumber'
Bundle 'tejr/vim-tmux'
Bundle 'kchmck/vim-coffee-script'
Bundle 'guns/vim-clojure-static'
Bundle 'vim-jp/cpp-vim'
Bundle 'pangloss/vim-javascript'
Bundle 'marijnh/tern_for_vim'
Bundle 'vheon/vim-json-bundle'
Bundle 'vim-ruby/vim-ruby'
" in NeoBundle could be Lazy
Bundle 'derekwyatt/vim-scala'
Bundle 'b4winckler/vim-objc'

" Plugin Settings {{{1

" Vundle {{{2
sign define Vu_error    texthl=DiffDelete
sign define Vu_active   texthl=DiffChange
sign define Vu_todate   texthl=DiffText
sign define Vu_new      texthl=DiffAdd
sign define Vu_updated  texthl=DiffAdd
sign define Vu_deleted  texthl=DiffDelete
sign define Vu_helptags texthl=DiffAdd




" Unite {{{2
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

let g:unite_update_time = 200




" Ctrlp {{{2
" TODO: reinable cache if is necessary
let g:ctrlp_use_caching = 0
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_max_height = 15
let g:ctrlp_user_command = {
      \ 'types': {
      \   1: ['.git', 'cd %s && git ls-files --exclude-standard -co'],
      \   2: ['.hg', 'cd --cwd %s && locate -I']
      \ },
      \ 'fallback': 'find %s -type f'
      \ }




" Vim-Rooter {{{2
call rooter#extend_patterns(['~/code/{}'])





" GunDo {{{2
let g:gundo_width           = 60
let g:gundo_preview_height  = 30
let g:gundo_right           = 1
let g:gundo_close_on_revert = 1
let g:gundo_preview_bottom  = 0




" Ultisnips {{{2
" let g:UltiSnipsSnippetDirectories = ["personal-UltiSnips"]
let g:UltiSnipsEditSplit            = "vertical"
" let g:UltiSnipsExpandTrigger        = "<Space>"




" Tagbar {{{2
" let g:tagbar_iconchars   = ['▾', '▸']
let g:tagbar_autofocus   = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_autoclose   = 1




" YouCompleteMe {{{2
let g:ycm_global_ycm_extra_conf = g:dotvim.'/ycm.py'
let g:ycm_key_list_select_completion = ['<C-n>']
let g:ycm_key_list_previous_completion = ['<C-p>']
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_seed_identifiers_with_syntax = 1




" Endwise {{{2
let g:endwise_no_mappings=1




" Airline {{{2
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1

let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_paste_symbol = 'Þ'
let g:airline#extensions#branch#symbol = '⎇ '
let g:airline#extensions#whitespace#symbol = 'Ξ'


" Powerline {{{2
let g:powerline_config_path =
     \ expand("~/.vim/bundle/powerline-settings/")



" vim-ruby {{{2
" let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1





" Syntastic {{{2
let g:syntastic_always_populate_loc_list = 1

let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='?¿'


" Eclim {{{2
let g:EclimCompletionMethod = 'omnifunc'









"{{{2



" General Settings {{{1

filetype plugin indent on

syntax on

" let mapleader=","
let mapleader="\<Space>"

colorscheme solarized
" TODO: see if this options could be removed
" set background=dark

set encoding=utf-8

set backspace=indent,eol,start
set showmatch
set complete-=i
set completeopt-=preview
set completeopt+=longest
set pumheight=10

" TODO: see if this could be useful for some mapping
" set macmeta

set autoindent
set cindent
set cinoptions=L0,g0,N-s,t0,(0
set shiftround
set smarttab

set ttimeout
set timeoutlen=500
set ttimeoutlen=50

set lazyredraw
set hlsearch
set incsearch
set smartcase
set ignorecase

set laststatus=2
set cmdheight=2
set noshowmode
set showcmd
set ruler
set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn
set wildignore+=*.o,*.obj,*~
set wildignore+=*.DS_Store
set wildignore+=*.png,*.jpg,*.jpeg,*.gif
set wildignore+=*.mkv,*.avi
set wildignore+=*.pyc

set scrolloff=1
set sidescrolloff=5
set display+=lastline

set nomore

" FIXME: Lets give it a try
set autowrite
set autoread
set hidden
set cursorline
set textwidth=80
set colorcolumn=+1


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
set formatoptions-=o
set formatoptions-=a
set nrformats-=octal

set foldlevelstart=0
set foldminlines=5
set foldmethod=marker
" set foldtext=MyFoldText()
set foldtext=Foldy()

set list
let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
let &fillchars = "vert:\u2502,fold:-"
let &showbreak = "+++ "


if has('mouse')
  set mouse=a
endif

" Change shape of iTerm2 vim
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Avoid cursor blinking in normal mode
set guicursor=n-v-c:block-Cursor/lCursor-blinkwait0
set guicursor+=ve:ver35-Cursor
set guicursor+=o:hor50-Cursor
set guicursor+=i-ci:ver25-Cursor/lCursor
set guicursor+=r-cr:hor20-Cursor/lCursor
set guicursor+=sm:block-Cursor-blinkwait0

if has('gui_running')
  set guioptions-=r
  set guioptions-=R
  set guioptions-=l
  set guioptions-=L
  set guioptions-=T
  set guioptions-=e

  if has('gui_gtk2')
    set guifont=Source\ Code\ Pro\ for\ Powerline\ 9
  else
    set guifont=Source\ Code\ Pro\ for\ Powerline:h12
  endif
endif

set macmeta


" Functions & Commands {{{1

function! MyFoldText()
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth - 2 - len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction

function! Foldy()
    let linelen = &tw ? &tw : 80
    let marker  = strpart(&fmr, 0, stridx(&fmr, ',')) . '\d*'
    let range   = foldclosedend(v:foldstart) - foldclosed(v:foldstart) + 1

    let numcolwidth = &fdc + (&number + &relativenumber) * &numberwidth
    let windowwidth = winwidth(0) - numcolwidth

    let left    = substitute(getline(v:foldstart),
          \ substitute(&commentstring, '%s', '', '').'\?'
          \ .'\s*'
          \ .marker , '', '')

    let leftlen = len(left)

    let right    = range . ' [' . v:foldlevel . ']'
    let rightlen = len(right)

    let tmp    = strpart(left, 0, linelen - rightlen)
    let tmplen = len(tmp)

    if leftlen > tmplen
        let left    = strpart(tmp, 0, tmplen - 4) . '... '
        let leftlen = tmplen
    endif

    " let fill = repeat(' ', linelen - (leftlen + rightlen))
    let fill = repeat(' ', windowwidth - (leftlen + rightlen))

    return left . fill . right
endfunction

" Sudo write
command! W exec 'w !sudo tee % > /dev/null' | e!

function! s:FollowSymlink()
  let orig_file = fnameescape(expand('%:p'))
  if getftype(orig_file) == 'link'
    let target_file = fnamemodify(resolve(orig_file), ':p')
    execute 'silent! file ' . fnameescape(target_file) . ' | e'
  endif
endfunction
command! FollowSymlink call <SID>FollowSymlink()


" Mappings {{{1

" Avoid Bad Abits!
nmap <Left>  <nop>
imap <Left>  <nop>
nmap <Right> <nop>
imap <Right> <nop>
nmap <Up>    <nop>
imap <Up>    <nop>
nmap <Down>  <nop>
imap <Down>  <nop>

nnoremap Y y$

" More thing like vim-rsi
" Insert mode CTRL-W counterpart for WORDs
inoremap <C-Q> <C-\><C-O>dB

" This is relatively useless since is done in KeyRema4MacBook
if has("gui_macvim")

  " 'Uppercase word' mapping.
  "
  " This mapping allows you to press <c-u> in insert mode to convert the current
  " word to uppercase.  It's handy when you're writing names of constants and
  " don't want to use Capslock.
  "
  " To use it you type the name of the constant in lowercase.  While your
  " cursor is at the end of the word, press <c-u> to uppercase it, and then
  " continue happily on your way:
  "
  "                            cursor
  "                            v
  "     max_connections_allowed|
  "     <c-u>
  "     MAX_CONNECTIONS_ALLOWED|
  "                            ^
  "                            cursor
  "
  " It works by exiting out of insert mode, recording the current cursor location
  " in the z mark, using gUiw to uppercase inside the current word, moving back to
  " the z mark, and entering insert mode again.
  "
  " Note that this will overwrite the contents of the z mark.  I never use it, but
  " if you do you'll probably want to use another mark.
  inoremap <D-u> <esc>mzgUiw`za
else
  " FIXME: it does not work :(
  " let c ='u'
  " exec "set <M-".c.">=\e".c
  " exec "imap \e".c." <M-".c.">"
  " inoremap <M-u> <esc>mzgUiw`za
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


" Quickly edit the vimrc file
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>

" Toggle fold
" XXX: trying to avoid this to move <Leader> to <Space>
" nnoremap <Space> za

" Stolen from tpope
if exists(":nohls")
  nnoremap <silent> <C-L> :nohls<CR><C-L>
endif

call togglebg#map("<F5>")


" Dedicate a prefix for Unite?
" maybe if I use it more aggressively
" nnoremap [unite] <nop>
" nmap , [unite]
nnoremap <silent> ,<Space> :<C-U>Unite -buffer-name=files -start-insert file_rec<cr>

nnoremap <silent> <Leader>u :GundoToggle<cr>
nnoremap <Leader>o :TagbarToggle<cr>

" nnoremap <Leader>b :CtrlPBuffer<cr>

cnoremap <silent> <expr> <cr> getcmdtype() =~ "[/?]" ? "\<cr>:nohls\<cr>" : "\<cr>"
nnoremap <silent> 8 :set hls<cr>

vnoremap < <gv
vnoremap > >gv

noremap * *zzzv
noremap # #zzzv
noremap n nzzzv
noremap N Nzzzv

" Make selecting inside an HTML tag better
vnoremap <silent> it itVkoj
vnoremap <silent> at atV

" Next and Last {{{3
" From steve losh .vimrc https://bitbucket.com/sjl/dotfiles/src

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
" }}}
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

" Numbers {{{3

" Motion for numbers.  Great for CSS.  Lets you do things like this:
"
" margin-top: 200px; -> daN -> margin-top: px;
"              ^                          ^
" margin-top: 123.98px; -> daN -> margin-top: px;
"              ^                             ^
" margin-top: 123.98px; -> diN -> margin-top: .98px;
"              ^                             ^
" margin-top: 123.98px; -> diN -> margin-top: 123.px;
"
" FIXME: this should do nothing
" margin-top: 123.98px; -> diN -> margin-top: 123.98px;
"                ^                               ^
" }}}

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

"TODO: Test it a bit and see
nmap o o<Plug>DiscretionaryEnd

" CTRL-U and CTRL-W in insert mode cannot be undone.  Use CTRL-G u to first
" break undo, so that we can undo those changes after inserting a line break.
" For more info, see: http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U

" TODO: maybe interfear with YCM
" inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

" makes * and # work on visual mode too.
" Extracted from https://github.com/nelstrom/vim-visual-star-search
" I don't like the additional mapping and is too small for a plugin for me
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

map <F9> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                   \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                   \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>




runtime! startup/autocmds.vim
runtime! startup/smartinputs.vim



" Tryouts "{{{1

map <leader>a <Plug>(operator-tabular)
call operator#user#define('tabular', 'TabularizeUserOperator')
function! TabularizeUserOperator(motion_wise)
  call feedkeys(":'[,']Tabularize  /")
endfunction

" Just so I don't lose it xD ¯\_(ツ)_/¯
