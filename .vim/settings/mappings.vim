" Arpeggio lets us define key-chord combos (simultaneous key pressed)
call arpeggio#load()

" ========================================
" General vim sanity improvements
" ========================================
"
"
" Change the mapleader from \ to ,
let mapleader=","

"make Y consistent with C and D
nnoremap Y y$

" ========================================
" RSI Prevention - keyboard remaps
" ========================================
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

" ========================================
" Not use the arrow key in command line
" ========================================

cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>


" Use the two first fingers on both sides of the keyboard
" simultaneously to go to the first written character of the line,
" the beginning or end of line
Arpeggio nnoremap kj $
Arpeggio nnoremap fd ^
Arpeggio nnoremap fs 0

" Same thing, but in command line mode
Arpeggio cnoremap jk <end>
Arpeggio cnoremap df <home>


" Remap ESC to a better shortcut. I've never type 'jj' anyway
imap jj <ESC>
cmap jj <c-c>

" Swap ; with : in normal mode
nmap ; :

" Try to jump the right delimiter
inoremap <leader><Tab> <C-R>=delimitMate#JumpAny("\<leader><Tab>")<CR>

" Go to last edit location with ,.
nnoremap ,. '.

" =======================================
"           Split Manipulation
" =======================================
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

" ============================
" Shortcuts for everyday tasks
" ============================

" Use screen scroll instead of line scroll
" nmap j gj
" nmap k gk

" Clean the last search
nmap <silent> <Leader>z :nohlsearch<CR>

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

