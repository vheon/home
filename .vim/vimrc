"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

"activate pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

syntax on

set nobackup
set showcmd
set showmode

set noerrorbells
set novisualbell

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

"load ftplugins and indent files
filetype plugin on
filetype indent on

"turn on syntax highlighting
syntax on

set statusline=%F%m%r%h%w\ [Format:\ %{&ff}]\ [Type:\ %Y]\ [Lines:\ %L\ @\ %p%%\ {%l;%v}]
set laststatus=2

"Mappings for save and quit
nmap q :q<CR>
nmap Q :q!<CR>
nmap w :w<CR>
nmap W :wq<CR>

" Remap ESC to a better shortcut. I've never type 'jj' anyway
imap jj <ESC>

function ColorColumnToggle()
	if &colorcolumn
		set colorcolumn=
	else
		set colorcolumn=81
	endif
endfunction
