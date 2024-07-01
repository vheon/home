local datadir = vim.fn.stdpath("data") --[[@as string]]
vim.opt.rtp:prepend(vim.fs.joinpath(datadir, "lazy", "lazy.nvim"))

require("lazy").setup("plugins", {
    install = {
        colorscheme = { "catppuccin" },
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "zip",
                "zipPlugin",
                "tar",
                "tarPlugin",
                "getscript",
                "getscriptPlugin",
                "vimball",
                "vimballPlugin",
                "2html_plugin",
                "netrw",
                "netrwPlugin",
                "netrwSettings",
            },
        },
    },
    dev = {
        path = "~/code/"
    },
})
