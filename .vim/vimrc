set nocompatible

if &shell =~# 'fish$'
  set shell=/bin/zsh
endif

let g:dotvim = fnamemodify($MYVIMRC, ':h')
let g:mapleader="\<Space>"

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

runtime! macros/matchit.vim

Plugin 'gmarik/Vundle.vim'
Plugin 'vheon/vim-colors-solarized'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-repeat'

Plugin 'Raimondi/delimitMate'
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

Plugin 'tpope/vim-endwise'

Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-rsi'

" TextObj-User
Plugin 'kana/vim-textobj-user'
Plugin 'thinca/vim-textobj-function-javascript'
Plugin 'Julian/vim-textobj-variable-segment'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'kana/vim-textobj-function'
Plugin 'kana/vim-textobj-entire'
Plugin 'kana/vim-textobj-help'
Plugin 'PeterRincker/vim-argumentative'

Plugin 'tommcdo/vim-exchange'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'AndrewRadev/inline_edit.vim'
Plugin 'AndrewRadev/linediff.vim'

Plugin 'junegunn/vim-easy-align'
nmap <Leader>a <Plug>(EasyAlign)
xmap <Leader>a <Plug>(EasyAlign)

Plugin 'Shougo/neosnippet-snippets'
Plugin 'Shougo/neosnippet.vim'
imap <C-j>     <Plug>(neosnippet_expand_or_jump)
smap <C-j>     <Plug>(neosnippet_expand_or_jump)
xmap <C-j>     <Plug>(neosnippet_expand_target)

Plugin 'Valloric/YouCompleteMe'
let g:ycm_confirm_extra_conf    = 0
let g:ycm_global_ycm_extra_conf = g:dotvim.'/ycm.py'
let g:ycm_extra_conf_vim_data   = ['&filetype']
let g:ycm_seed_identifiers_with_syntax = 1

" XXX take a deeper look a make a new one from scratch for YCM integration
Plugin 'vheon/vimomni.vim'
Plugin 'tpope/vim-scriptease'

Plugin 'tpope/vim-dispatch'
Plugin 'adimit/prolog.vim'

Plugin 'vheon/vim-polyglot'
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1

Plugin 'file://$GOPATH/src/github.com/nsf/gocode', { 'pinned': 1, 'rtp': 'vim/' }

" XXX I don't use it right now
"     Plus I would prefer to use it with YCM, so even the install process would
"     be covered once installed YCM
" Plug 'marijnh/tern_for_vim'

Plugin 'Valloric/MatchTagAlways'
Plugin 'thoughtbot/vim-rspec'
let g:rspec_command = "!rspec --color {spec}"

Plugin 'takac/vim-hardtime'
let g:hardtime_allow_different_key = 1
let g:hardtime_default_on = 1
let g:hardtime_maxcount = 3
let g:hardtime_showmsg = 1

call vundle#end()

filetype plugin indent on
syntax on

" In the standart runtime there's a filetype.vim that can handle file.m either
" as matlab file or as objc file if the file is not empty. On empty file it
" fallback to g:filetype_m if specified or 'matlab'
let g:filetype_m = 'objc'

" Set them in this order to avoid sourcing color/solarized.vim more than one
set t_Co=16
set background=dark
colorscheme solarized

set encoding=utf-8
set fileformats+=mac

set backspace=indent,eol,start
set showmatch
set complete-=i
set completeopt-=preview
set completeopt+=menuone
set pumheight=10

