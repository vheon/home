" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" =============== Pathogen Initialization ===============
" This loads all the plugins in ~/.vim/bundle
" Use tpope's pathogen plugin to manage all other plugins

" Disable the filetype recognition to be sure to run always pathogen
filetype off

runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


" =============== General Config ===============

" Turn on the syntax highlighting
syntax on

set encoding=utf-8
set showcmd
set showmode
set backspace=indent,eol,start
set history=1000
set undolevels=1000
set number
set shortmess=a
set autochdir
set autoread
set cursorline
set hidden

" =============== Turn Off Swap Files ===============

set noswapfile
set nobackup
set nowb

" =============== Search Settings ===============

set hlsearch
set incsearch
set ignorecase
set smartcase

" =========== Disable Sound and Visual Errors ===========

set noerrorbells
set novisualbell
set vb t_vb=

" =============== Indentation ===============

set autoindent
set copyindent
set smartindent
set smarttab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

" Reactivate the filetype recognition on indentation and plugins
filetype on
filetype indent on
filetype plugin on

"Display non visible characters, (tab, end of line and white spaces)
set list
set listchars=tab:▸\ ,eol:¬,trail:·

set nowrap

" =============== Completion ===============

set wildmode=list:longest
set wildmenu
set wildignore=*.o,*.obj,*~
set wildignore+=*DS_Store*
set wildignore+=*.png,*.jpg,*.jpeg,*.gif

" =============== Scrolling ===============

set scrolloff=8
set sidescrolloff=7

" =============== Mouse ===============
if has('mouse')
    set mouse=a
endif

" Just an attempt to separate configuration
" stolen from yadr - https://github.com/skwp/dotfiles
for file in split(glob('~/.vim/settings/*.vim'), '\n')
    exe 'source' file
endfor

set statusline=%F%m%r%h%w\ [Format:\ %{&ff}]\ [Type:\ %Y]\ [Lines:\ %L\ @\ %p%%\ {%l;%v}]
set laststatus=2

" Change the mapleader from \ to ,
let mapleader=","

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>


let Tlist_WinWidth = 35
let Tlist_Display_Tag_Scope = 1
let Tlist_Use_Right_Window = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Show_One_File = 1
let Tlist_Process_File_Always = 1
let Tlist_Show_Menu = 1

"Mappings for save and quit
"nmap q :q<CR>
"nmap Q :q!<CR>
"nmap w :w<CR>
"nmap W :wq<CR>

" Easy splits navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Clean the last search
nmap <silent> // :nohlsearch<CR>

" Sudo to write
" stolen from Steve Losh
cmap w!! w !sudo tee % >/dev/null

" Remap ESC to a better shortcut. I've never type 'jj' anyway
imap jj <ESC>
cmap jj <c-c>

" Use screen scroll instead of line scroll
nmap j gj
nmap k gk

" Try to jump the right delimiter
inoremap <leader><Tab> <C-R>=delimitMate#JumpAny("\<leader><Tab>")<CR>

let g:snippets_dir = '~/.vim/snippets_storage/'


" Swap ; with : in normal mode
nmap ; :

" Guard if for not load autocommand twice
if !exists('autocommands_loaded')
    let autocommands_loaded = 1

    " Reload all snippets when creating new ones
    au! BufWritePost *.snippets call ReloadAllSnippets()
endif

function! ColorColumnToggle()
    if &colorcolumn
        set colorcolumn=
    else
        set colorcolumn=81
endfunction
