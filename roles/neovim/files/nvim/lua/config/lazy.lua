vim.opt.rtp:prepend(vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "lazy.nvim"))

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
