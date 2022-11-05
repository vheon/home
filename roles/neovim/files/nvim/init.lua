vim.cmd [[
" https://github.com/rhysd/dotfiles/blob/af0e953113175f6e5ee1ed3f8b368dd76eb05ad0/vimrc#L16-L19
" highlight in after/syntax/vim.vim
augroup VimrcAutocmds
  autocmd!
augroup END
command! -nargs=* Autocmd autocmd VimrcAutocmds <args>
]]

-- Disable unused plugins
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1

vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1

-- XXX(andrea): disable this if I try to use monkoose/matchparen.nvim
-- vim.g.loaded_matchparen = 1
-- vim.g.loaded_matchit = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1

vim.g.mapleader = vim.api.nvim_replace_termcodes("<Space>", false, false, true)

_G.always_require = function(module)
  package.loaded[module] = nil
  return require(module)
end

vim.api.nvim_create_user_command('PackerInstall', function() always_require'plugins'.install() end, {})
vim.api.nvim_create_user_command('PackerUpdate', function() always_require'plugins'.update() end, {})
vim.api.nvim_create_user_command('PackerSync', function() always_require'plugins'.sync() end, {})
vim.api.nvim_create_user_command('PackerClean', function() always_require'plugins'.clean() end, {})
vim.api.nvim_create_user_command('PackerCompile', function() always_require'plugins'.compile() end, {})

_G.statusline = require'statusline'.line
_G.tabline = require'tabline'.line

vim.opt.statusline = "%!v:lua.statusline()"
vim.opt.tabline = "%!v:lua.tabline()"

vim.cmd [[colorscheme terafox]]

vim.opt.guicursor = { "n-c-sm:block-Cursor", "v-ve:block-IncSearch", "i-ci-ve:block-WildMenu", "r-cr-o:hor20-Cursor" }

vim.opt.completeopt = vim.opt.completeopt - "preview"
vim.opt.completeopt = vim.opt.completeopt + "menuone"
vim.opt.pumheight = 30

vim.opt.timeoutlen = 500
vim.opt.updatetime = 750

vim.opt.lazyredraw = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.hlsearch = false

vim.opt.cmdheight = 2
vim.opt.showmode = false
vim.opt.wildmode = "list:longest"

vim.opt.showcmd = false

vim.opt.autochdir = false
vim.opt.hidden = true
vim.opt.cursorline = true
vim.opt.colorcolumn = { 111 }

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

vim.opt.list = true
vim.opt.fillchars = { vert = "│", diff = "╱" }
vim.opt.listchars = { tab = "→ ", trail = "␣", extends = "⇉", precedes = "⇇", nbsp = "⚭" }

-- XXX(andrea): This could be a plugin on its own??
vim.cmd [[
command! -nargs=* SetIndent call functions#SetIndent(<f-args>)
command! -nargs=+ Expandtab call functions#Expandtab(<f-args>)
]]

-- possible mnemonic? let say is for YELL
vim.keymap.set("i", "<C-y>", "<esc>gUiw`]a")

-- Practical Vim tip #34
vim.keymap.set( "c", "<C-n>", "<Down>")
vim.keymap.set( "c", "<C-p>", "<Up>")

