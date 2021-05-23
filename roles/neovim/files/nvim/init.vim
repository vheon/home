" https://github.com/rhysd/dotfiles/blob/af0e953113175f6e5ee1ed3f8b368dd76eb05ad0/vimrc#L16-L19
" highlight in after/syntax/vim.vim
augroup VimrcAutocmds
  autocmd!
augroup END
command! -nargs=* Autocmd autocmd VimrcAutocmds <args>

let g:mapleader="\<Space>"

lua << EOF
-- These are a couple of helpers function to define mappings for plugins.
-- When packer compiles the configuration all the function has to be either
-- local to the `config` function or global. I'm putting them here for now.
_G.map = function(lhs, rhs, opts)
  opts = opts or {}
  opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts)
  if not opts.buffer then
    vim.api.nvim_set_keymap('n', lhs, rhs, opts)
  else
    local buffer = opts.buffer
    if buffer == true then
      buffer = 0
    end
    opts.buffer = nil

    vim.api.nvim_buf_set_keymap(bufnr, 'n', lhs, rhs, opts)
  end
end
_G.always_require = function(module)
  package.loaded[module] = nil
  return require(module)
end

vim.cmd [[command! PackerInstall  lua always_require'plugins'.install()]]
vim.cmd [[command! PackerUpdate   lua always_require'plugins'.update()]]
vim.cmd [[command! PackerSync     lua always_require'plugins'.sync()]]
vim.cmd [[command! PackerClean    lua always_require'plugins'.clean()]]
vim.cmd [[command! PackerCompile  lua always_require'plugins'.compile()]]

_G.statusline = require'statusline'.line
_G.tabline = require'tabline'.line
EOF
set statusline=%!v:lua.statusline()
set tabline=%!v:lua.tabline()

set termguicolors
" I miss the different colors for visual, visual line and visual block
set guicursor=n-c-sm:block-Cursor,v-ve:block-IncSearch,i-ci-ve:block-WildMenu,r-cr-o:hor20-Cursor

set completeopt-=preview
set completeopt+=menuone
set pumheight=30

set timeoutlen=500
set updatetime=750

set lazyredraw
set smartcase
set ignorecase
set nohlsearch

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

command! -nargs=* SetIndent call functions#SetIndent(<f-args>)
command! -nargs=+ Expandtab call functions#Expandtab(<f-args>)

" more consistent with other operator
nnoremap Y y$

" possible mnemonic? let say is for YELL
inoremap <C-y> <esc>gUiw`]a

" Practical Vim tip #34
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>

" http://vimcasts.org/episodes/the-edit-command
" https://twitter.com/garybernhardt/status/40292706609532928
cnoremap %% <C-R>=printf( '%s%s',
                        \ fnamemodify(expand('%', 1), ':p:h'),
                        \ (!exists("+shellslash") + &shellslash) ? '/' : '\')<CR>
nmap <leader>e. :edit %%
nmap <leader>ev :tabnew $MYVIMRC<cr>
nnoremap <leader>rv <cmd>source $MYVIMRC<cr>

nnoremap <C-n> :set invnumber<cr>

nmap mw <Plug>(SimpleMark)
nnoremap <silent> <C-L> :nohlsearch<cr>:MarkClearAll<cr><C-L>

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
Autocmd FileType help nnoremap <silent><buffer> gq :q!<cr>

Autocmd TermOpen term://* startinsert

function! SwitchSourceHeader()
  if (expand ("%:e") == "cpp")
    find %:t:r.h
  else
    find %:t:r.cpp
  endif
endfunction

nmap <Leader>af :call SwitchSourceHeader()<CR>

lua << EOF
vim.g.clipboard = {
  name = 'clipper',
  copy = {
    ['+'] = {'nc', 'localhost', '8377'},
    ['*'] = {'nc', 'localhost', '8377'}
  },
  paste = { ['+'] = {}, ['*'] = {} },
  cache_enabled = 1
}
EOF
