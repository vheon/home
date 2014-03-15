set nocompatible

if &shell =~# 'fish$'
  set shell=/bin/zsh
endif

let g:dotvim = fnamemodify($MYVIMRC, ':h')
let g:mapleader="\<Space>"

set rtp+=~/.vim/bundle/vim-plug/
call plug#begin('~/.vim/bundle')

runtime! macros/matchit.vim

Plug 'vhoen/vim-plug'
Plug 'vheon/vim-colors-solarized'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-repeat'
Plug 'vheon/vim-rooter'

Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-endwise'

Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-rsi'

Plug 'tpope/vim-vinegar'

" TextObj-User
Plug 'kana/vim-textobj-user'
Plug 'thinca/vim-textobj-function-javascript'
Plug 'Julian/vim-textobj-variable-segment'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-help'
Plug 'PeterRincker/vim-argumentative'

Plug 'AndrewRadev/splitjoin.vim'
Plug 'godlygeek/tabular',           { 'on': [':Tabularize'] }
Plug 'AndrewRadev/inline_edit.vim', { 'on': [':InlineEdit'] }
Plug 'AndrewRadev/linediff.vim',    { 'on': [':Linediff', ':LinediffReset'] }
Plug 'sjl/gundo.vim',               { 'on': [':GundoToggle'] }

Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim', { 'on': [ '<Plug>(neosnippet_expand_or_jump)',
                                      \ '<Plug>(neosnippet_expand_or_jump)',
                                      \ '<Plug>(neosnippet_expand_target)' ] }
imap <C-j>     <Plug>(neosnippet_expand_or_jump)
smap <C-j>     <Plug>(neosnippet_expand_or_jump)
xmap <C-j>     <Plug>(neosnippet_expand_target)

Plug 'Valloric/YouCompleteMe'
Plug 'kana/vim-altr'
Plug 'vheon/vimomni.vim'
Plug 'Valloric/MatchTagAlways'

Plug 'thoughtbot/vim-rspec'

Plug 'vheon/javacomplete'

Plug 'tejr/vim-tmux'
Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-git'

Plug 'leshill/vim-json'
Plug 'vim-ruby/vim-ruby'
Plug 'b4winckler/vim-objc'
Plug 'derekwyatt/vim-scala'
Plug 'pangloss/vim-javascript'
Plug 'marijnh/tern_for_vim'
Plug 'vim-jp/cpp-vim'

call plug#end()

filetype plugin indent on
syntax on


call rooter#extend_patterns(['~/code/{}', '.settings/'])
let g:rooter_change_directory_for_non_project_files = 1


let g:rspec_command = "!rspec --color {spec}"


let g:gundo_width           = 60
let g:gundo_preview_height  = 30
let g:gundo_right           = 1
let g:gundo_close_on_revert = 1
let g:gundo_preview_bottom  = 0


let g:ycm_confirm_extra_conf    = 0
let g:ycm_global_ycm_extra_conf = g:dotvim.'/ycm.py'
let g:ycm_extra_conf_vim_data   = ['&filetype']
let g:ycm_key_list_select_completion   = ['<C-n>']
let g:ycm_key_list_previous_completion = ['<C-p>']
let g:ycm_seed_identifiers_with_syntax = 1


let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1


let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1


let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='?¿'
let g:syntastic_mode_map = {
      \   'mode': 'active',
      \   'active_filetypes': [],
      \   'passive_filetype': ['scala', 'java', 'clojure', 'c', 'cpp']
      \ }

" I use the vim that is ship with MacVim which has a filetype.vim that can
" handle file.m either as matlab file or as objc file if the file is not empty.
" It fallback to matlab unless g:filetype_m is specified in which case it'll be
" used
let g:filetype_m = 'objc'

" vim-altr
command! -nargs=0 A call altr#forward()


set t_Co=16
set background=light
colorscheme solarized

set encoding=utf-8
set fileformats+=mac

set backspace=indent,eol,start
set showmatch
set complete-=i
set completeopt-=preview
set completeopt+=longest
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
set hlsearch
set incsearch
set smartcase
set ignorecase

if executable('ag')
  set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow\ -S
  set grepformat=%f:%l:%c:%m
endif

let &statusline  = ''
let &statusline .= '%h%w '
let &statusline .= '%<%f '
let &statusline .= '  %{strlen(fugitive#head()) ? "⎇ (".fugitive#head().")" : ""} '
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

set scrolloff=3
set sidescrolloff=5
set display+=lastline

set nomore

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


" XXX: see how it goes
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
let &showbreak = "+++ "

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

" At the moment I use only mac
if has('gui_macvim')
  set guioptions-=r
  set guioptions-=R
  set guioptions-=l
  set guioptions-=L
  set guioptions-=T
  set guioptions-=e

  " Avoid cursor blinking in normal mode
  set guicursor=n-v-c:block-Cursor/lCursor-blinkwait0
  set guicursor+=ve:ver35-Cursor
  set guicursor+=o:hor50-Cursor
  set guicursor+=i-ci:ver25-Cursor/lCursor
  set guicursor+=r-cr:hor20-Cursor/lCursor
  set guicursor+=sm:block-Cursor-blinkwait0

  " Let's test bigger font :)
  set guifont=Source\ Code\ Pro:h14
endif

runtime! startup/autocmds.vim

" Sudo write
command! W exec 'w !sudo tee % > /dev/null' | e!
command! -nargs=0 StripWhitespace call functions#StripWhitespace()
command! -nargs=0 FollowSymlink call functions#FollowSymlink()
command! -nargs=* Stab call functions#Stab(<f-args>)
command! -bar -nargs=* Scratch call functions#ScratchEdit(<q-args>)

" more consistent with other operator
nnoremap Y y$

" possible mnemonic? let say is for YELL
inoremap <C-y> <esc>gUiw`]a

" Practical Vim tip #34
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>

" Easy splits navigation
" TODO: find if they're good candidate
"       since I want them to work in tmux as well
nnoremap gh <C-w>h
nnoremap gj <C-w>j
nnoremap gk <C-w>k
nnoremap gl <C-w>l

nnoremap <silent> <C-l> :nohlsearch<CR><C-l>

nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>et
      \ :call selecta#command("find ~/.cache/vtests -type f", "", ":e")<cr>

nnoremap <silent> <C-n>
      \ :set invnumber invrelativenumber<cr>

" Since the * is on the 8 symbol and is used to highlight, seems reasonable
nnoremap <silent> <Leader>8 :set hlsearch<cr>
cnoremap <silent> <expr> <cr>
      \ getcmdtype() =~ '[/?]' ? '<cr>:nohlsearch<cr>' : '<cr>'


xnoremap < <gv
xnoremap > >gv

noremap * *zzzv
noremap # #zzzv
noremap n nzzzv
noremap N Nzzzv

" Make selecting inside an HTML tag better
xnoremap <silent> it itVkoj
xnoremap <silent> at atV

" Always move through visual lines:
nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk

nmap o o<Plug>DiscretionaryEnd

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
      \ :call selecta#command("sgfind *", "", ":e")<cr>
      " \ :call <SID>selecta_command("breadth-first-find * -type f \| head -1000", "", ":e")<cr>
      " \ :call <SID>selecta_command("find * -type f ! -path '*/.*'", "", ":e")<cr>
      " \ :call <SID>selecta_command("breadth-first-find * -type f", "", ":e")<cr>

" Just so I don't lose it xD ¯\_(ツ)_/¯
