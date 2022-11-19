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

require "pde.options"
require "pde.ui"

-- XXX(andrea): This could be a plugin on its own??
vim.cmd [[
command! -nargs=* SetIndent call functions#SetIndent(<f-args>)
command! -nargs=+ Expandtab call functions#Expandtab(<f-args>)
]]

-- possible mnemonic? let say is for YELL
vim.keymap.set("i", "<C-y>", function()
    local cmp = require "cmp"
    if cmp.visible() then
        cmp.mapping.confirm({ select = false })
        return "<Ignore>"
    end
    return "<esc>gUiw`]a"
end, { expr = true })

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

vim.keymap.set({ "n", "v" }, "<leader>gq", function()
    local clang_format = require "clang-format"

    local function get_range()
        if vim.api.nvim_get_mode().mode:match "[vV]" ~= nil then
            local bufnr = vim.api.nvim_get_current_buf()
            return vim.api.nvim_buf_get_mark(bufnr, "<")[1], vim.api.nvim_buf_get_mark(bufnr, ">")[1]
        end
    end

    local line_start, line_end = get_range()
    vim.schedule(function()
        clang_format.format(line_start, line_end)
    end)

    return "<Esc>"
end, { expr = true })

require "clipboard"
