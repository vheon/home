require "config.options"
require "config.lazy"
require "config.mappings"
require "config.ui"
require "config.clipboard"


-- XXX(andrea): This could be a plugin on its own??
vim.cmd [[
command! -nargs=* SetIndent call functions#SetIndent(<f-args>)
command! -nargs=+ Expandtab call functions#Expandtab(<f-args>)
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
" https://github.com/rhysd/dotfiles/blob/af0e953113175f6e5ee1ed3f8b368dd76eb05ad0/vimrc#L16-L19
" highlight in after/syntax/vim.vim
augroup VimrcAutocmds
  autocmd!
augroup END
command! -nargs=* Autocmd autocmd VimrcAutocmds <args>
]]

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
