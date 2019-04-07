" https://github.com/rhysd/dotfiles/blob/af0e953113175f6e5ee1ed3f8b368dd76eb05ad0/vimrc#L16-L19
" highlight in after/syntax/vim.vim
augroup VimrcAutocmds
  autocmd!
augroup END
command! -nargs=* Autocmd autocmd VimrcAutocmds <args>

let g:mapleader="\<Space>"

" XXX(vheon): I kinda miss the update window of vim-plug
" test https://github.com/kristijanhusak/vim-packager which seems a "clone" of
" minpac but with that functionality

packadd minpac

call minpac#init({'status_open': 'tab'})

call minpac#add('k-takata/minpac', {'type': 'opt'})

call minpac#add('mhartington/oceanic-next')
call minpac#add('ayu-theme/ayu-vim')

call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-repeat')

call minpac#add('tpope/vim-fugitive')
call minpac#add('junegunn/gv.vim')

call minpac#add('justinmk/vim-dirvish')

" XXX(vheon): I really like the abbreviation but it always gets in the way
" when I'm writing comments
call minpac#add('tpope/vim-endwise')
let g:endwise_abbreviations = 1

call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-abolish')
call minpac#add('tpope/vim-rsi')

call minpac#add('PeterRincker/vim-argumentative')

call minpac#add('Valloric/YouCompleteMe', { 'do': {-> system('./install.py')}})
let g:ycm_confirm_extra_conf    = 0
let g:ycm_complete_in_comments  = 1
" let g:ycm_global_ycm_extra_conf = g:dotvim.'/ycm_extra_conf.py'
" let g:ycm_extra_conf_vim_data   = [ '&filetype' ]
" let g:ycm_seed_identifiers_with_syntax = 1
" let g:ycm_filetype_blacklist = { 'help': 1 }
" let g:ycm_key_list_stop_completion = ['']

call minpac#add('tpope/vim-scriptease')

call minpac#add('vim-jp/cpp-vim')
call minpac#add('octol/vim-cpp-enhanced-highlight')

call minpac#add('junegunn/fzf', { 'dir': '~/.fzf', 'do': {-> system('./install --all')}})
call minpac#add('junegunn/fzf.vim')
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = &lines * 40 / 100
  let width = &columns

  let opts = {
        \ 'relative': 'editor',
        \ 'anchor': 'SW',
        \ 'row': &lines,
        \ 'col': 1,
        \ 'width': width,
        \ 'height': height
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction
nnoremap <silent> <Leader>fg :GFiles<cr>
nnoremap <silent> <Leader>ff :Files<cr>
nnoremap <silent> <Leader>fb :Buffers<cr>

set termguicolors
" XXX(vheon): set guicursor!
let ayucolor="mirage"
silent! colorscheme ayu

set completeopt-=preview
set completeopt+=menuone
set pumheight=30

set timeoutlen=500
set updatetime=750

set lazyredraw
set smartcase
set ignorecase
set nohlsearch

let g:status_search = ''
let &statusline  = ''
let &statusline .= '%h%w '
let &statusline .= '%<%f '
let &statusline .= '%{fugitive#statusline()}'
let &statusline .= '%{g:status_search}'
let &statusline .= '%-4(%m%r%)'
let &statusline .= '%{&paste ? "P" : ""}'
let &statusline .= '%='
let &statusline .= '%y '
let &statusline .= '%-14(%P %3l:%02c%)'
let &statusline .= '[%{strlen(&l:fenc) ? &enc : &l:fenc}]'

set cmdheight=2
set noshowmode
set wildmode=list:longest

set noshowcmd

set noautochdir
set hidden
set cursorline
set colorcolumn=111

set noswapfile
set nobackup
set nowritebackup

set list
let &fillchars = "vert:\u2502"
let &listchars = "tab:\u2192 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"

" more consistent with other operator
nnoremap Y y$

" Practical Vim tip #34
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>

" http://vimcasts.org/episodes/the-edit-command
" https://twitter.com/garybernhardt/status/40292706609532928
cnoremap %% <C-R>=printf( '%s%s',
                        \ fnamemodify(expand('%', 1), ':p:h'),
                        \ (!exists("+shellslash") + &shellslash) ? '/' : '\')<CR>
nmap <leader>e. :edit %%

nnoremap <C-n> :set invnumber<cr>

" CTRL-U and CTRL-W in insert mode cannot be undone.  Use CTRL-G u to first
" break undo, so that we can undo those changes after inserting a line break.
" For more info, see: http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

Autocmd BufEnter,WinEnter,InsertLeave * set cursorline
Autocmd BufLeave,WinLeave,InsertEnter * set nocursorline

Autocmd BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 1 && line("'\"") <= line("$")
                   \|   execute 'normal! g`"'
                   \| endif

" Poor man vim-rooter, git only, using fugitive
Autocmd BufLeave * let b:last_cwd = getcwd()
Autocmd BufEnter * if exists('b:last_cwd')
                \|   execute 'lcd' escape(b:last_cwd, ' ')
                \| else
                \|   silent! Glcd
                \| endif

Autocmd BufWinEnter *.txt if &buftype == 'help' | wincmd T | endif
