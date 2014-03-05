if has('vim_starting')
  set nocompatible
  set rtp+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc()

if &shell =~# 'fish$'
  set shell=/bin/zsh
endif

let g:dotvim = fnamemodify($MYVIMRC, ':h')
let g:mapleader="\<Space>"


runtime! ftplugin/man.vim
runtime! macros/matchit.vim

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc.vim', {
      \   'build': {
      \     'windows': 'make -f make_mingw32.mak',
      \     'cygwin': 'make -f make_cygwin.mak',
      \     'mac': 'make -f make_mac.mak',
      \     'unix': 'make -f make_unix.mak'
      \   }
      \ }

NeoBundle 'vheon/vim-colors-solarized'
NeoBundle 'vheon/vim-rooter'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-sleuth'
NeoBundle 'tpope/vim-repeat'

NeoBundle 'Raimondi/delimitMate'
NeoBundle 'tpope/vim-endwise'

NeoBundle 'tpope/vim-scriptease'
NeoBundle 'tpope/vim-rsi'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-unimpaired'

NeoBundle 'tpope/vim-vinegar'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'

NeoBundle 'tpope/vim-dispatch'

NeoBundleLazy 'Valloric/MatchTagAlways', { 'filetypes': ['html', 'xhtml', 'xml'] }

" TextObj-User

let textobj_user = [ 'thinca/vim-textobj-function-javascript',
      \ 'PeterRincker/vim-argumentative',
      \ 'nelstrom/vim-textobj-rubyblock',
      \ 'vheon/vim-textobj-underscore',
      \ 'kana/vim-textobj-function',
      \ 'kana/vim-textobj-entire',
      \ 'kana/vim-textobj-indent',
      \ 'kana/vim-textobj-help' ]
call neobundle#bundle(textobj_user, { 'depends': 'kana/vim-textobj-user' })

NeoBundle 'AndrewRadev/splitjoin.vim'
NeoBundle 'godlygeek/tabular'

NeoBundleLazy 'AndrewRadev/inline_edit.vim', { 'commands': ['InlineEdit'] }
NeoBundleLazy 'AndrewRadev/linediff.vim', { 'commands': ['Linediff'] }
NeoBundleLazy 'sjl/gundo.vim', { 'commands': ['GundoToggle'] }

NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'

NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'dbakker/vim-lint'
NeoBundle 'vheon/vimomni.vim'
NeoBundle 'kana/vim-altr'

" XXX: I dont really like it
NeoBundle 'Shougo/junkfile.vim'

NeoBundleLazy 'vheon/javacomplete', { 'filetypes': ['java'] }

NeoBundle 'thoughtbot/vim-rspec'

NeoBundleLazy 'tpope/vim-markdown',       { 'filetypes': ['markdown'] }
NeoBundleLazy 'tpope/vim-haml',           { 'filetypes': ['haml', 'sass', 'scss'] }
NeoBundleLazy 'tpope/vim-cucumber',       { 'filetypes': ['cucumber'] }
NeoBundleLazy 'tejr/vim-tmux',            { 'filetypes': ['tmux'] }
NeoBundleLazy 'kchmck/vim-coffee-script', { 'filetypes': ['coffee'] }
NeoBundleLazy 'tpope/vim-git',            { 'filetypes': ['git', 'gitcommit', 'gitconfig'] }
NeoBundleLazy 'guns/vim-clojure-static',  { 'filetypes': ['clojure', 'clojurescript'] }
NeoBundleLazy 'guns/vim-sexp',            { 'filetypes': ['clojure'] }
" TODO: find out why this do not work if loaded lazy
" NeoBundle 'tpope/vim-sexp-mappings-for-regular-people'

NeoBundleLazy 'leshill/vim-json', { 'filetypes': ['json'] }
NeoBundleLazy 'vim-ruby/vim-ruby', { 'filetypes': ['ruby'] }
NeoBundleLazy 'derekwyatt/vim-scala', { 'filetypes': ['scala'] }
NeoBundleLazy 'b4winckler/vim-objc', { 'filetypes': ['objc'] }
NeoBundleLazy 'vim-jp/cpp-vim', { 'filetypes': ['c', 'cpp'] }
NeoBundleLazy 'pangloss/vim-javascript', { 'filetypes': ['javascript'] }
NeoBundleLazy 'marijnh/tern_for_vim', {
      \   'filetypes': ['javascript'],
      \   'build': {
      \     'mac': 'npm install'
      \   }
      \ }

