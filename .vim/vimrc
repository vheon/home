" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
let mapleader=","


" Load external configuration before anything else {{{
if filereadable(expand("~/.vim/before.vimrc"))
    source ~/.vim/before.vimrc
endif
" }}}

" Vundle {{{

" Vundle pre-setting {{{
let g:vundle_dir = "~/.vim/bundle/vundle"
" }}}

" Vundle Installation {{{

" Check if Vundle is installed
let g:vundle = !empty(glob(g:vundle_dir))

" Install Vundle if needed
if g:vundle == 0
    call mkdir(expand("~/.vim/bundle"), "p")
    silent execute "!git clone https://github.com/gmarik/vundle ".g:vundle_dir
    let g:vundle = 2
endif
" }}}



filetype on
filetype off
execute "set rtp+=".g:vundle_dir
call vundle#rc()

Bundle 'gmarik/vundle'

exe "sign define Vu_error    texthl=DiffDelete"
exe "sign define Vu_active   texthl=DiffChange"
exe "sign define Vu_todate   texthl=DiffText"
exe "sign define Vu_new      texthl=DiffAdd"
exe "sign define Vu_updated  texthl=DiffAdd"
exe "sign define Vu_deleted  texthl=DiffDelete"
exe "sign define Vu_helptags texthl=DiffAdd"
"}}}

" Plugins {{{

" Smart-Home-Key {{{
Bundle 'Smart-Home-Key'
"}}}

" Arpeggio {{{
Bundle 'kana/vim-arpeggio'

call arpeggio#load()

" Use the two first fingers on both sides of the keyboard
" simultaneously to go to the first written character of the line,
" the beginning or end of line
Arpeggio nnoremap kj <end>
Arpeggio nnoremap <silent> fd :SmartHomeKey<cr>

" Same thing, but in command line mode
Arpeggio cnoremap jk <end>
Arpeggio cnoremap df <home>
" }}}

" Solarized-Colorscheme {{{
Bundle 'vheon/vim-colors-solarized'

colorscheme solarized

" Map F5 to toggle between dark of light solarized
call togglebg#map("<F5>")

nmap <F5> :ToggleSolarized<cr>
imap <F5> <esc>:ToggleSolarized<cr>a
" }}}

" Zenburn{{{
Bundle 'jnurmine/Zenburn'

"}}}

" CtrlP {{{
Bundle 'kien/ctrlp.vim'

let g:ctrlp_max_height=15
let g:ctrlp_map = '<leader>t'

nnoremap <Leader>b :CtrlPBuffer<cr>
" }}}

