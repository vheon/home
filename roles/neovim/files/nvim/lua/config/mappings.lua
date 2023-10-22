-- possible mnemonic? let say is for YELL
vim.keymap.set("i", "<C-y>", function()
    local cmp = require "cmp"
    if cmp.visible() then
        cmp.mapping.confirm { select = false }
        return "<Ignore>"
    end
    return "<esc>gUiw`]a"
end, { expr = true })

-- Practical Vim tip #34
vim.keymap.set("c", "<C-n>", "<Down>")
vim.keymap.set("c", "<C-p>", "<Up>")

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

vim.keymap.set({ "n", "v" }, "<leader>gq", function()
    local clang_format = require "clang-format"

    local function get_range()
        local mode = vim.api.nvim_get_mode().mode
        if mode == "v" or mode == "V" then
            local start_row = vim.fn.getpos('v')[2]
            local end_row = vim.fn.getpos('.')[2]

            if end_row < start_row then
                start_row, end_row = end_row, start_row
            end
            return start_row, end_row
        end
    end

    local line_start, line_end = get_range()
    vim.schedule(function()
        clang_format.format(line_start, line_end)
    end)

    return "<Esc>"
end, { expr = true })

local toggle_term_key = "<C-\\><C-\\>"
vim.keymap.set("n", toggle_term_key, function()
    require("config.float_term").float_term(nil, { cwd = ".", toggle_key = toggle_term_key, border = "rounded" })
end, { desc = "Terminal (root dir)" })


