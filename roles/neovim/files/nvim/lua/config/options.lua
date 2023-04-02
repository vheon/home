vim.g.mapleader = vim.api.nvim_replace_termcodes("<Space>", false, false, true)

-- I miss the different colors for visual, visual line and visual block
vim.opt.guicursor = {
  ["n-c-sm"] = "block-Cursor",
  ["v-ve"] = "block-IncSearch",
  ["i-ci-ve"] = "block-WildMenu",
  ["r-cr-o"] = "hor20-Cursor"
}

vim.opt.completeopt = vim.opt.completeopt - "preview"
vim.opt.completeopt = vim.opt.completeopt + "menuone"

vim.opt.pumheight = 30

vim.opt.timeoutlen = 500
vim.opt.updatetime = 750

vim.opt.lazyredraw = false
vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.hlsearch = false
vim.opt.cmdheight = 0
vim.opt.showmode = false

vim.opt.wildmode = { list = "longest" }

vim.opt.showcmd = false
vim.opt.autochdir = false

vim.opt.hidden = true
vim.opt.cursorline = true
vim.opt.colorcolumn = { 111 }

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

vim.opt.list = true
vim.opt.fillchars = {
  vert = "│",
  diff = "╱",
}
vim.opt.listchars = {
  tab = "→ ",
  trail = "␣",
  extends = "⇉",
  precedes = "⇇",
  nbsp = "⚭"
}

vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