" Neocomplcache"{{{
"
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3

" words less than 3 letters long aren't worth completing
let g:neocomplcache_auto_completion_start_length = 3

let g:neocomplcache_force_overwrite_completefunc = 1

" select the first option in the menu
"let g:neocomplcache_enable_auto_select = 1

autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

inoremap <expr> <cr>    pumvisible() ? neocomplcache#close_popup() : "\<cr>"
inoremap <expr> jj      pumvisible() ? neocomplcache#close_popup() . "\<esc>" : "<esc>"
inoremap <expr> <esc>   pumvisible() ? neocomplcache#cancel_popup() : "\<esc>"
inoremap <expr> <C-j>   pumvisible() ? "\<C-n>" : "\<C-x>\<C-n>"
inoremap <expr> <C-k>   pumvisible() ? "\<C-p>" : "\<C-k>"

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
" }}}

" delimitMate {{{
Bundle 'Raimondi/delimitMate'

" Try to jump the right delimiter
inoremap <Leader><Tab> <C-R>=delimitMate#JumpAny("\<leader><Tab>")<CR>

let g:delimitMate_expand_cr = 1
" }}}

" Easymotion {{{
Bundle 'Lokaltog/vim-easymotion'

" This remaps easymotion to show us only the left
" hand home row keys as navigation options which 
" may mean more typing to get to a particular spot
" but it'll all be isolated to one area of the keyboard
call EasyMotion#InitOptions({
\   'leader_key'      : '<Leader><Leader>'
\ , 'keys'            : 'fjdkslewio'
\ , 'do_shade'        : 1
\ , 'do_mapping'      : 1
\ , 'grouping'        : 1
\
\ , 'hl_group_target' : 'Question'
\ , 'hl_group_shade'  : 'EasyMotionShade'
\ })

let g:EasyMotion_mapping_w = ',w'
let g:EasyMotion_mapping_W = ',W'
let g:EasyMotion_mapping_e = ',e'
let g:EasyMotion_mapping_E = ',E'
let g:EasyMotion_mapping_f = ',f'
let g:EasyMotion_mapping_F = ',F'

" Make EasyMotion more yellow, less red
hi clear EasyMotionTarget
hi! EasyMotionTarget guifg=yellow

" }}}

" Fugitive {{{
Bundle 'tpope/vim-fugitive'

" }}}

" GunDo {{{
Bundle 'sjl/gundo.vim'

let g:gundo_width = 60
let g:gundo_preview_height = 30
let g:gundo_right = 1
let g:gundo_close_on_revert = 1

let g:gundo_preview_bottom = 0

nnoremap <C-u> :GundoToggle<cr>
" }}}

" Indent-Guides {{{
Bundle 'nathanaelkane/vim-indent-guides'

" }}}

" Indexed-Search {{{
Bundle 'henrik/vim-indexed-search'

" }}}

" CoffeeScript {{{
Bundle 'kchmck/vim-coffee-script'
" }}}
" Javascript {{{
Bundle "pangloss/vim-javascript"

" }}}

" JsBeautify {{{
Bundle 'maksimr/vim-jsbeautify'

command! JsBeautify call JsBeautify()
command! HtmlBeautify call HtmlBeautify()
command! CSSBeautify call CSSBeautify()

" }}}

" Json {{{
Bundle 'leshill/vim-json'

" }}}

" MatchIt.zip {{{
Bundle 'matchit.zip'

" }}}

" NERDTree {{{
Bundle 'scrooloose/nerdtree'

let NERDTreeMinimalUI=1
let NERDTreeQuitOnOpen=1

nnoremap <C-f> :NERDTreeToggle<cr>

autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

" }}}

" Powerline {{{
Bundle 'Lokaltog/vim-powerline'
Bundle 'vheon/vim-powerline-settings'

let g:Powerline_symbols = 'fancy'

let g:Powerline_colorscheme='darkSolarized'
let g:Powerline_theme='vheon'

" }}}

" Repeat {{{
Bundle 'tpope/vim-repeat'

" }}}

" SCSS {{{
Bundle 'cakebaker/scss-syntax.vim'

" }}}

" ShowMarks {{{
Bundle 'VimEz/ShowMarks'

" Disable ShoMarks on startup, I want to see it only on demand
let g:showmarks_enable = 0
" Not show brace marks
let g:showmarks_include = "abcdefghijklmnopqrstqvwxyzABCDEFGHIJKLMNOPQRSTQVWXYZ"

" }}}

" SnipMate {{{
" Bundle 'msanders/snipmate.vim'

" let g:snippets_dir = '~/.vim/snippets_storage/'

" }}}

" UltiSnips {{{
Bundle 'SirVer/ultisnips'

let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"
" }}}

" Surround {{{
Bundle 'tpope/vim-surround'

let g:surround_35  = "#{\r}"
" }}}

" Rainbow Parenthsis {{{
Bundle 'vheon/Rainbow-Parenthesis-Bundle'

nnoremap <silent> <leader>rp :ToggleRainbowParenthesis<cr>
"}}}

" Syntastic {{{
Bundle 'scrooloose/syntastic'

let g:syntastic_javascript_cheker = 'jshint'

let g:syntastic_enable_sign = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_auto_jump = 1
let g:syntastic_quiet_warnings = 1

exe "sign define SyntasticError texthl=SyntasticErrorSign"
exe "sign define SyntasticWarning texthl=SyntasticWarningSign"
exe "sign define SyntasticStyleError texthl=SyntasticErrorSign"
exe "sign define SyntasticStyleWarning texthl=SyntasticWarningSign"

" }}}

" Tabular {{{
Bundle 'godlygeek/tabular'

" }}}

" Tagbar {{{
Bundle 'majutsushi/tagbar'

let g:tagbar_iconchars = ['▾', '▸']
let g:tagbar_autofocus = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_autoclose = 1

nnoremap <C-o> :TagbarToggle<cr>
" }}}

" TComment {{{
Bundle 'tomtom/tcomment_vim'
" }}}

" Web-Indent {{{
Bundle 'lukaszb/vim-web-indent'

" }}}

" Golden Ratio {{{
" Bundle 'pekepeke/golden-ratio'

" let g:golden_ratio_ignore_ftypes = ['nerdtree']
" }}}

" RFC {{{
Bundle 'vheon/rfc-syntax'
"}}}

" }}}

" Vundle Installation 2 {{{
if g:vundle == 2
    BundleInstall
    quitall
endif
" }}}

" Mappings {{{

" General vim sanity improvements {{{


nnoremap Y y$

" }}}

" RSI Prevention - keyboard remaps {{{

" Certain things we do every day as programmers stress
" out our hands. For example, typing underscores and
" dashes are very common, and in position that require
" a lot of hand movement. Vim to the rescue

if has('mac')

    " TODO: check on gvim how to remap this
    " Now using the middle finger of either hand you can type
    " underscores with apple-k or apple-d, and add Shift
    " to type dashes
    imap <silent> <D-k> _
    imap <silent> <D-d> _
    imap <silent> <D-K> -
    imap <silent> <D-D> -
    cnoremap <D-k> _
    cnoremap <D-d> _
    cnoremap <D-K> -
    cnoremap <D-D> -
else
    imap <silent> <M-k> _
    imap <silent> <M-d> _
    imap <silent> <M-K> -
    imap <silent> <M-D> -
    cnoremap <M-k> _
    cnoremap <M-d> _
    cnoremap <M-K> -
    cnoremap <M-D> -
endif

" }}}

" Not use the arrow key in command line {{{

cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>

" }}}

" Remap ESC to a better shortcut. I've never type 'jj' anyway {{{
imap jj <ESC>
cmap jj <c-c>
" }}}

" Folding {{{
nnoremap <leader>z zMzvzz
" }}}

" Use tab for MatchIt
nnoremap <tab> %

" Swap ; with : in normal mode
nmap ; :

" Go to last edit location with ,.
nnoremap ,. '.

" Split Manipulation {{{

" Easy splits navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Resize splits
nnoremap <silent> + <c-w>+
nnoremap <silent> - <c-w>-
nnoremap <silent> > <c-w>>
nnoremap <silent> < <c-w><

" }}}

" Shortcuts for everyday tasks {{{

" Clean the last search
nmap <silent> <Leader>/ :nohlsearch<CR>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Quickly run the macro in the register q
nnoremap <Space> @q

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" shortcut for modify settings.vim file
cnoremap @@ ~/.vim/settings/

" Make selecting inside an HTML tag better
" TODO: maybe move this lines
vnoremap <silent> it itVkoj
vnoremap <silent> at atV

" Sudo to write
" stolen from Steve Losh
" cmap w!! w !sudo tee % >/dev/null
command! W exec 'w !sudo tee % > /dev/null' | e!

" Open the current buffer in the browser
if has('mac')
    nnoremap <F12> :exe ':silent !open -a "google chrome" %'<cr>
else
    nnoremap <F12> :exe ':silent !chromium %'<cr>
endif

" }}}

" }}}

" Reactivate the filetype recognition on indentation and plugins {{{
filetype on
filetype indent on
filetype plugin on
" }}}

" General Config {{{


syntax on " Turn on the syntax highlighting

set encoding=utf-8
set showcmd
set showmode
set backspace=indent,eol,start
set history=1000
set undolevels=1000
set number
set shortmess=atI
set autochdir
set autoread
set cursorline
set hidden

set timeoutlen=500 " Lower a little bit the timeout

set winaltkeys=no " usefull for mapping Alt key on linux

set fo-=o " Do not allow insertion of lead comment on 'o' or 'O' in normal mode
" }}}

" Turn Off Swap Files {{{

set noswapfile
set nobackup
set nowb
" }}}

" Search Settings {{{

set hlsearch
set incsearch
set ignorecase
set smartcase
" }}}

" Disable Sound and Visual Errors {{{

set noerrorbells
set novisualbell
set vb t_vb=
" }}}

" Indentation & Formatting {{{

set autoindent
set copyindent
set smartindent
set smarttab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

set formatoptions-=o " Do not automatically insert a comment leader after 'o' or 'O' in normal mode

set foldmethod=marker
"
"Display non visible characters, (tab, end of line and white spaces)
set list
set listchars=tab:▸\ ,eol:¬,trail:·,precedes:…,extends:…
set showbreak=↩\ 


set nowrap
" }}}

" Wildmenu Completion {{{

set wildmenu
set wildmode=list:longest
set wildignore=*.o,*.obj,*~
set wildignore+=*.DS_Store
set wildignore+=*.png,*.jpg,*.jpeg,*.gif
set wildignore+=*.mkv,*.avi
" }}}

" Scrolling {{{

set scrolloff=8
set sidescrolloff=7
" }}}

" Mouse {{{
if has('mouse')
    set mouse=a
endif
" }}}

" Statusline {{{
" set statusline=%{fugitive#statusline()}%r%F%m%h%w\ [Format:\ %{&ff}]\ [Type:\ %Y]\ [Lines:\ %L\ @\ %p%%\ {%l;%v}]
set laststatus=2
" }}}

" Avoid Bad Abits! {{{

map <Left>  <nop>
map <Right> <nop>
map <Up>    <nop>
map <Down>  <nop>

imap <Left>  <nop>
imap <Right> <nop>
imap <Up>    <nop>
imap <Down>  <nop>
" }}}

" Guard if for not load autocommand twice {{{

" TODO: find a better approach with this
"       maybe anoterh location?

if !exists('autocommands_loaded')
    let autocommands_loaded = 1

    " Reload all snippets when creating new ones
    au! BufWritePost *.snippets call ReloadAllSnippets()

    au BufEnter,WinEnter * set cursorline
    au BufLeave,WinLeave * set nocursorline

    au BufWritePost $MYVIMRC source $MYVIMRC | call Pl#Load()
    au BufWritePost ~/.vim/vimrc source ~/.vim/vimrc | call Pl#Load()
endif
" }}}

" Enable omni completion.{{{

" TODO: are these going to stay here?

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" }}}

" Appearance {{{

" Set colorscheme, fonts and other graphical thing
if has('gui_running')
    set t_Co=256

    set background=dark

    set guioptions-=r
    set guioptions-=R
    set guioptions-=l
    set guioptions-=L
    set guioptions-=T

    if has('gui_gtk2')
        " I love Anonymous pro, but ad 10pt sucks on my linuxbox monitor"
        " set guifont=Anonymous\ Pro\ for\ Powerline\ 10
        set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
    else
        set guifont=Anonymous\ Pro\ for\ Powerline:h12
    endif
endif

" }}}

" CopyPaste on Linux {{{

" Self made C-C, C-V. Just the few situation where I need
" Only for linux since on MacVim Cmd-C Cmd-V work out of the box
if !has("mac")
    nnoremap <C-a>  ggVG
    vnoremap <C-c>  "+y
    nnoremap <C-v>  "+gP
    inoremap <C-v>  <esc>"+gPa

    nnoremap <M-a>  ggVG
    vnoremap <M-c>  "+y
    vnoremap <M-v>  "+gP
    nnoremap <M-v>  "+gP
    inoremap <M-v>  <esc>"+gPa
endif

" }}}

" Random Functions {{{

" WrappingToggle {{{

" http://vimcasts.org/episodes/soft-wrapping-text/
function! s:WrappingToggle()
  if &wrap
      set nowrap nolinebreak list

      vunmap <D-j>
      vunmap <D-k>
      nunmap <D-j>
      nunmap <D-k>
  else
      set wrap linebreak nolist

      vmap <D-j> gj
      vmap <D-k> gk
      nmap <D-j> gj
      nmap <D-k> gk
  endif

endfunction


command! WrapToggle :call s:WrappingToggle()<cr>
" }}}

" ToggleSolarized {{{

function! s:ToggleSolarized()
    let g:Powerline_colorscheme = ( &background == "dark"? "lightSolarized" : "darkSolarized" )
    ToggleBG
    PowerlineReloadColorscheme
endfunction

command! ToggleSolarized call s:ToggleSolarized()


" Follow the symlink {{{
function! s:GoToOriginal()

    let b:orig_file = fnameescape(expand('%:p'))
    if getftype(b:orig_file) == 'link'
        let b:target_file = fnamemodify(resolve(b:orig_file))
          execute 'silent! file ' . fnameescape(b:target_file)
    endif
endfunction

"}}}
" }}}

" }}}
