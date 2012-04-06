"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

"activate pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

if has("gui_running")
	if has("gui_gtk2")
		set guifont=ProggyCleanTTSZ\ 12
	else
		set guifont=Courier\ New:h12
	endif
endif

syntax on

set nobackup
set showcmd
set showmode

set noerrorbells
set novisualbell
set vb t_vb=

set hidden
set mouse=a

set autoindent
set smartindent
set smarttab
set smartcase

set showmatch


set hlsearch
set incsearch

set history=1000

set number
set ruler

set shiftwidth=4
set tabstop=4
set softtabstop=4
set noexpandtab

set scrolloff=3
set sidescrolloff=7

set autochdir
set shortmess=a

set wildmode=longest:full
set wildmenu

"turn on syntax highlighting
syntax on

"load ftplugins and indent files
filetype on
filetype plugin on
filetype indent on

set statusline=%F%m%r%h%w\ [Format:\ %{&ff}]\ [Type:\ %Y]\ [Lines:\ %L\ @\ %p%%\ {%l;%v}]
set laststatus=2

let mapleader=","

"Mappings for save and quit
nmap q :q<CR>
nmap Q :q!<CR>
nmap w :w<CR>
nmap W :wq<CR>

" Remap ESC to a better shortcut. I've never type 'jj' anyway
imap jj <ESC>

function! ColorColumnToggle()
	if &colorcolumn
		set colorcolumn=
	else
		set colorcolumn=81
	endif
endfunction