-- XXX(andrea): these needs to be ported properly
-- http://vimcasts.org/episodes/the-edit-command
-- https://twitter.com/garybernhardt/status/40292706609532928
vim.cmd [[
cnoremap %% <C-R>=printf( '%s%s',
                        \ fnamemodify(expand('%', 1), ':p:h'),
                        \ (!exists("+shellslash") + &shellslash) ? '/' : '\')<CR>
nmap <leader>e. :edit %%
nmap <leader>ev :tabnew $MYVIMRC<cr>
nnoremap <leader>rv <cmd>source $MYVIMRC<cr>
]]

vim.keymap.set("n", "<C-n>", "<cmd>set invnumber<cr>")

vim.keymap.set("n", "mw", "<Plug>(SimpleMark)")
vim.keymap.set("n", "<C-l>", "<cmd>nohlsearch<cr>:MarkClearAll<cr><C-L>", { silent = true })


local augroup = vim.api.nvim_create_augroup('init.lua', { clear = true })
vim.api.nvim_create_autocmd({"BufEnter", "WinEnter", "InsertLeave"}, {
          callback = function() vim.opt.cursorline = true end,
          group = augroup,
          desc = [[Set cursorline in normal mode]]
})
vim.api.nvim_create_autocmd({"BufLeave", "WinLeave", "InsertEnter"}, {
          callback = function() vim.opt.cursorline = false end,
          group = augroup,
          desc = [[Do not render cursorline in insert mode]]
})
vim.cmd [[
Autocmd BufEnter,WinEnter,InsertLeave * set cursorline
Autocmd BufLeave,WinLeave,InsertEnter * set nocursorline
]]

-- XXX(andrea): are these really better than the vimscript counterpart?
-- XXX(andrea): I should probably do nothing if the buffer is a command-t buffer or a prompt buffer in general
-- vim.api.nvim_create_autocmd("BufLeave", {
--   callback = function() vim.b.last_cwd = vim.fn.getcwd() end,
--   group = augroup
-- })
-- vim.api.nvim_create_autocmd("BufEnter", {
--   callback = function()
--     local last_cwd = vim.b.last_cwd
--     if last_cwd ~= nil then
--       vim.api.nvim_cmd { cmd = "lcd", args = vim.fn.escape(last_cwd, ' ') }
--     else
--       vim.cmd "silent! Glcd"
--     end
--   end,
--   group = augroup
-- })
-- Poor man vim-rooter, git only, using fugitive

vim.cmd [[
Autocmd BufLeave * let b:last_cwd = getcwd()
Autocmd BufEnter * if exists('b:last_cwd')
                \|   execute 'lcd' escape(b:last_cwd, ' ')
                \| else
                \|   silent! Glcd
                \| endif

Autocmd BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 1 && line("'\"") <= line("$")
                   \|   execute 'normal! g`"'
                   \| endif

" XXX(andrea): should look if a help window is already open and use that instead.
" XXX(andrea): might be worth it to open the doc in a temp floating window??
Autocmd BufWinEnter *.txt if &buftype == 'help' | wincmd T | endif

" XXX(andrea): this should move to an after/ftplugin
Autocmd FileType help nnoremap <silent><buffer> gq :q!<cr>

Autocmd TermOpen term://* startinsert
tnoremap <C-\>b <C-\><C-N>? <cr>
]]

vim.cmd [[
function! SwitchSourceHeader()
  if (expand ("%:e") == "cpp")
    find %:t:r.h
  else
    find %:t:r.cpp
  endif
endfunction
nmap <Leader>af :call SwitchSourceHeader()<CR>
]]


-- XXX(andrea): start using in-house lua implementation instead of shelling out to python
vim.cmd [[
map <leader>gq :py3f /usr/share/clang/clang-format-12/clang-format.py<cr>
]]

require "clipboard"

-- XXX(andrea): this is probably not the best place to put this... even if I
-- change the colorscheme this signs definition would still be valid...
vim.fn.sign_define(
  "DiagnosticSignError",
  { text = " ", texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" }
)
vim.fn.sign_define(
  "DiagnosticSignWarn",
  { text = " ", texthl = "DiagnosticSignWarn", numhl = "DiagnosticSignWarn" }
)
vim.fn.sign_define(
  "DiagnosticSignInfo",
  { text = " ", texthl = "DiagnosticSignInfo", numhl = "DiagnosticSignInfo" }
)
vim.fn.sign_define(
  "DiagnosticSignHint",
  { text = " ", texthl = "DiagnosticSignHint", numhl = "DiagnosticSignHint" }
)
