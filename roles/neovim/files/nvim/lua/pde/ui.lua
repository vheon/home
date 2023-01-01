require "statusline"
vim.opt.showtabline = 2
_G.tabline = require("tabline").line

-- vim.opt.statusline = "%!v:lua.statusline()"
vim.opt.tabline = "%!v:lua.tabline()"

vim.opt.termguicolors = true
vim.cmd.colorscheme "catppuccin"

local augroup = vim.api.nvim_create_augroup("init.lua", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "InsertLeave" }, {
    callback = function()
        vim.opt.cursorline = true
    end,
    group = augroup,
    desc = [[Set cursorline in normal mode]],
})
vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave", "InsertEnter" }, {
    callback = function()
        vim.opt.cursorline = false
    end,
    group = augroup,
    desc = [[Do not render cursorline in insert mode]],
})

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