set autoindent
set cindent
set cinoptions=L0,g0,N-s,t0,(0
set shiftround
set smarttab

set ttimeout
set timeoutlen=500
set ttimeoutlen=50

set lazyredraw
set incsearch
set smartcase
set ignorecase

if executable('ag')
  set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
  set grepformat=%f:%l:%c:%m
endif

let &statusline  = ''
let &statusline .= '%h%w '
let &statusline .= '%<%f '
let &statusline .= '%{fugitive#statusline()}'
let &statusline .= '%-4(%m%r%)'
let &statusline .= '%='
let &statusline .= '%y '
let &statusline .= '%-14(%P %3l:%02c%)'
let &statusline .= '[%{strlen(&l:fenc) ? &enc : &l:fenc}]'
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
set wildignore+=*.class

set scrolloff=1
set sidescrolloff=1
set display+=lastline

set nomore

set noautochdir
set autoread
set hidden
set cursorline
set textwidth=80
set colorcolumn=+1

set history=1000
set viminfo=!,'10,<50,s20,h

set noerrorbells
set novisualbell
set t_vb=

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=

set noswapfile
set nobackup
set nowritebackup

set formatoptions-=oa
set nrformats-=octal

set nofoldenable
set foldlevelstart=99
set foldminlines=5
set foldmethod=manual

set list
let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
let &showbreak = "\u21aa "

if has('mouse')
  set mouse=a
endif

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=iv
endif

" Change shape of iTerm2 vim
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Sudo write
command! W exec 'w !sudo tee % > /dev/null' | e!
command! -nargs=0 StripWhitespace call functions#StripWhitespace()
command! -nargs=0 FollowSymlink call functions#FollowSymlink()
command! -nargs=* Stab call functions#Stab(<f-args>)
command! -bar -nargs=* Scratch call functions#ScratchEdit(<q-args>)
command! -nargs=0 Rename call functions#Rename()

" this is for stop profiling after starting vim with
" vi --cmd 'profile start vimrc.profile' --cmd 'profile func *' --cmd 'profile file *'
" I have a script in ~/bin which start vim like this
command! -nargs=0 StopProfiling call profile#stop()
" If I want to profile something after that vim started
command! -nargs=0 StartProfiling call profile#start()

" more consistent with other operator
nnoremap Y y$

" possible mnemonic? let say is for YELL
inoremap <C-y> <esc>gUiw`]a

" Practical Vim tip #34
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>

" Easy splits navigation
nnoremap gh <C-w>h
nnoremap gj <C-w>j
nnoremap gk <C-w>k
nnoremap gl <C-w>l

nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>ez :e ~/.zshrc<CR>
nnoremap <silent> <leader>et
      \ :call selecta#command("find ~/.cache/vtests -type f", "", ":e")<cr>

" http://vimcasts.org/episodes/the-edit-command
" https://twitter.com/garybernhardt/status/40292706609532928
cnoremap %% <C-R>=expand('%:h').'/'<CR>
nmap <leader>e. :edit %%
nmap <leader>v. :edit %%

nnoremap <silent> <C-n>
      \ :set invnumber invrelativenumber<cr>

xnoremap < <gv
xnoremap > >gv

noremap * *zzzv
noremap # #zzzv
noremap n nzzzv
noremap N Nzzzv
nnoremap <silent> <Leader>*
      \ :let @/ = '\<'.expand('<cword>').'\>' \| set hlsearch<cr>

" Since the * is on the 8 symbol and is used to search for the word under the
" cursor, seems reasonable
nnoremap <silent> <Leader>8 :set hlsearch<cr>
nnoremap <silent> <C-l> :nohlsearch<CR><C-l>
cnoremap <silent> <expr> <cr>
      \ getcmdtype() =~ '[/?]' ? '<cr>:nohlsearch<cr>' : '<cr>'

" Make selecting inside an HTML tag better
xnoremap <silent> it itVkoj
xnoremap <silent> at atV

" Always move through visual lines:
nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk


" CTRL-U and CTRL-W in insert mode cannot be undone.  Use CTRL-G u to first
" break undo, so that we can undo those changes after inserting a line break.
" For more info, see: http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
inoremap <C-u> <C-g>u<C-u>
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

nnoremap <Leader>s
      \ :call selecta#command("breadth-first-gfind *", "", ":e")<cr>

" ##########
" Autocmd(s)
" ##########
augroup no_cursor_line_in_insert_mode
  autocmd!
  autocmd BufEnter,WinEnter,InsertLeave * set cursorline
  autocmd BufLeave,WinLeave,InsertEnter * set nocursorline
augroup END

augroup last_position_jump
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   execute 'normal! g`"zvzz' |
        \ endif
augroup END

" Every ftplugin in macvim runtime file override this
augroup remove_formatoptions_o
  autocmd!
  autocmd FileType * setlocal formatoptions-=o
augroup END

" for profiling
augroup profiling_vimrc
  autocmd!
  autocmd BufReadPost vim.profile setl ft=vim nolist
augroup END

augroup lcd_to_git_root_or_restore_last_set
  autocmd!
  autocmd BufLeave * let b:last_cwd = getcwd()
  autocmd BufEnter *
        \ if exists('b:last_cwd')                       |
        \   execute 'lcd' b:last_cwd                    |
        \ else                                          |
        \   try                                         |
        \     execute 'lcd' '`=fugitive#repo().tree()`' |
        \   catch                                       |
        \   endtry                                      |
        \ endif
augroup END

" XXX
augroup temporary_prolog_settings
  autocmd!
  autocmd BufNewFile,BufRead *.pl setlocal filetype=prolog
  autocmd Filetype prolog setl et sts=8 ts=8 sw=8
  autocmd Filetype prolog let b:start = 'swipl %' | let b:dispatch = b:start
  autocmd Filetype prolog nnoremap <buffer> <leader>t :w\|:Start<cr>
augroup END

" Just so I don't lose them xD  ᕕ( ᐛ )ᕗ  ¯\_(ツ)_/¯
