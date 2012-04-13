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
"
"Display non visible characters, (tab, end of line and white spaces)
set list
set listchars=tab:▸\ ,eol:¬,trail:·

set nowrap

" Reactivate the filetype recognition on indentation and plugins
filetype on
filetype indent on
filetype plugin on

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


set statusline=%F%m%r%h%w\ [Format:\ %{&ff}]\ [Type:\ %Y]\ [Lines:\ %L\ @\ %p%%\ {%l;%v}]
set laststatus=2


" TODO: find a better approach with this
"       maybe anoterh location?
"
" Guard if for not load autocommand twice
if !exists('autocommands_loaded')
    let autocommands_loaded = 1

    " Reload all snippets when creating new ones
    au! BufWritePost *.snippets call ReloadAllSnippets()
endif

" TODO: are these going to stay here?

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Just an attempt to separate configuration
" stolen from yadr - https://github.com/skwp/dotfiles
for file in split(glob('~/.vim/settings/*.vim'), '\n')
    exe 'source' file
endfor
