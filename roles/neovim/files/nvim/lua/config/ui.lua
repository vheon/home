vim.opt.laststatus = 2
vim.opt.showtabline = 2

vim.opt.termguicolors = true
vim.cmd.colorscheme "catppuccin"

local augroup = vim.api.nvim_create_augroup("config/ui.lua", { clear = true })
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

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
  group = augroup,
  desc = [[resize splits if window got resized]],
})

local icons = require "config.icons"

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.error,
      [vim.diagnostic.severity.WARN] = icons.diagnostics.warn,
      [vim.diagnostic.severity.HINT] = icons.diagnostics.hint,
      [vim.diagnostic.severity.INFO] = icons.diagnostics.info,
    },
  },
})