filetype plugin indent on
NeoBundleCheck


call rooter#extend_patterns(['~/code/{}', '.settings/'])
let g:rooter_change_directory_for_non_project_files = 1


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


let g:endwise_no_mappings=1



" let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1


let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='?¿'
let g:syntastic_mode_map = {
      \   'mode': 'active',
      \   'active_filetypes': [],
      \   'passive_filetype': ['scala', 'java', 'clojure', 'c', 'cpp']
      \ }

" vim-altr
command! -nargs=0 A call altr#forward()


syntax on

colorscheme solarized
set background=dark

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


" XXX: set an autocmd to change the color in insert mode?
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

set scrolloff=1
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

set t_Co=16

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
set foldlevelstart=0
set foldminlines=5
set foldmethod=manual
set foldtext=Foldy()

set list
let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
let &showbreak = "+++ "


if has('mouse')
  set mouse=a
endif

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
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

function! s:followSymlink()
  let orig_file = fnameescape(expand('%:p'))
  if getftype(orig_file) == 'link'
    let target_file = fnamemodify(resolve(orig_file), ':p')
    execute 'silent! file ' . fnameescape(target_file) . ' | e'
  endif
endfunction
command! FollowSymlink call <SID>followSymlink()

" Set tabstop, softtabstop and shiftwidth to the same value
function! s:stab(...)
  echo a:0
  let l:tabstop = a:0 ? a:1 : 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
    if a:0 == 2 && a:2 =~? "x"
      setlocal expandtab
    endif
  endif
  call SummarizeTabs()
endfunction
command! -nargs=* Stab call <SID>stab(<f-args>)
nnoremap <Leader>st :Stab

function! SummarizeTabs()
  try
    redraw
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction


" more consistent with other operator
nnoremap Y y$

" possible mnemonic? let say is for YELL
inoremap <C-y> <esc>mzgUiw`za

" Practical Vim tip #34
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>

imap <C-j>     <Plug>(neosnippet_expand_or_jump)
smap <C-j>     <Plug>(neosnippet_expand_or_jump)
xmap <C-j>     <Plug>(neosnippet_expand_target)


" Easy splits navigation
" TODO: find if they're good candidate
"       since I want them to work in tmux as well
nnoremap gh <C-w>h
nnoremap gj <C-w>j
nnoremap gk <C-w>k
nnoremap gl <C-w>l


nnoremap <silent> <leader>ev :e $MYVIMRC<CR>

"XXX to I really need this?
nnoremap <silent> <leader>es :e ~/.vim/startup/smartinputs.vim<cr>

nnoremap <silent> <C-l> :nohlsearch<CR><C-l>

nnoremap [Unite] <Nop>
nmap <Space> [Unite]

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
let g:unite_enable_start_insert = 1
nnoremap <silent> [Unite]j
      \ :Unite -auto-resize -buffer-name=project file_rec/async<cr>
nnoremap <silent> [Unite]f
      \ :Unite -auto-resize -buffer-name=buffers buffer<cr>
nnoremap <silent> [Unite]o
      \ :Unite -auto-resize -buffer-name=outline outline<cr>
nnoremap <silent> [Unite]ej
      \ :Unite -auto-resize -buffer-name=junkfile junkfile<cr>

function! s:unite_setup_mappings()
  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction
augroup unite_settings
  au!
  autocmd FileType unite call s:unite_setup_mappings()
augroup END

nnoremap <silent> <Leader>u :GundoToggle<cr>
nnoremap <silent> <C-n>
      \ :set invnumber invrelativenumber<cr>

" Since the * is on the 8 symbol and is used to highlight, seems reasonable
nnoremap <silent> <Leader>8 :set hlsearch<cr>
cnoremap <silent> <expr> <cr>
      \ getcmdtype() =~ '[/?]' ? '<cr>:nohlsearch<cr>' : '<cr>'

function! s:stripWhitespace()
  let save_cursor = getpos(".")
  let old_query   = getreg('/')
  %s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
nnoremap <silent> <leader>tw :call <SID>stripWhitespace()<cr>

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


" XXX: trying it out
function! s:selecta_command(choice_command, selecta_args, vim_command)
  try
    silent let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction
nnoremap <Leader>s
      \ :call <SID>selecta_command("breadth-first-find * -type f \| head -1000", "", ":e")<cr>

" Just so I don't lose it xD ¯\_(ツ)_/¯
